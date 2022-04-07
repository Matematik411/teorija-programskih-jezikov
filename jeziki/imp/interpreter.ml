(* Da se lokacija l v stanju st ne bi pojavila več kot enkrat, jo preventivno pobrišemo  *)

let update_loc k v st = (k, v) :: List.remove_assoc k st

let rec eval_exp st = function
  | Syntax.Lookup l -> List.assoc l st
  | Int n -> n
  | Plus (e1, e2) -> eval_exp st e1 + eval_exp st e2
  | Minus (e1, e2) -> eval_exp st e1 - eval_exp st e2
  | Times (e1, e2) -> eval_exp st e1 * eval_exp st e2

let eval_bool st = function
  | Syntax.Bool b -> b
  | Equal (e1, e2) -> eval_exp st e1 = eval_exp st e2
  | Less (e1, e2) -> eval_exp st e1 < eval_exp st e2
  | Greater (e1, e2) -> eval_exp st e1 > eval_exp st e2

let rec eval_cmd st = function
  | Syntax.Assign (l, e) -> update_loc l (eval_exp st e) st
  | IfThenElse (b, c1, c2) ->
      if eval_bool st b then eval_cmd st c1 else eval_cmd st c2
  | Seq (c1, c2) ->
      let st' = eval_cmd st c1 in
      eval_cmd st' c2
  | Skip -> st
  | WhileDo (b, c) ->
      (* eval_cmd st (IfThenElse (b, Seq (c, WhileDo (b, c)), Skip)) *)
      if eval_bool st b then
        let st' = eval_cmd st c in
        eval_cmd st' (WhileDo (b, c))
      else st
  | PrintInt e ->
      print_int (eval_exp st e);
      print_newline ();
      st

let print_state st =
  print_endline "[";
  st
  |> List.sort_uniq (fun (Syntax.Location l, _) (Syntax.Location l', _) ->
         compare l l')
  |> List.iter (fun (Syntax.Location l, n) ->
         print_endline ("  #" ^ l ^ " := " ^ string_of_int n));
  print_endline "]"

let run cmd = eval_cmd [] cmd |> print_state
