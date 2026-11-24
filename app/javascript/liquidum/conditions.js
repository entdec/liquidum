// Conditions on Liquid variables in the browser, as Liquidum::Conditions
// works them out on the server: "if [all] of the following conditions are
// met: [screening.state] [is] [processed]", with Mensa's operators. Both are
// tested with the cases in test/fixtures/files/conditions_cases.json, so a
// form or an automation's test run in the browser goes the way the server
// will.
//
// The values are JSON as the server sends a drop (strings, numbers, true and
// false, lists, objects), and Dates: a value compares as a date when it is a
// Date, as on the server when it is one there.
//
//   import { met } from "liquidum/conditions"
//   met({ match: "all", rules: [{ variable: "ticket.priority", operator: "is", value: "urgent" }] }, { ticket })

export const MATCHES = ["all", "any"]
export const OPERATORS = ["is", "isnt", "matches", "does_not_match", "gt", "gteq", "lt", "lteq", "between", "is_empty", "isnt_empty"]
export const WITHOUT_VALUE = ["is_empty", "isnt_empty"]
const TRUE_VALUES = ["true", "yes", "ja", "1", "y", "j"]
// What BigDecimal() takes
const NUMBER = /^[-+]?(\d+(_\d+)*(\.(\d+(_\d+)*)?)?|\.\d+(_\d+)*)([eE][-+]?\d+)?$/
const DATE = /^(\d{4})-(\d{2})-(\d{2})/

// Whether the values meet {match, rules}, as Liquidum::Conditions#met?
export function met(conditions = {}, values = {}) {
  const rules = parse(conditions?.rules)
  if (!rules.length) return true

  const results = (rule) => compare(rule, valueAt(values, rule.variable))
  return conditions.match === "any" ? rules.some(results) : rules.every(results)
}

// The rules that count, as Liquidum::Conditions has them: with a variable and
// a known operator; numbered as a form sends them, or a list
export function parse(rules) {
  const list = Array.isArray(rules) ? rules : rules && typeof rules === "object" ? Object.values(rules) : []
  return list
    .filter((rule) => rule && typeof rule === "object" && String(rule.variable ?? "").trim() && OPERATORS.includes(rule.operator))
    .map((rule) => ({ variable: String(rule.variable).trim(), operator: rule.operator, value: String(rule.value ?? "").trim(), value_to: String(rule.value_to ?? "").trim() }))
}

// A variable's value as Liquid looks it up: "contract.lines[0].amount",
// "contract.lines.size", first and last; null when it isn't there
export function valueAt(values, variable) {
  const steps = String(variable)
    .replace(/\[(\d+)\]/g, ".$1")
    .replace(/\[["']([^"']*)["']\]/g, ".$1")
    .split(".")
    .filter((step) => step !== "")
  let current = values
  for (const step of steps) {
    current = stepInto(current, step)
    if (current === undefined) return null
  }
  return current === undefined ? null : current
}

function stepInto(current, step) {
  if (current == null || typeof current !== "object" || current instanceof Date) {
    return typeof current === "string" && step === "size" ? current.length : undefined
  }
  if (Array.isArray(current)) {
    if (/^-?\d+$/.test(step)) return current.at(Number(step))
    if (step === "size") return current.length
    if (step === "first") return current[0]
    if (step === "last") return current.at(-1)
    return undefined
  }
  if (Object.hasOwn(current, step)) return current[step]
  if (step === "size") return Object.keys(current).length
  return undefined
}

function compare(rule, actual) {
  const order = (value) => orderOf(actual, value)
  switch (rule.operator) {
    case "is_empty":
      return isEmpty(actual)
    case "isnt_empty":
      return !isEmpty(actual)
    case "is":
      return equal(actual, rule.value)
    case "isnt":
      return !equal(actual, rule.value)
    case "matches":
      return text(actual).includes(rule.value.toLowerCase())
    case "does_not_match":
      return !text(actual).includes(rule.value.toLowerCase())
    case "gt":
      return order(rule.value) > 0
    case "gteq":
      return order(rule.value) >= 0
    case "lt":
      return order(rule.value) < 0
    case "lteq":
      return order(rule.value) <= 0
    case "between": {
      const from = order(rule.value)
      const to = order(rule.value_to)
      return from >= 0 && to <= 0
    }
  }
  return false
}

function isEmpty(actual) {
  if (actual == null) return true
  if (typeof actual === "string" || Array.isArray(actual)) return actual.length === 0
  if (typeof actual === "object" && !(actual instanceof Date)) return Object.keys(actual).length === 0
  return false
}

// A list is one of its elements; true and false also as yes or ja
function equal(actual, value) {
  if (Array.isArray(actual)) return actual.some((element) => equal(element, value))
  if (typeof actual === "boolean") return actual === TRUE_VALUES.includes(value.toLowerCase())
  return orderOf(actual, value) === 0 || text(actual) === value.toLowerCase()
}

function text(actual) {
  const list = Array.isArray(actual) ? actual : actual == null ? [] : [actual]
  return list.map((element) => (element instanceof Date ? element.toISOString().slice(0, 10) : String(element))).join(", ").toLowerCase()
}

// actual <=> value, with value as a number or date when actual is one; NaN
// when they can't be compared, so every comparison with it is false
function orderOf(actual, value) {
  let other
  if (typeof actual === "number") other = NUMBER.test(value) ? Number(value.replaceAll("_", "")) : null
  else if (actual instanceof Date) other = date(value)
  else if (typeof actual === "string") other = value
  if (other == null) return NaN

  const [a, b] = actual instanceof Date ? [actual.getTime(), other.getTime()] : [actual, other]
  return a < b ? -1 : a > b ? 1 : 0
}

function date(value) {
  const match = String(value).match(DATE)
  if (!match) return null
  const [year, month, day] = match.slice(1).map(Number)
  const result = new Date(Date.UTC(year, month - 1, day))
  return result.getUTCMonth() === month - 1 && result.getUTCDate() === day ? result : null
}
