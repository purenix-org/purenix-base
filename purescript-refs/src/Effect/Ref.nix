{
  _new = value: _: { inherit value; };
  newWithSelf = f: _:
    let
      ref = { value = f ref; };
    in
    ref
  ;
  read = ref: ref.value;
}
