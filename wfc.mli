type cell =
  | Uncollapsed of Tile.t list
  | Collapsed of Tile.t

type grid_state =
  | In_progress
  | Finished
  | Invalid_cell

val select_most_suitable_uncollapsed_cell: cell Grid.t -> (int * int) option

val get_grid_state: cell Grid.t -> grid_state