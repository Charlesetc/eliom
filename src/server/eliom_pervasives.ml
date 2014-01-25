
open Eliom_lib
open Eliom_pervasives_base

type 'a client_value = 'a Eliom_lib.client_value

type ('a, 'b) server_function = ('a, 'b) server_function_service * Eliom_wrap.unwrapper

let server_function
    ?scope ?options ?charset ?code ?content_type ?headers ?secure_session ?name
    ?csrf_safe ?csrf_scope ?csrf_secure ?max_use ?timeout ?https ?error_handler
    argument_type f : (_, _) server_function =
  Eliom_registration.Ocaml.register_post_coservice'
    ?scope ?options ?charset ?code ?content_type ?headers ?secure_session ?name
    ?csrf_safe ?csrf_scope ?csrf_secure ?max_use ?timeout ?https ?error_handler
    ~post_params:Eliom_parameter.(ocaml "argument" argument_type)
    (fun () argument -> f argument),
  Eliom_wrap.create_unwrapper
    (Eliom_wrap.id_of_int Eliom_common_base.server_function_unwrap_id_int)
