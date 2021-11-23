# Liquor
Simplified use of Shopify's liquid, including some handy filters, tags and drops. 

## Usage
Basically it's as easy as:

```ruby
Liquor.render("{{payload.test}}", assigns: { 'payload' => { 'test' => 'blah' } })
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'liquor'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install liquor
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
