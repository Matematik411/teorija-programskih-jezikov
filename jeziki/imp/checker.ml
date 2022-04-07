let rec check_exp locs = function
  | Syntax.Lookup loc -> List.mem loc locs
  | Syntax.Int _ -> true
  | Syntax.Plus (e1, e2) -> check_exp locs e1 && check_exp locs e2
  | Syntax.Minus (e1, e2) -> check_exp locs e1 && check_exp locs e2
  | Syntax.Times (e1, e2) -> check_exp locs e1 && check_exp locs e2

let check_bexp locs = function
  | Syntax.Bool _ -> true
  | Syntax.Equal (e1, e2) -> check_exp locs e1 && check_exp locs e2
  | Syntax.Less (e1, e2) -> check_exp locs e1 && check_exp locs e2
  | Syntax.Greater (e1, e2) -> check_exp locs e1 && check_exp locs e2

let rec check_cmd locs = function
  | Syntax.Assign (l, e) -> if check_exp locs e then Some (l :: locs) else None
  | Syntax.IfThenElse (b, c1, c2) ->
      if check_bexp locs b then
        match (check_cmd locs c1, check_cmd locs c2) with
        | None, _ -> None
        | _, None -> None
        | Some locs1, Some locs2 ->
            Some (List.filter (fun loc -> List.mem loc locs2) locs1)
      else None
  | Syntax.Seq (c1, c2) -> (
      match check_cmd locs c1 with
      | None -> None
      | Some locs' -> check_cmd locs' c2 )
  | Syntax.Skip -> Some locs
  | Syntax.WhileDo (b, c) ->
      if check_bexp locs b then check_cmd locs c else None
  | Syntax.PrintInt e -> if check_exp locs e then Some locs else None

let check c = match check_cmd [] c with None -> false | Some _ -> true
