// Conditions in the browser (app/javascript/liquidum/conditions.js), with the
// cases the server is tested with too (test/models/liquidum/conditions_test.rb):
// both have to agree.

import { test } from "node:test"
import assert from "node:assert/strict"
import { readFileSync } from "node:fs"
import { met, parse, valueAt } from "../../app/javascript/liquidum/conditions.js"

const CASES = JSON.parse(readFileSync(new URL("../fixtures/files/conditions_cases.json", import.meta.url), "utf8"))

// {"$date": "2027-03-10"} is a date
function valuesOf(value) {
  if (Array.isArray(value)) return value.map(valuesOf)
  if (value && typeof value === "object") {
    const keys = Object.keys(value)
    if (keys.length === 1 && keys[0] === "$date") return new Date(`${value.$date}T00:00:00Z`)
    return Object.fromEntries(Object.entries(value).map(([key, element]) => [key, valuesOf(element)]))
  }
  return value
}

for (const example of CASES.cases) {
  test(`a case: ${example.name}`, () => {
    assert.equal(met({ match: example.match, rules: example.rules }, valuesOf(example.values)), example.met)
  })
}

test("the rules that count, as the server keeps them", () => {
  assert.deepEqual(parse({ 0: { variable: " user.state ", operator: "is", value: 1 }, 1: { variable: "", operator: "is" }, 2: { variable: "x", operator: "sounds_like" } }), [{ variable: "user.state", operator: "is", value: "1", value_to: "" }])
  assert.equal(met(), true)
  assert.equal(met(null, {}), true)
})

test("a variable is looked up as Liquid does", () => {
  const values = { order: { lines: [{ amount: 1 }, { amount: 2 }], "tag-list": ["a"] } }
  assert.equal(valueAt(values, "order.lines[1].amount"), 2)
  assert.equal(valueAt(values, "order['tag-list'].first"), "a")
  assert.equal(valueAt(values, "order.nothing.deeper"), null)
})
