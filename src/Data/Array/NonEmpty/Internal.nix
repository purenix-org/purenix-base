let
  # This is from nixpkgs/lib/lists.nix.
  foldr = op: nul: list:
    let
      len = builtins.length list;
      fold' = n:
        if n == len
        then nul
        else op (builtins.elemAt list n) (fold' (n + 1));
    in fold' 0;
in
{
  # :: forall a. (a -> a -> a) -> NonEmptyArray a -> a
  #
  # Implementation taken from
  # https://hackage.haskell.org/package/base-4.15.0.0/docs/src/GHC-List.html#foldr1
  foldr1Impl = f: arr:
    let
      # :: NonEmptyArray a -> a
      go = arr:
        if builtins.length arr > 1 then
          let
            # :: a
            firstElem = builtins.head arr;
            # :: NonEmptyArray a
            remainingElems = builtins.tail arr;
          in
          f firstElem (go remainingElems)
        else
          # If the length of arr is not greater than 1, then we know it must be
          # 1.
          builtins.head arr;
    in
    go arr;

  # :: forall a. (a -> a -> a) -> NonEmptyArray a -> a
  foldl1Impl = f: arr:
    let
      firstElem = builtins.head arr;
      remainingElems = builtins.tail arr;
    in
    builtins.foldl' f firstElem remainingElems;

  # :: forall m a b
  #  . (forall a' b'. (m (a' -> b') -> m a' -> m b'))  # apply
  # -> (forall a' b'. (a' -> b') -> m a' -> m b')      # map
  # -> (a -> m b)
  # -> NonEmptyArray a
  # -> m (NonEmptyArray b)
  #
  # Implementation taken from
  # https://github.com/ekmett/semigroupoids/blob/8a74e309c533677318d065187b829a80887d0df6/src/Data/Semigroup/Traversable/Class.hs#L228-L229
  traverse1Impl = apply: fmap: f: arr:
    let
      # :: a
      firstElem = builtins.head arr;
      # :: Array a
      remainingElems = builtins.tail arr;
      # :: forall x. x -> NonEmptyArray x
      singleton = x: [ x ];
      # :: a -> m (NonEmptyArray b)
      mXToSingleton = a: fmap singleton (f a);
      # :: forall x. x -> NonEmptyArray x -> NonEmptyArray x
      cons = m: ms: [m] ++ ms;
      # :: a -> (a -> m (NonEmptyArray b)) -> a -> m (NonEmptyArray b)
      go = a1: accumF: a2: apply (fmap cons (f a2)) (accumF a1);
    in
    foldr go mXToSingleton remainingElems firstElem;
}
