type t =
  | Air
  | SnowLayerLeft
  | SnowLayerMiddle
  | SnowLayerRight
  | SnowGroundLeft
  | SnowGroundMiddle
  | SnowGroundRight
  | SnowWallLeft
  | SnowInner
  | SnowWallRight
  | SnowBottomLeft
  | SnowBottomMiddle
  | SnowBottomRight

let int_of_tile = function
  | Air -> 0
  | SnowLayerLeft -> 1
  | SnowLayerMiddle -> 2
  | SnowLayerRight -> 3
  | SnowGroundLeft -> 4
  | SnowGroundMiddle -> 5
  | SnowGroundRight -> 6
  | SnowWallLeft -> 7
  | SnowInner -> 8
  | SnowWallRight -> 9
  | SnowBottomLeft -> 10
  | SnowBottomMiddle -> 11
  | SnowBottomRight -> 12

let compare tile1 tile2 = Int.compare (int_of_tile tile1) (int_of_tile tile2)

let to_string = function
  | Air -> "Air"
  | SnowLayerLeft -> "SnowLayerLeft"
  | SnowLayerMiddle -> "SnowLayerMiddle"
  | SnowLayerRight -> "SnowLayerRight"
  | SnowGroundLeft -> "SnowGroundLeft"
  | SnowGroundMiddle -> "SnowGroundMiddle"
  | SnowGroundRight -> "SnowGroundRight"
  | SnowWallLeft -> "SnowWallLeft"
  | SnowInner -> "SnowInner"
  | SnowWallRight -> "SnowWallRight"
  | SnowBottomLeft -> "SnowBottomLeft"
  | SnowBottomMiddle -> "SnowBottomMiddle"
  | SnowBottomRight -> "SnowBottomRight"