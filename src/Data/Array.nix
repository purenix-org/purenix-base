let
  # :: (a -> b -> b) -> b -> [a] -> b
  myfoldr = op: nul: list:
    let
      len = builtins.length list;
      fold' = n:
        if n == len
        then nul
        else op (builtins.elemAt list n) (fold' (n + 1));
    in fold' 0;

  # :: (Int -> a -> b -> b) -> b -> [a] -> b
  myfoldri = op: nul: list:
    let
      len = builtins.length list;
      fold' = n:
        if n == len
        then nul
        else op n (builtins.elemAt list n) (fold' (n + 1));
    in fold' 0;

  # foldr but operating over the list in reverse.
  #
  # :: (Int -> a -> b -> b) -> b -> [a] -> b
  myfoldri-rev = op: nul: list:
    let
      len = builtins.length list;
      fold' = n:
        if n < 0
        then nul
        else op n (builtins.elemAt list n) (fold' (n - 1));
    in fold' (len - 1);
in
{
  # :: forall f a
  #  . (forall b. (a -> b -> b) -> b -> f a -> b)  # foldr
  # -> f a
  # -> Array a
  fromFoldableImpl = foldr: xs:
    foldr (a: b: [a] ++ b) [] xs;

  # :: Int -> Int -> Array Int
  range = start: end:
    let
      step = if start > end then -1 else 1;
      len = (step * (end - start)) + 1;
      indexToRangeVal = i: start + (i * step);
    in
    builtins.genList (i: indexToRangeVal i) len;

  # :: forall a. Int -> a -> Array a
  replicate = n: a:
    if n < 0 then [] else builtins.genList (_: a) n;

  # :: forall a. Array a -> Int
  length = builtins.length;

  # :: forall a b
  #  . (Unit -> b)          # const Nothing
  # -> (a -> Array a -> b)  # \x xs -> Just { head: x, tail: xs }
  # -> Array a
  # -> b
  unconsImpl = emptyCase: consCase: arr:
    if builtins.length arr == 0 then
      emptyCase null
    else
      consCase (builtins.head arr) (builtins.tail arr);

  # :: forall a
  #  . (forall r. r -> Maybe r)  # Just
  # -> (forall r. Maybe r)       # Nothing
  # -> Array a
  # -> Int
  # -> Maybe a
  indexImpl = Just: Nothing: arr: idx:
    let
      len = builtins.length arr;
    in
    if idx < 0 || idx >= len then
      Nothing
    else
      Just (builtins.elemAt arr idx);

  # :: forall a b
  #  . (forall c. Maybe c)            # Nothing
  # -> (forall c. Maybe c -> Boolean) # isJust
  # -> (a -> Maybe b)
  # -> Array a
  # -> Maybe b
  findMapImpl = Nothing: isJust: f: arr:
    let
      go = a: accum:
        let
          res = f a;
        in
        if isJust res then res else accum;
    in
    myfoldr go Nothing arr;

  # :: forall a
  #  . (forall b. b -> Maybe b)  # Just
  # -> (forall b. Maybe b)       # Nothing
  # -> (a -> Boolean)
  # -> Array a
  # -> Maybe Int
  findIndexImpl = Just: Nothing: f: arr:
    let
      go = i: a: accum: if f a then Just i else accum;
    in
    myfoldri go Nothing arr;

  # :: forall a
  #  . (forall b. b -> Maybe b)  # Just
  # -> (forall b. Maybe b)       # Nothing
  # -> (a -> Boolean)
  # -> Array a
  # -> Maybe Int
  findLastIndexImpl = Just: Nothing: f: arr:
    let
      go = i: a: accum: if f a then Just i else accum;
    in
    myfoldri-rev go Nothing arr;

  # :: forall a
  #  . (forall b. b -> Maybe b)  # Just
  # -> (forall b. Maybe b)       # Nothing
  # -> Int
  # -> a
  # -> Array a
  # -> Maybe (Array a)
  _insertAt = Just: Nothing: idx: a: arr:
    let
      len = builtins.length arr;

      go = i:
        if i < idx then
          builtins.elemAt arr i
        else if i == idx then
          a
        else
          builtins.elemAt arr (i - 1);
    in
    if idx < 0 || idx > len then
      Nothing
    else
      builtins.genList go (len + 1);

  # :: forall a
  #  . (forall b. b -> Maybe b) # Just
  # -> (forall b. Maybe b)      # Nothing
  # -> Int
  # -> Array a
  # -> Maybe (Array a)
  _deleteAt = Just: Nothing: idx: arr:
    let
      len = builtins.length arr;

      go = i:
        if i < idx then
          builtins.elemAt arr i
        else
          builtins.elemAt arr (i + 1);
    in
    if idx < 0 || idx >= len then
      Nothing
    else
      builtins.genList go (len - 1);
}
