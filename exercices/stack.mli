type 'a t
(*@ mutable model view: 'a list *)

val create : unit -> 'a t
(*@ s = create ()
      ensures s.view = [] *)

val is_empty : 'a t -> bool
(*@ b = is_empty s
      ensures b <-> s.view = [] *)

val push : 'a -> 'a t -> unit
(*@ push x s
      modifies s.view
      ensures s.view = x :: old s.view *)

val pop : 'a t -> 'a
(*@ v = pop s
      requires s.view <> []
      modifies s.view
      ensures v :: s.view = old s.view *)
