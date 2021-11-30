
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
}
