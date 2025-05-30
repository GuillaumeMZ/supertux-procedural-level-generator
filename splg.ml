open Tile

let () = 
  let tilemap = Grid.of_array_of_arrays [|
    [|SnowLayerLeft; SnowLayerMiddle; SnowLayerRight|];
    [|SnowGroundLeft; SnowGroundMiddle; SnowGroundRight|];
    [|SnowWallLeft; SnowInner; SnowWallRight|];
    [|SnowBottomLeft; SnowBottomMiddle; SnowBottomRight|];
  |] in
  let constraints = Constraints.of_tilemap tilemap in
  Constraints.print constraints
(*
  1) parse a file to generate constraints (for now: hardcoded file)
  2) generate a cell grid with every cell being "all tiles"
  3) select randomly a cell among those who have the lowest entropy
  4) collapse it, if possible
  5) propagate the constraints
  6) repeat
  7) write the output to disk, in a supertux-compatible way 
*)