open Tile
open Wfc

let () =
  Random.self_init ();
  let tilemap = Grid.of_array_of_arrays [|
    [| Air; Air; Air; Air; Air |];
    [| Air; SnowLayerLeft; SnowLayerMiddle; SnowLayerRight; Air |];
    [| Air; SnowGroundLeft; SnowGroundMiddle; SnowGroundRight; Air |];
    [| Air; SnowWallLeft; SnowInner; SnowWallRight; Air |];
    [| Air; SnowBottomLeft; SnowBottomMiddle; SnowBottomRight; Air |];
    [| Air; Air; Air; Air; Air |];
  |] in
  let constraint_map = Constraints.of_tilemap tilemap in
  let wfc_grid = Grid.make 15 15 (Uncollapsed Tileset.all) in 
  let rec wave_function_collapse () =
    let min_entropy_cell = select_most_suitable_uncollapsed_cell wfc_grid in
    (match min_entropy_cell with
      | Some (y, x) -> (
          collapse wfc_grid y x;
          propagate_constraints constraint_map y x wfc_grid
        )
      | None -> failwith "Couldn't find a cell to collapse.");
    match get_grid_state wfc_grid with
      | Finished | Invalid_cell -> ()
      | In_progress -> wave_function_collapse ()
  in wave_function_collapse (); print_collapsed_grid wfc_grid