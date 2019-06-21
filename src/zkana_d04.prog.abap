*&---------------------------------------------------------------------*
*& Include          ZKANA_D04
*&---------------------------------------------------------------------*
CLASS lcl_kana_statistics DEFINITION DEFERRED.
CLASS lcl_screen_handlerv2 DEFINITION DEFERRED.
CLASS lcl_kana2 DEFINITION INHERITING FROM lcl_kana.
  PUBLIC SECTION.
    EVENTS:
      kana_display,
      kana_input.
    METHODS:
      set_up REDEFINITION,
      check_input REDEFINITION,
      get_prev_kana RETURNING VALUE(rs_prev_kana) TYPE ty_kana,
      get_curr_kana returning value(rs_curr_kana) type ty_kana.
    DATA:
      mr_stats           TYPE REF TO lcl_kana_statistics,
      mr_screenhandlerv2 TYPE REF TO lcl_screen_handlerv2.
  PROTECTED SECTION.
    DATA:
      ms_prev_kana TYPE ty_kana.
    METHODS:
      calc_random REDEFINITION,
      on_display FOR EVENT kana_display OF lcl_kana2,
      on_input FOR EVENT kana_input OF lcl_kana2.
ENDCLASS.
