type t =
  | North
  | NorthEast
  | East
  | SouthEast
  | South
  | SouthWest
  | West
  | NorthWest

let to_int = function
  | North -> 0
  | NorthEast -> 1
  | East -> 2
  | SouthEast -> 3
  | South -> 4
  | SouthWest -> 5
  | West -> 6
  | NorthWest -> 7

let compare direction1 direction2 = Int.compare (to_int direction1) (to_int direction2)

let to_offset = function
  | North -> (-1, 0)
  | NorthEast -> (-1, 1)
  | East -> (0, 1)
  | SouthEast -> (1, 1)
  | South -> (1, 0)
  | SouthWest -> (1, -1)
  | West -> (0, -1)
  | NorthWest -> (-1, -1)

let all = [North; NorthEast; East; SouthEast; South; SouthWest; West; NorthWest;]

let to_string = function
  | North -> "North"
  | NorthEast -> "NorthEast"
  | East -> "East"
  | SouthEast -> "SouthEast"
  | South -> "South"
  | SouthWest -> "SouthWest"
  | West -> "West"
  | NorthWest -> "NorthWest"