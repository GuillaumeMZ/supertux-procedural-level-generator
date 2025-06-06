type cell =
  | Uncollapsed of Tileset.t
  | Collapsed of Tile.t

type grid_state =
  | In_progress
  | Finished
  | Invalid_cell

let select_most_suitable_uncollapsed_cell cell_grid =
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