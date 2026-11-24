# Pins for Liquidum's JavaScript, for an app with importmap-rails:
#   import { met } from "liquidum/conditions"

pin_all_from Liquidum::Engine.root.join("app/javascript/liquidum"), under: "liquidum", to: "liquidum"
