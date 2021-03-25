module Immediate64 (Immediate : System.Immediate) (Boxed : System.Boxed) = struct
  include System.Make (Immediate) (Boxed)

  type nonrec t = t [@@immediate64]
end

module Optint = struct
  include Immediate64 (Optint_native) (Optint_emul)

  module type S = Integer_interface.S with type t := t

  let impl : (module S) =
    match repr with
    | Immediate -> (module Optint_native : S)
    | Boxed -> (module Optint_emul : S)

  include (val impl : S)
end

module Int63 = struct
  include Immediate64 (Int63_native) (Int63_emul)

  module type S = Integer_interface.S with type t := t

  let impl : (module S) =
    match repr with
    | Immediate -> (module Int63_native : S)
    | Boxed -> (module Int63_emul : S)

  include (val impl : S)
end

include Optint

module Private = struct
  module type S = Integer_interface.S

  module Int63_boxed = Int63_emul
end
