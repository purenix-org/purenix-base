{
  # :: forall a b
  #  . (forall x. Maybe x -> Boolean)  # isNothing
  # -> (forall x. Maybe x -> x)        # fromJust
  # -> (forall x y. Tuple x y -> x)    # fst
  # -> (forall x y. Tuple x y -> y)    # snd
  # -> (b -> Maybe (Tuple a b))
  # -> b
  # -> Array a
  unfoldrArrayImpl = isNothing: fromJust: fst: snd: f: b:
    let
      # :: Array a -> Maybe (Tuple a b) -> Array a
      go = accum: maybeRes:
        if isNothing maybeRes then
          accum
        else
          let
            # :: Tuple a b
            tup = fromJust maybeRes;
            a = fst tup;
            b = snd tup;
          in
          go (accum ++ [a]) (f b);
    in
    go [] (f b);
}
