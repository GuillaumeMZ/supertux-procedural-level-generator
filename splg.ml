open Wfc

let () =
  Random.self_init ();
  let tilemap = Grid.of_array_of_arrays [|
    [| 0; 0;  0;  0;  0 |];
    [| 0; 7;  8;  9;  0 |];
    [| 0; 13; 14; 15; 0 |];
    [| 0; 10; 11; 12; 0 |];
    [| 0; 16; 17; 18; 0 |];
    [| 0; 0;  0;  0;  0 |];
  |] in
  let constraint_map = Constraints.of_tilemap tilemap in
  let all_tiles = Tileset.of_tilemap tilemap in
  let wfc_grid = Grid.make 30 60 (Uncollapsed all_tiles) in 
  let rec wave_function_collapse () =
    let min_entropy_cell = select_most_suitable_uncollapsed_cell wfc_grid in
    (match min_entropy_cell with
      | Some (y, x) -> (
          collapse wfc_grid y x;
          propagate_constraints constraint_map all_tiles y x wfc_grid
        )
      | None -> failwith "Couldn't find a cell to collapse.");
    match get_grid_state wfc_grid with
      | Finished | Invalid_cell -> ()
      | In_progress -> wave_function_collapse ()
  in wave_function_collapse (); Level_serializer.serialize_level wfc_grid "./level1.stl"