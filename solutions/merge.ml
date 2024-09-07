module type PRE_ORD = sig
  type t

  (*@ function le: t -> t -> bool *)

  (*@ axiom reflexive : forall x. le x x *)
  (*@ axiom total     : forall x y. le x y \/ le y x *)
  (*@ axiom transitive: forall x y z. le x y -> le y z -> le x z *)

  val leq : t -> t -> bool
  (*@ b = leq x y
        ensures b <-> le x y *)
end

module Make (E : PRE_ORD) = struct
  type elt = E.t

  (*@ predicate rec sorted_list (l: elt list) =
        match l with
        | [] | _ :: [] -> true
        | x :: (y :: r) -> E.le x y && sorted_list (y :: r) *)
  (*@ variant l *)

  (*@ lemma sorted_mem: forall x l.
        (forall y. List.mem y l -> E.le x y) /\ sorted_list l <->
        sorted_list (x :: l) *)

  (*@ lemma sorted_append: forall l1 l2.
        (sorted_list l1 && sorted_list l2 &&
          (forall x y. List.mem x l1 -> List.mem y l2 -> E.le x y)) <->
        sorted_list (l1 ++ l2) *)

  let rec merge_aux acc l1 l2 =
    match (l1, l2) with
    | [], l | l, [] -> List.rev_append acc l
    | x :: xs, y :: ys ->
        if E.leq x y then merge_aux (x :: acc) xs l2
        else merge_aux (y :: acc) l1 ys
  (*@ r = merge_aux acc l1 l2
        requires sorted_list (List.rev acc) && sorted_list l1 && sorted_list l2
        requires forall x y. List.mem x acc -> List.mem y l1 -> E.le x y
        requires forall x y. List.mem x acc -> List.mem y l2 -> E.le x y
        ensures  sorted_list r
        variant  l1, l2 *)

  let merge l1 l2 = merge_aux [] l1 l2
  (*@ r = merge l1 l2
        requires sorted_list l1 && sorted_list l2
        ensures  sorted_list r *)

end
