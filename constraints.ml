module ConstraintKey = struct
  type t = (Tile.t * Direction.t)

  let compare t1 t2 =
    let tile_comparison = Tile.compare (fst t1) (fst t2) in
    if tile_comparison <> 0 then tile_comparison else
    Direction.compare (snd t1) (snd t2)
end

module ConstraintMap = Map.Make(ConstraintKey)

module TileSet = Set.Make(Tile)

type t = TileSet.t ConstraintMap.t

let empty (): t = ConstraintMap.empty

let add_constraint constraints source_tile direction destination_tile =
  let key = (source_tile, direction) in
  let new_set =
    if ConstraintMap.mem key constraints then
      let current_set = ConstraintMap.find key constraints in (* cannot throw *)
      TileSet.add destination_tile current_set
    else
      TileSet.singleton destination_tile
  in ConstraintMap.add key new_set constraints
