type 'a grid

(** `init h w fn` initializes a grid of height `h`, of width `w`, with element of coordinates `(y; x)` initialized to `fn y x`. *)
val init: int -> int -> (int -> int -> 'a) -> 'a grid

