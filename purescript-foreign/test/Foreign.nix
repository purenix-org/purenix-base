{
  eval = str: import (builtins.toFile "nix-code" str);

  # Remove once https://github.com/purenix-org/purenix/issues/35 is fixed
  tick = "\"";
}
