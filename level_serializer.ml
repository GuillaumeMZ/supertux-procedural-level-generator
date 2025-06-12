let cell_grid_to_string cell_grid =
  List.fold_left (fun block y ->
    let current_line = List.fold_left (fun line x ->
      match Grid.get y x cell_grid with
      | Wfc.Uncollapsed _ -> failwith "Attempting to convert an uncollapsed cell to a string."
      | Wfc.Collapsed tile -> line ^ " " ^ (string_of_int tile)
    ) block (List.init (Grid.width cell_grid) Fun.id)
    in current_line ^ "\n"
  ) "" (List.init (Grid.height cell_grid) Fun.id)

let serialize_level cell_grid output_path =
  let out_channel = open_out output_path in
  Printf.fprintf out_channel {|
    (supertux-level
      (version 3)
      (name (_ "Unknown"))
      (author "Unknown")
      (license "CC-BY-SA 4.0 International")
      (sector
        (name "main")
        (ambient-light
          (color 1 1 1)
        )
        (background
          (color 1 1 1)
          (speed 0.5)
          (image "images/background/antarctic/arctis2.png")
        )
        (camera
          (name "Camera")
          (mode "normal")
        )
        (gradient
          (top_color 0.3 0.4 0.75)
          (bottom_color 1 1 1)
          (z-pos -301)
        )
        (music
          (file "antarctic/chipdisko.music")
        )
        (tilemap
          (solid #t)
          (z-pos 0)
          (width %d)
          (height %d)
          (tiles
            %s
          )
        )
      )
    )
  |} (Grid.width cell_grid) (Grid.height cell_grid) (cell_grid_to_string cell_grid);
  flush out_channel