*&---------------------------------------------------------------------*
*& Include          ZKANA_D07
*&---------------------------------------------------------------------*
CLASS lcl_kana_statisticsv2 DEFINITION INHERITING FROM lcl_kana_statistics.
  PUBLIC SECTION.
    TYPES:
      BEGIN OF ty_timestat,
        symbol    TYPE c LENGTH 1,
        romaji    TYPE lcl_kana=>ty_kana-romaji,
        avg_time  TYPE i,
        avg_ok    TYPE i,
        avg_wrong TYPE i,
      END OF ty_timestat,
      tt_timestat TYPE STANDARD TABLE OF ty_timestat WITH KEY symbol romaji.
    METHODS:
      set_source  REDEFINITION,
      get_results REDEFINITION,
      add_stat IMPORTING is_stat TYPE lcl_screen_handlerv2=>ty_results,
      get_timestat_ref RETURNING VALUE(rt_timestat) TYPE  tt_timestat.
  PROTECTED SECTION.
    DATA:
      ms_gen_stat  TYPE ty_timestat,
      mt_kana_stat TYPE tt_timestat,
      mr_source    TYPE REF TO lcl_kana3.
ENDCLASS.
