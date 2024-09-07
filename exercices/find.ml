module type EQUAL = sig
  type t

  val eq : t -> t -> bool
  (*@ b = eq x y
        ensures b <-> x = y *)
end

module Make (E : EQUAL) = struct
  type elt = E.t

  (** Exercise: complete the specification of the [find] function *)

  let find x a =
    let exception Found of int in
    try
      for i = 0 to Array.length a - 1 do
        (* Exercise: provide a loop invariant *)
        if E.eq a.(i) x then raise (Found i)
      done;
      raise Not_found
    with Found i -> i
  (*@ i = find x a *)

end
