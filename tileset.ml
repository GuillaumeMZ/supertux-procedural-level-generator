include Set.Make(Tile)

let all = of_list Tile.all

let to_string tileset = "{" ^ (
  fold (fun tile result ->
    result ^ " " ^ Tile.to_string tile
  ) tileset ""
) ^ "}\n"