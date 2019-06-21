*&---------------------------------------------------------------------*
*& Include          ZKANA_D02
*&---------------------------------------------------------------------*
CLASS lcl_kana2 DEFINITION DEFERRED.
CLASS lcl_screen_handler DEFINITION.
  PUBLIC SECTION.
    TYPES:
      BEGIN OF ty_dynpro_100,
        romaji TYPE ztkana-romaji,
        okcode TYPE syst_ucomm,
      END OF ty_dynpro_100.
    CLASS-DATA:
      ms_dyn100         TYPE ty_dynpro_100.
    METHODS:
      status_0100,
      set_source IMPORTING ir_source TYPE REF TO lcl_kana,
      show_0100.
  PROTECTED SECTION.
    CLASS-DATA:
      mr_source         TYPE REF TO lcl_kana.
  PRIVATE SECTION.
    CLASS-DATA:
      mr_container_html TYPE REF TO cl_gui_custom_container,
      mr_html_pic       TYPE REF TO cl_gui_html_viewer.


ENDCLASS.
