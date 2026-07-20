# Bypass the strict safety blocks for unconstrained neural network IO ports

# Set device configuration voltage standards for the Artix-7 chip fabric
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]
