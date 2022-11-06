# Liquidum

Simplified use of Shopify's liquid, including some handy filters, tags and drops.

## Usage

Basically it's as easy as:

```ruby
Liquidum.render("{{payload.test}}", assigns: { 'payload' => { 'test' => 'blah' } })
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

## Contributing

Contribution directions go here.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
