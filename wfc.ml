type cell =
  | Uncollapsed of Tile.t list
  | Collapsed of Tile.t

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
          | Uncollapsed possibilities -> most_suitable_cell (y, x, List.length possibilities) best_so_far
          | _ -> best_so_far
      ) state (List.init (Grid.width cell_grid) Fun.id)
    ) (-1, -1, Int.max_int) (List.init (Grid.height cell_grid) Fun.id)
  in if y_best = -1 then None else Some (y_best, x_best)