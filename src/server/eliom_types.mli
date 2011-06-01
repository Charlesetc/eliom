(* Ocsigen
 * http://www.ocsigen.org
 * Module eliom_client_types.ml
 * Copyright (C) 2010 Vincent Balat
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, with linking exception;
 * either version 2.1 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 *)

(** Types shared by client and server. *)

open Eliom_pervasives

type sitedata = {
  site_dir: Url.path;
  site_dir_string: string;
}

type server_params
val sp : server_params

(* Marshal an OCaml value into a string. All characters are escaped *)
val jsmarshal : 'a -> string
val string_escape : string -> string

(**/**)

(* val wrap_parameters : 'a -> client_expr_parameters *)

type onload_form_creators_info =
  | OFA of XML.elt * string * (bool * Url.path) option
  | OFForm_get of
      XML.elt * string * (bool * Url.path) option
  | OFForm_post of
      XML.elt * string * (bool * Url.path) option

type ref_tree =
  | Ref_node of (Eliom_common.node_ref option * (string * XML.caml_event) list * ref_tree list)
  | Ref_empty of int

type page_tree =
  | First_page of ref_tree list * ref_tree  (* (headers, body) *)
  | Change_page of int list * ref_tree list (* (headers, contents) *)

type eliom_js_page_data = {
  (* Sparse tree for HTML body and header, to relink the DOM. *)
  ejs_ref_tree: page_tree;
  (* Cookies *)
  ejs_tab_cookies: Ocsigen_cookies.cookieset;
  (* Event handlers *)
  ejs_onload: XML.event list;
  ejs_onunload: XML.event list;
  (* Session info *)
  ejs_sess_info: Eliom_common.sess_info;
}

(* the data sent on channels *)
type 'a eliom_comet_data_type = (poly * 'a) * (XML.elt list)

(*SGO* Server generated onclicks/onsubmits

val a_closure_id : int
val a_closure_id_string : string
val get_closure_id : int
val get_closure_id_string : string
val post_closure_id : int
val post_closure_id_string : string

val eliom_temporary_form_node_name : string
*)

(*POSTtabcookies* forms with tab cookies in POST params:

val add_tab_cookies_to_get_form_id : int
val add_tab_cookies_to_get_form_id_string : string
val add_tab_cookies_to_post_form_id : int
val add_tab_cookies_to_post_form_id_string : string

*)


val encode_eliom_data : 'a -> string

val string_escape : string -> string
