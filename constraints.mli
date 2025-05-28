type t

val empty: unit -> t

val add_constraint: t -> Tile.t -> Direction.t -> Tile.t -> t