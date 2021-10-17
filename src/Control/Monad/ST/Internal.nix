
# type STState = { nextIdx :: Int, refs :: RefMap }
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
      return // { res = a2b return.res; };

  # :: forall r a. a -> ST r a
  pure = a: state: { res = a; inherit state; };

  # :: forall r a b. ST r a -> (a -> ST r b) -> ST r b
  bind = m: k: state:
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
      stAReturn = st { nextIdx = 0; refs = {}; };
    in
      stAReturn.res;

  # foreign import while :: forall r a. ST r Boolean -> ST r a -> ST r Unit


# exports["while"] = function (f) {
#   return function (a) {
#     return function () {
#       while (f()) {
#         a();
#       }
#     };
#   };
# };

  # foreign import for :: forall r a. Int -> Int -> (Int -> ST r a) -> ST r Unit

# exports["for"] = function (lo) {
#   return function (hi) {
#     return function (f) {
#       return function () {
#         for (var i = lo; i < hi; i++) {
#           f(i)();
#         }
#       };
#     };
#   };
# };

  # foreign import foreach :: forall r a. Array a -> (a -> ST r Unit) -> ST r Unit

# exports.foreach = function (as) {
#   return function (f) {
#     return function () {
#       for (var i = 0, l = as.length; i < l; i++) {
#         f(as[i])();
#       }
#     };
#   };
# };

# exports.new = function (val) {
#   return function () {
#     return { value: val };
#   };
# };

# exports.read = function (ref) {
#   return function () {
#     return ref.value;
#   };
# };

# exports.modifyImpl = function (f) {
#   return function (ref) {
#     return function () {
#       var t = f(ref.value);
#       ref.value = t.state;
#       return t.value;
#     };
#   };
# };

# exports.write = function (a) {
#   return function (ref) {
#     return function () {
#       return ref.value = a; // eslint-disable-line no-return-assign
#     };
#   };
# };

