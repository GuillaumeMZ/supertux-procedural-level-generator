type 'a grid

(** `init h w fn` initializes a grid of height `h`, of width `w`, with element of coordinates `(y; x)` initialized to `fn y x`. *)
val init: int -> int -> (int -> int -> 'a) -> 'a grid

(** make h w x initializes a grid of height h, of width w, with each element of the grid being x. *)
val make: int -> int -> 'a -> 'a grid