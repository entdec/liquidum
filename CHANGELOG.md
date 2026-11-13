# Changelog

## Unreleased

- `config.translation_scope` gives the scope of the `t` filter's keys that
  start with a dot, from the Liquid context. Those keys had no scope before.
- The `t` filter translates with the app's own translations when
  `config.i18n_store` isn't set, instead of failing.
- The sandbox works again: a `liquidum_sandboxes` migration makes the
  template and context `text` (copy it in with
  `bin/rails liquidum:install:migrations`), Render no longer saves, a context
  that isn't a JSON object is an error on the form, and its pages and the
  conversions page are translated (English and Dutch).
- Routes only for the actions that exist: no `show` or `destroy` for the
  sandbox, only `index` and `create` for conversions, and no `render_only`
  route.
- The sandbox no longer needs the responders gem.

- Allow Liquid 5.4 and later (up to 6).
- Drops describe their variables for editors: `Drop.variables`, the
  `describe` DSL, and `GET /liquidum/variables` with signed roots
  (`Liquidum::Variables`). See "Variables for editors" in the README.
- `config.parent_controller` chooses the controller Liquidum's controllers
  inherit from.
- Removed `GET /liquidum/completions`; `/liquidum/variables` replaces it.
