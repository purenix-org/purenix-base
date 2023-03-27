rec {
  showErrorImpl = err: err.stack or builtins.toString err;
  error = message: { inherit message; };
  errorWithCause = message: cause: {
    inherit message cause;
  };
  message = e: e.message;
  name = e: e.name or "Error";
  stackImpl = just: nothing: e:
    if builtins.hasAttr "stack" e then just e.stack else nothing;
  throwException = e: _:
    if builtins.hasAttr "cause" e
    then builtins.throw "${name e}: ${message e} caused by ${e.cause}";
    else builtins.throw "${name e}: ${message e}";
  catchException = c: t: _:
    let
      result = builtins.tryEval (t null);
    in
    if result.success == true
    then result.value
    else
    # Nix doesn't expose caught error messages
      c {
        message = "caught exception";
        name = "Error";
      };
}
