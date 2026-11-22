# Liquidum

Simplified use of Shopify's liquid, including some handy filters, tags and drops.

## Usage

Basically it's as easy as:

```ruby
Liquidum.render("{{payload.test}}", assigns: { 'payload' => { 'test' => 'blah' } })
```

## Translations

The `t` filter translates a key with I18n, in the current locale or the one
given, with the other arguments interpolated:

```liquid
{{ 'orders.greeting' | t: name: customer.name }}
{{ 'orders.greeting' | t: name: customer.name, locale: 'nl' }}
```

It translates with your app's translations, unless `config.i18n_store` gives
another backend for the Liquid context. A key that starts with a dot is in the
scope `config.translation_scope` gives for the context; with a backend that
includes `I18n::Backend::Cascade` it is then looked up from that scope towards
the root:

```ruby
Liquidum.configure do |config|
  config.i18n_store = ->(context) { I18n::Backend::Chain.new(MyBackend.new, I18n.backend) }
  config.translation_scope = ->(context) { context.registers["template"]&.translation_scope }
end
```

## Variables for editors

Editors can offer the variables a template can use, as a picker or as
suggestions after `{{`. Liquidum works them out from your drops: what Liquid
can call on a drop, labelled with `human_attribute_name` in the current
locale, typed from the model's columns, and followed through `association`
to other drops.

```ruby
class OrderDrop < Liquidum::Drop
  association :customer, :order_lines
  delegate :number, :total, to: :@object

  # Only for what Liquidum can't work out
  describe :total, type: :money, hint: "Including VAT"
  describe :portal_url, label: -> { I18n.t("orders.portal_url") }

  def portal_url = …
end

OrderDrop.variables # => [#<data Liquidum::Variable name="customer", label="Customer", type="object", …>, …]
```

`describe` takes `label:`, `type:`, `hint:` (a string, or a proc to translate
it), `drop:` and `collection:` for a method that returns other drops, and
`values:`, the values a variable can have, by their labels
(`values: -> { {"account" => "Club", "sponsor" => "Sponsor"} }`), for an editor
to complete `{% if line.party == "` or `| where: "party", "` with. A model's
enum has its values already, labelled as
`activerecord.attributes.<model>.<enum, plural>.<value>`. A
drop is for the model with its name (`OrderDrop` is for `Order`); override
`self.model` when that's not so.

Mount the engine and give the editor a URL with the template's roots, signed,
so a browser can't ask about other classes:

```ruby
mount Liquidum::Engine => "/liquidum"
```

```ruby
variables = Liquidum::Variables.new(order: OrderDrop, portal_url: :string)
liquidum.variables_path(roots: variables.token)
```

The editor asks for one level at a time:

```
GET /liquidum/variables?roots=…&path=order.customer
{"path": "order.customer", "variables": [{"name": "email", "label": "Email", "type": "string", "collection": false, "children": false}, …]}
```

In a collection the path goes into its elements (`order.order_lines.product`).

And for what can follow a `|`, the filters Liquid has (its own, Liquidum's and
the app's), each with its arguments and, for one on a collection, what it
leaves: the same items (`where`, `sort`) or one of them (`first`):

```
GET /liquidum/filters
{"filters": [{"name": "where", "label": "Those whose property has the value", "arguments": [{"name": "property", "kind": "property"}, {"name": "value", "kind": "value"}], "keeps": "collection"}, …]}
```

An argument's kind is `property`, `value` (of the property before it),
`format` (a date's), `key` (a translation's) or `any`. An app describes its own
filters with `Liquidum::Filters.describe :money, arguments: [[:currency]]`, and
labels them as `liquidum.filters.<name>`.
The endpoint only describes variables and never reads a record. Its
controllers inherit from `::ApplicationController`; to choose another one:

```ruby
Liquidum.configure do |config|
  config.parent_controller = "Admin::BaseController"
end
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'liquidum'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install liquidum
```

Mount the engine for the variables endpoint, the sandbox and the conversions,
and copy in its migrations for the sandbox:

```ruby
mount Liquidum::Engine, at: "/liquidum", as: "liquidum"
```

```bash
$ bin/rails liquidum:install:migrations
$ bin/rails db:migrate
```

The sandbox (`/liquidum/sandbox`) renders a template with a JSON context, and
saves the ones worth coming back to. Its pages use Satis. Its controllers
inherit from `config.parent_controller`, so set that to decide who may use
them.

## Contributing

Contribution directions go here.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
