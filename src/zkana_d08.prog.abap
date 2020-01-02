*&---------------------------------------------------------------------*
*& Include          ZKANA_D08
*&---------------------------------------------------------------------*
CLASS lcl_screen_handlerv3 DEFINITION INHERITING FROM lcl_screen_handlerv2.
  PUBLIC SECTION.
    METHODS:
      set_sourcev3 IMPORTING ir_source TYPE REF TO lcl_kana3,
      show_det_stats,
      status_0200,
      show_0100 REDEFINITION.


  PROTECTED SECTION.
    DATA:
      mr_sourcev3 TYPE REF TO lcl_kana3.
  PRIVATE SECTION.
    DATA:
      mr_container    TYPE REF TO cl_gui_dialogbox_container,
      mr_alvstat      TYPE REF TO cl_gui_alv_grid,
      mt_fieldcatalog TYPE lvc_t_fcat,
      mt_datatab      type lcl_kana_statisticsv2=>tt_timestat.
    METHODS:
      prepare_alvstat,
      show_alvstat,
      set_fieldcatalog,
      on_close FOR EVENT close OF cl_gui_dialogbox_container IMPORTING sender.
ENDCLASS.
