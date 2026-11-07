# Changelog

## Unreleased

- Allow Liquid 5.4 and later (up to 6).
- Drops describe their variables for editors: `Drop.variables`, the
  `describe` DSL, and `GET /liquidum/variables` with signed roots
  (`Liquidum::Variables`). See "Variables for editors" in the README.
- `config.parent_controller` chooses the controller Liquidum's controllers
  inherit from.
- Removed `GET /liquidum/completions`; `/liquidum/variables` replaces it.
