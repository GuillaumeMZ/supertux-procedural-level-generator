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

let to_int = function
  | Air -> 0
  | SnowLayerLeft -> 7
  | SnowLayerMiddle -> 8
  | SnowLayerRight -> 9
  | SnowGroundLeft -> 13
  | SnowGroundMiddle -> 14
  | SnowGroundRight -> 15
  | SnowWallLeft -> 10
  | SnowInner -> 11
  | SnowWallRight -> 12
  | SnowBottomLeft -> 16
  | SnowBottomMiddle -> 17
  | SnowBottomRight -> 18

let compare tile1 tile2 = Int.compare (to_int tile1) (to_int tile2)

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

let all = [
  Air; SnowLayerLeft; SnowLayerMiddle; SnowLayerRight; SnowGroundLeft; SnowGroundMiddle; SnowGroundRight;
  SnowWallLeft; SnowInner; SnowWallRight; SnowBottomLeft; SnowBottomMiddle; SnowBottomRight
]