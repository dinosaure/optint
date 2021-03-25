let immediate =
{ocaml|
module type Immediate = sig type t [@@immediate] end
module type Boxed = sig type t end

module Make (Immediate : Immediate) (Boxed : Boxed) = struct
  type t = Immediate.t
  type 'a repr = Immediate : Immediate.t repr | Boxed : Boxed.t repr
  let repr = Immediate
end
|ocaml}

let boxed =
{ocaml|
module type Immediate = sig type t [@@immediate] end
module type Boxed = sig type t end

module Make (Immediate : Immediate) (Boxed : Boxed) = struct
  type t = Boxed.t
  type 'a repr = Immediate : Immediate.t repr | Boxed : Boxed.t repr
  let repr = Boxed
end
|ocaml}

let run filename v =
  try
    let oc = open_out filename in
    output_string oc v ; close_out oc
  with exn -> Format.eprintf "%s: %s\n%!" Sys.argv.(0) (Printexc.to_string exn)

let () =
  match Sys.argv with
  | [| _; output; "--sixtyfour"; "true"  |] -> run output immediate
  | [| _; output; "--sixtyfour"; "false" |] -> run output boxed
  | _ -> Format.eprintf "%s <filename> --sixtyfour [true|false]\n%!" Sys.argv.(0)
