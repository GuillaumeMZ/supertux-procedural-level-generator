type t =
  | North
  | NorthEast
  | East
  | SouthEast
  | South
  | SouthWest
  | West
  | NorthWest

let direction_of_tile = function
  | North -> 0
  | NorthEast -> 1
  | East -> 2
  | SouthEast -> 3
  | South -> 4
  | SouthWest -> 5
  | West -> 6
  | NorthWest -> 7

let compare direction1 direction2 = Int.compare (direction_of_tile direction1) (direction_of_tile direction2)

let offset_of_direction = function
  | North -> (-1, 0)
  | NorthEast -> (-1, 1)
  | East -> (0, 1)
  | SouthEast -> (1, 1)
  | South -> (1, 0)
  | SouthWest -> (1, -1)
  | West -> (0, -1)
  | NorthWest -> (-1, -1)

let all = [North; NorthEast; East; SouthEast; South; SouthWest; West; NorthWest;]