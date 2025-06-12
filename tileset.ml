include Set.Make(Tile)

let of_tilemap tilemap =
  Grid.fold_yx tilemap (fun _ _ elt set ->
    add elt set
  ) empty