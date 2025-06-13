open Wfc

let usage_msg = "splg -i <input tilemap> -w <output level width> -h <output level height> -o <level output>"
let input_file = ref ""
let level_width = ref 0
let level_height = ref 0
let output_file = ref ""

let speclist = [
  ("-i", Arg.Set_string input_file, "Input tilemap path");
  ("-w", Arg.Set_int level_width, "Output level width (in cells)");
  ("-h", Arg.Set_int level_height, "Output level height (in cells)");
  ("-o", Arg.Set_string output_file, "Output level path")
]

let () =
  Arg.parse speclist ignore usage_msg;
  Random.self_init ();
  let tilemap = Tilemap.of_file !input_file in
  let constraint_map = Constraints.of_tilemap tilemap in
  let all_tiles = Tileset.of_tilemap tilemap in
  let wfc_grid = Grid.make !level_height !level_width (Uncollapsed all_tiles) in 
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
  in wave_function_collapse (); Level_serializer.serialize_level wfc_grid !output_file