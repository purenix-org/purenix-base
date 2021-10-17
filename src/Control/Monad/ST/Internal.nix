
# type STState = { nextId :: Int, refs :: RefMap }
# type STReturn a = { res :: a, state :: STState }
# type ST s a = STState -> STReturn a
# type STRef = Int
#
# The ST monad is a state monad.  The state is `STState`.  `STState` is a
# record with a `nextId` field and a `refs` field.
#
# The `ref` field is a `RefMap`.  A RefMap is a Nix attrset where the keys are
# integers created from `nextId`, and the values are the `STRef`s that are stored
# at each ID.
#
# The `nextId` field is the next id to use when creating a new `STRef`.
#
# Reading an STRef just requires looking up the value for an ID in the `refs`
# map.  Writing an STRef requires updating the value for the ID in the `refs`
# map.

{ # :: forall r a b. (a -> b) -> ST r a -> ST r b
  map_ = a2b: stA: state:
    let
      # :: STReturn a
      stAReturn = stA state;
    in
    stAReturn // { res = a2b stAReturn.res; };

  # :: forall r a. a -> ST r a
  pure_ = a: state: { res = a; inherit state; };

  # :: forall r a b. ST r a -> (a -> ST r b) -> ST r b
  bind_ = m: k: state:
    let
      # :: STReturn a
      mReturn = m state;
      # :: STState
      mReturnState = mReturn.state;
      # :: a
      a = mReturn.res;
      # :: ST r b
      stB = k a;
      # :: STReturn b
      stBReturn = stB mReturnState;
    in
    stBReturn;

  # :: forall a. (forall r. ST r a) -> a
  run = stA:
    let
      # :: STReturn a
      stAReturn = stA { nextId = 0; refs = {}; };
    in
    stAReturn.res;

  # :: forall r a. ST r Boolean -> ST r a -> ST r Unit
  while = stBool: stA: state:
    let
      # :: ST r Unit
      go = state':
        let
          # :: STReturn Boolean
          stReturnBool = stBool state';
          # :: Boolean
          bool = stReturnBool.res;
          # :: STState
          stateAfterEvalBool = stReturnBool.state;
        in
        if bool then
          let
            # :: STReturn a
            stReturnA = stA stateAfterEvalBool;
            # :: STState
            stateAfterEvalA = stReturnA.state;
          in
          go stateAfterEvalA
        else
          # PureScript unit is represented by null in the Nix output by
          # PureNix.
          { res = null; state = stateAfterEvalBool; };
    in go state;


# exports["while"] = function (f) {
#   return function (a) {
#     return function () {
#       while (f()) {
#         a();
#       }
#     };
#   };
# };

  # :: forall r a. Int -> Int -> (Int -> ST r a) -> ST r Unit
  for = lo: hi: f: state:
    let
      # :: Int -> STState -> STReturn a
      go = i: state':
        if i >= hi then
          # PureScript unit is represented by null in the Nix output by
          # PureNix.
          { res = null; state = state'; }
        else
          let
            # :: ST r a
            nextST = f i;
            # :: STReturn a
            stReturn = nextST state';
            # :: STState
            newState  = stReturn.state;
          in
          go (i + 1) newState;
    in
    go lo state;

  # :: forall r a. Array a -> (a -> ST r Unit) -> ST r Unit
  foreach = arr: f: state:
    let
      # :: Int
      arrLen = builtins.length arr;

      # :: Int -> STState -> STReturn Unit
      go = i: state':
        if i >= arrLen then
          # PureScript unit is represented by null in the Nix output by
          # PureNix.
          { res = null; state = state'; }
        else
          let
            # :: a
            a = builtins.elemAt arr i;
            # :: ST r Unit
            nextST = f a;
            # :: STReturn Unit
            stReturn = nextST state';
            # :: STState
            newState = stReturn.state;
          in
          go (i + 1) newState;
    in
    go 0 state;

  # new :: forall a r. a -> ST r (STRef r a)
  new = a: state:
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
  read = id: state: { res = state.refs.${toString id}; inherit state; };

  # :: forall r a b. (a -> { state :: a, value :: b }) -> STRef r a -> ST r b
  modifyImpl = f: id: state:
    let
      # :: { state :: a, value :: b }
      newSAndV = f state.refs.${toString id};
      # :: a
      newS = newSAndV.state;
      # :: b
      newV = newSAndV.value;
      # :: RefMap
      newRefs = state.refs // { "${toString id}" = newS; };
      # :: STState
      newState = { nextId  = state.nextId; refs = newRefs; };
    in
    { res = newV; state = newState; };

  # :: forall a r. a -> STRef r a -> ST r a
  write = a: id: state:
    let
      # :: RefMap
      newRefs = state.refs // { "${toString id}" = a; };
      # :: STState
      newState = { nextId = state.nextId; refs = newRefs; };
    in
    { res = a; state = newState; };
}
