{
  # :: forall a b
  #  . (forall x. Maybe x -> Boolean)  # isNothing
  # -> (forall x. Maybe x -> x)        # fromJust
  # -> (forall x y. Tuple x y -> x)    # fst
  # -> (forall x y. Tuple x y -> y)    # snd
  # -> (b -> Tuple a (Maybe b))
  # -> b
  # -> Array a
  unfoldr1ArrayImpl = isNothing: fromJust: fst: snd: f: b:
    let
      # :: Array a -> Tuple a (Maybe b) -> Array a
      go = accum: tup:
        let
          a = fst tup;
          maybeB = snd tup;
          newAccum = accum ++ [a];
        in
        if isNothing maybeB then
          newAccum
        else
          go (accum ++ [a]) (f (fromJust maybeB));
    in
    go [] (f b);
}

