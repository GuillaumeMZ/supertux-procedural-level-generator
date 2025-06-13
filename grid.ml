type 'a t = {
  inner_array: 'a array;
  width: int;
  height: int;
}

let init height width init_fn =
  let inner_size = height * width in
  let init_fn' i =
    let (y, x) = (i / width, i mod width) in
    init_fn y x 
  in
  let inner_array = Array.init inner_size init_fn' in
  {
    inner_array;
    width;
    height;
  }

let make height width x = init height width (fun _ _ -> x)

let of_array_of_arrays arrays =
  let height = Array.length arrays in
  let width = Array.length arrays.(0) in
  init height width (fun y x -> arrays.(y).(x))

let height grid = grid.height

let width grid = grid.width

let inside y x grid = y >= 0 && y < grid.height && x >= 0 && x < grid.width

let get y x grid = grid.inner_array.(y * grid.width + x)

let get_opt y x grid = if inside y x grid then Some (grid.inner_array.(y * grid.width + x)) else None

let set grid y x value = grid.inner_array.(y * grid.width + x) <- value

let neighbors_list_with_direction grid y x =
     Direction.all
  |> List.map (fun direction -> (Direction.to_offset direction, direction))
  |> List.map (fun ((y_offset, x_offset), direction) -> ((y + y_offset, x + x_offset), direction))
  |> List.filter (fun ((y, x), _) -> inside y x grid)

let fold_yx grid f initial_acc =
  List.fold_left (fun acc y ->
      List.fold_left (fun acc' x ->
        f y x (get y x grid) acc'
      ) acc (List.init (width grid) Fun.id)
  ) initial_acc (List.init (height grid) Fun.id)
