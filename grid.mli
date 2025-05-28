type 'a t

(** [init h w fn] initializes a grid of height [h], of width [w], with element of coordinates (y; x) initialized to [fn y x]. *)
val init: int -> int -> (int -> int -> 'a) -> 'a t

(** [make h w x] initializes a grid of height [h], of width [w], with each element of the grid being [x]. *)
val make: int -> int -> 'a -> 'a t

(** [of_array_of_arrays arrays] initializes a grid from [arrays], an array of arrays. *)
val of_array_of_arrays: 'a array array -> 'a t

(** Returns the height of the grid. *)
val height: 'a t -> int

(** Returns the width of the grid. *)
val width: 'a t -> int

(** [inside y x grid] returns [true] if (x; y) are valid coordinates, [false] otherwise. *)
val inside: int -> int -> 'a t -> bool

val fold: (int -> int -> 'b -> 'a -> 'b) -> 'b -> 'a t -> 'b