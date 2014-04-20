(** The paths to each eliom directories *)
module type ELIOM = sig
  val server_dir : Ocamlbuild_plugin.Pathname.t
  val type_dir : Ocamlbuild_plugin.Pathname.t
  val client_dir : Ocamlbuild_plugin.Pathname.t
end

module Make (Eliom : ELIOM) : sig
  (** The dispatcher should be used with {!Ocamlbuild_plugin.dispatch} as:
      [Ocamlbuild_plugin.dispatch Ocamlbuild_eliom.dispatcher_without_js_of_ocaml_support]

      Side note: {!Ocamlbuild_plugin.dispatch} should be used only once as
      it record only one function for an ocamlbuild module.
  *)
  val dispatcher_without_js_of_ocaml_support : Ocamlbuild_plugin.hook -> unit

  (** The main dispatcher

      Same as {!Ocamlbuild_js_of_ocaml.dispatcher} followed by
      {!dispatcher_without_js_of_ocaml_support}.
  *)
  val dispatcher : Ocamlbuild_plugin.hook -> unit

  (** Same as {!Ocamlbuild_js_of_ocaml.dispatcher_with_oasis_support}
      followed by {!dispatcher}
  *)
  val dispatcher_with_oasis_support :
    executables:string list ->
    Ocamlbuild_plugin.hook ->
    unit
end
