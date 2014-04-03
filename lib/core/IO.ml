module type T = sig
  type 'a t
      
  val bind : 'a t -> ('a -> 'b t) -> 'b t
  val return : 'a -> 'a t
  val fail : exn -> 'a t
  val catch : (unit -> 'a t) -> (exn -> 'a t) -> 'a t
      
  module Mutex : sig
    type mutex
    val create : unit -> mutex
    val is_locked : mutex -> bool
    val with_lock : mutex -> (unit -> 'a t) -> 'a t
  end
end

module type S = sig
  include T
    
  type ic
  type oc

  val read_line : ic -> string t
  val read_into_exactly : ic -> string -> int -> int -> unit t
  val write : oc -> string -> unit t
  val flush : oc -> unit t

  (* val starttls : input * output -> input * output *)
  (* val compress : input * output -> input * output *)
end
