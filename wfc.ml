type cell =
  | Uncollapsed of Tileset.t
  | Collapsed of Tile.t

type grid_state =
  | In_progress
  | Finished
  | Invalid_cell

let select_most_suitable_uncollapsed_cell cell_grid = (* could be more random *)
  let most_suitable_cell ((_, _, count1) as one) ((_, _, count2) as two) =
    if count1 < count2 then one else two
  in
  let (y_best, x_best, _) =
    List.fold_left (fun state y ->
      List.fold_left (fun best_so_far x ->
        let current = Grid.get y x cell_grid in
        match current with
          (* what if an uncollapsed cell exists but with 0 possibilities ? *)
          | Uncollapsed possibilities -> most_suitable_cell (y, x, Tileset.cardinal possibilities) best_so_far
          | _ -> best_so_far
      ) state (List.init (Grid.width cell_grid) Fun.id)
    ) (-1, -1, Int.max_int) (List.init (Grid.height cell_grid) Fun.id)
  in if y_best = -1 then None else Some (y_best, x_best)

let get_grid_state cell_grid =
  let state_keeper state1 state2 =
    match (state1, state2) with
      | (_, Invalid_cell) | (Invalid_cell, _) -> Invalid_cell
      | (_, In_progress) | (In_progress, _) -> In_progress
      | _ -> Finished
  in
  let state_of_cell cell =
    match cell with
      | Uncollapsed possibilities -> if Tileset.cardinal possibilities = 0 then Invalid_cell else In_progress
      | Collapsed _ -> Finished
  in
  List.fold_left (fun grid_state y ->
    List.fold_left (fun current_grid_state x ->
      let cell = Grid.get y x cell_grid in
      state_keeper current_grid_state (state_of_cell cell)
    ) grid_state (List.init (Grid.width cell_grid) Fun.id)
  ) Finished (List.init (Grid.height cell_grid) Fun.id)

(* Must NOT be called on a collapsed cell. *)
let generate_constraints constraint_map y x cell_grid =
  let rec generate_constraints' target_cell target_direction =
    match target_cell with
      | Uncollapsed possibilities -> Tileset.fold (fun possibility acc ->
          let constraint_set = Constraints.find_opt (possibility, Direction.opposite target_direction) constraint_map in
          match constraint_set with
            | Some set -> Tileset.union acc set
            | None -> acc
        ) possibilities Tileset.empty
      | Collapsed tile -> generate_constraints' (Uncollapsed (Tileset.singleton tile)) target_direction (* quick hack *)
  in
  let new_constraints =
    Grid.neighbors_list_with_direction cell_grid y x |>
    List.fold_left (fun tileset ((y_neighbor, x_neighbor), direction) ->
      Tileset.union tileset (generate_constraints' (Grid.get y_neighbor x_neighbor cell_grid) direction)
    ) Tileset.empty
  in
  match Grid.get y x cell_grid with
    | Collapsed _ -> failwith "Attempting to build the constraints of a collapsed cell."
    | Uncollapsed _ -> new_constraints 

let collapse cell_grid y x =
  let cell = Grid.get y x cell_grid in
  match cell with
    | Collapsed _ -> failwith "Attempting to collapse an already collapsed cell."
    | Uncollapsed possibilities ->
        let selected_possibility = Tileset.choose_opt possibilities in (* is it random enough ? probably not, my implementation just calls min_elt_opt *)
        match selected_possibility with
          | Some tile -> Grid.set cell_grid y x (Collapsed tile)
          | None -> failwith "Attempting to collapse an invalid cell."

let rec propagate_constraints constraint_map y x cell_grid =
  Grid.neighbors_list_with_direction cell_grid y x |>
  List.iter (fun ((y_neighbor, x_neighbor), _) ->
    let neighbor = Grid.get y_neighbor x_neighbor cell_grid in
    match neighbor with
      | Collapsed _ -> ()
      | Uncollapsed possibilities ->
          let new_possibilities = generate_constraints constraint_map y x cell_grid in
          if Tileset.equal possibilities new_possibilities then ()
          else Grid.set cell_grid y x (Uncollapsed new_possibilities); propagate_constraints constraint_map y_neighbor x_neighbor cell_grid
  )