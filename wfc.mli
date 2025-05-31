type cell =
  | Uncollapsed of Tile.t list
  | Collapsed of Tile.t

val select_most_suitable_uncollapsed_cell: cell Grid.t -> (int * int) option