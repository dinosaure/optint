open Optint

let () =
  Format.printf ">>> %a.\n%!" Optint.pp Optint.zero ;
  Format.printf ">>> %a.\n%!" Int63.pp Int63.zero ;
