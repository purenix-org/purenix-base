
# type STArray r a = STRef r (Array a)
#
# An STArray is the same as an STRef, just pointing to an Array.
#
# See the documentation in purescript-st/src/Control/Monad/ST/Internal.nix for
# how ST is implemented.

let
  # :: forall a r. a -> ST r (STRef r a)
  #
  # This is the `new` function from
  # purescript-st/src/Control/Monad/ST/Internal.nix.
  stNew = a: state:
    let
      # :: Int
      nextId = state.nextId;
      # :: RefMap
      refs = state.refs;
      # :: String
      newKey = toString nextId;
      # :: Int
      newNextId = nextId + 1;
      # :: RefMap
      newRefs = refs // { "${toString nextId}" = a; };
      # :: STState
      newState = { nextId = newNextId; refs = newRefs; };
    in
    { res = nextId; state = newState; };

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
  # :: forall h a. STArray h a -> ST h (Array a)
  unsafeFreeze = id: state: stRead id state;

  # :: froall h a. Array a -> ST h (STArray h a)
  unsafeThaw = arr: state: stNew arr state;

  # :: forall h a. ST h (STArray h a)
  new = state: stNew [] state;

  # :: forall h a. Array a -> ST h (STArray h a)
  thaw = arr: state: stNew arr state;

  # :: forall h a
  #  . (forall b. b -> Maybe b)  # Just
  # -> (forall b. Maybe b)       # Nothing
  # -> STArray h a
  # -> ST h (Maybe a)
  shiftImpl = Just: Nothing: id: state:
    let
      # :: STReturn (Array a)
      ret = stRead id state;

      # :: STState
      newState = ret.state;

      # :: Array a
      arr = ret.res;
    in
    if builtins.length arr == 0 then
      { res = Nothing; state = newState; }
    else
      let
        # :: a
        firstElem = builtins.head arr;

        # :: Array a
        newArr = builtins.tail arr;

        # :: STReturn (Array a)
        ret' = stWrite newArr id newState;

        # :: STState
        newState' = ret'.state;
      in
      { res = Just firstElem; state = newState'; };

  # :: forall a h
  #  . (a -> a -> Ordering)
  # -> (Ordering -> Int)
  # -> STArray h a
  # -> ST h (STArray h a)
  sortByImpl = comp: ord2Int: id: state:
    let
      # :: STReturn (Array a)
      ret = stRead id state;

      # :: STState
      newState = ret.state;

      # :: Array a
      arr = ret.res;

      # :: a -> a -> Boolean
      sortF = a: b: if ord2Int (comp a b) == -1 then true else false;

      # :: Array a
      sortedArray = builtins.sort sortF arr;

      # :: STReturn (Array a)
      ret' = stWrite sortedArray id newState;
    in
    { res = id; state = ret'.state; };
}
