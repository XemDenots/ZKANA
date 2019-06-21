*&---------------------------------------------------------------------*
*& Include          ZKANA_D05
*&---------------------------------------------------------------------*
CLASS lcl_screen_handlerv2 DEFINITION INHERITING FROM lcl_screen_handler.
  PUBLIC SECTION.
    TYPES:
      BEGIN OF ty_results,
        avg_time       TYPE i,
        avg_ok         TYPE i,
        avg_wrong      TYPE i,
        kana           type lcl_kana2=>ty_kana-romaji,
        avg_kana_time  TYPE i,
        avg_kana_ok    TYPE i,
        avg_kana_wrong TYPE i,
      END OF ty_results.
    CLASS-DATA:
      ms_results TYPE ty_results.
    METHODS:
      show_0100 REDEFINITION,
      set_sourcev2 IMPORTING ir_source TYPE REF TO lcl_kana2.

  PROTECTED SECTION.
    CLASS-DATA:
      mr_sourcev2         TYPE REF TO lcl_kana2.

ENDCLASS.
