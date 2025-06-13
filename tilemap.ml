type t = int Grid.t

let of_string string =
  let strings = 
      String.split_on_char '\n' string
      |> List.filter (fun row -> row <> "")
      |> List.map (String.split_on_char ' ')
      |> List.map (fun row -> List.filter (fun elt -> elt <> "") row) in
  let height = List.length strings in
  let width = List.length (List.nth strings 0) in
  let grid = Grid.make height width 0 in begin
    List.iteri (fun y row ->
      List.iteri (fun x elt ->
        Grid.set grid y x (int_of_string elt)
      ) row
    ) strings
  end;
  grid

let of_file file_path =
     In_channel.open_text file_path
  |> In_channel.input_all
  |> of_string