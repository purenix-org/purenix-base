let
  # read :: forall a r. STRef r a -> ST r a
  #
  # This is the `read` function from
  # purescript-st/src/Control/Monad/ST/Internal.nix.
  stRead = id: state: { res = state.refs.${toString id}; inherit state; };

  # :: forall a r. a -> STRef r a -> ST r a
  stWrite = a: id: state:
    let
      # :: RefMap
      newRefs = state.refs // { "${toString id}" = a; };
      # :: STState
      newState = { nextId = state.nextId; refs = newRefs; };
    in
    { res = a; state = newState; };

in
{
  # :: forall h a. Int -> STArray h a -> ST h a
  peekImpl = index: id: state:
    let
      # :: STReturn (Array a)
      ret = stRead id state;

      # :: STState
      newState = ret.state;

      # :: Array a
      arr = ret.res;
    in
      { res = builtins.elemAt arr index; state = newState; };

  # :: forall h a. Int -> a -> STArray h a -> ST h Unit
  pokeImpl = index: a: id: state:
    let
      # :: STReturn (Array a)
      ret = stRead id state;

      # :: STState
      newState = ret.state;

      # :: Array a
      arr = ret.res;

      # :: Int
      len = builtins.length arr;

      # :: Array a
      newArr =
        builtins.genList (i: if i == index then a else builtins.elemAt arr i) len;

      # :: STReturn (Array a)
      ret' = stWrite newArr id newState;

      # :: STState
      newState' = ret'.state;
    in
      { res = null; state = newState'; };
}
