type t

val empty: unit -> t

val add_constraint: t -> Tile.t -> Direction.t -> Tile.t -> t

val of_tilemap: Tile.t Grid.t -> t