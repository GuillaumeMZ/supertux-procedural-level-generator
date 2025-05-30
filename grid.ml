type 'a t = {
  inner_array: 'a array;
  width: int;
  height: int;
}

(* let get_1d_of_2d grid y x = y * grid.width + x

(** Returns (y, x) *)
let get_2d_of_1d grid i = (i / grid.width, i mod grid.width) *)

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

let fold f accumulator grid =
  let rec fold' y x accumulator' =
    if y = height grid then accumulator'
    else if x = width grid then fold' (y + 1) 0 accumulator'
    else fold' y (x + 1) (f y x accumulator' grid.inner_array.(y * grid.width + x))
  in fold' 0 0 accumulator

let get y x grid = grid.inner_array.(y * grid.width + x)

let get_opt y x grid = if inside x y grid then Some (grid.inner_array.(y * grid.width + x)) else None