
{
  # :: Int -> Int -> Array Int
  range = start: end:
    let
      step = if start > end then -1 else 1;
      len = (step * (end - start)) + 1;
      indexToRangeVal = i: start + (i * step);
    in
    builtins.genList (i: indexToRangeVal i) len;
}
