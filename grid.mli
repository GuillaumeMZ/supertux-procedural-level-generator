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

(** [get y x grid] returns the contents of the cell at (x; y). Raises an exception if the coordinates are invalid. *)
val get: int -> int -> 'a t -> 'a

(** [get_opt y x grid] returns the contents of the cell at (x; y) wrapped in an option. Returns None if the coordinates are invalid. *)
val get_opt: int -> int -> 'a t -> 'a option

(** [set grid y x value] sets the cell at (x; y) to [value]. *)
val set: 'a t -> int -> int -> 'a -> unit

(** [neighbors_list_with_direction grid y x] returns a list of the cell at (x; y)'s neighbors coordinates, with the direction relative to the source included. *)
val neighbors_list_with_direction: 'a t -> int -> int -> ((int * int) * Direction.t) list