type t

(** Creates a new, empty constraint map. *)
val empty: unit -> t

(** [add_constraint constraints source_tile direction target_tile] adds a constraint to [constraints], saying that
there can be a [target_tile] in the direction [direction] from a [source_tile]. *)
val add_constraint: t -> Tile.t -> Direction.t -> Tile.t -> t

(** Creates a constraint map from a tilemap. *)
val of_tilemap: Tile.t Grid.t -> t

val find_opt: (Tile.t * Direction.t) -> t -> Tileset.t option