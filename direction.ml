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