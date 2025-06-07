module ConstraintKey = struct
  type t = (Tile.t * Direction.t)

  let compare t1 t2 =
    let tile_comparison = Tile.compare (fst t1) (fst t2) in
    if tile_comparison <> 0 then tile_comparison else
    Direction.compare (snd t1) (snd t2)

  let to_string key =
    "(" ^ (Tile.to_string (fst key)) ^ ", " ^ Direction.to_string (snd key) ^ ")"
end

module ConstraintMap = Map.Make(ConstraintKey)

type t = Tileset.t ConstraintMap.t

let empty (): t = ConstraintMap.empty

(* should be named add *)
let add_constraint constraints source_tile direction destination_tile =
  let key = (source_tile, direction) in
  let new_set =
    if ConstraintMap.mem key constraints then
      let current_set = ConstraintMap.find key constraints in (* cannot throw *)
      Tileset.add destination_tile current_set
    else
      Tileset.singleton destination_tile
  in ConstraintMap.add key new_set constraints

let of_tilemap tilemap =
  List.fold_left (fun state y ->
    List.fold_left (fun state x ->
      List.fold_left (fun state direction ->
        let (y_offset, x_offset) = Direction.to_offset direction in
        let (neighbor_y, neighbor_x) = (y + y_offset, x + x_offset) in
        let tile = Grid.get y x tilemap in
        let neighbor_opt = Grid.get_opt neighbor_y neighbor_x tilemap in
        match neighbor_opt with
          | Some neighbor -> add_constraint state tile direction neighbor
          | None -> state
      ) state Direction.all
    ) state (List.init (Grid.width tilemap) Fun.id)
  ) ConstraintMap.empty (List.init (Grid.height tilemap) Fun.id)

let print grid =
  let print_binding binding =
    print_string (ConstraintKey.to_string (fst binding));
    let tileset = snd binding in
    let elements = Tileset.elements tileset in
    List.map Tile.to_string elements |> List.iter print_string;
    print_string "\n"
  in
  let bindings = ConstraintMap.bindings grid in
  List.iter print_binding bindings

let find_opt = ConstraintMap.find_opt