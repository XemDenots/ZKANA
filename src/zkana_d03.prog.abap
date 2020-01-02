*&---------------------------------------------------------------------*
*& Include          ZKANA_D03
*&---------------------------------------------------------------------*
CLASS lcl_kana_statistics DEFINITION.
* ==============
  PUBLIC SECTION.
*   -----
    TYPES:
      ty_timestamp TYPE timestampl,

      ty_status    TYPE c LENGTH 1,

      ty_choice    TYPE c LENGTH 1,

      BEGIN OF ty_statistics,
        time   TYPE ty_timestamp,
        status TYPE ty_status,
        romaji TYPE lcl_kana=>ty_kana-romaji,
      END OF ty_statistics,

      BEGIN OF ty_cumulative,
        absolute           TYPE i,
        abs_ok             TYPE i,
        abs_wrong          TYPE i,
        ellapsed_timestamp TYPE f,
        ell_kana_timestamp TYPE f,
        last_choice        TYPE ty_choice,
      END OF ty_cumulative,

      BEGIN OF ty_frequency,
        romaji    TYPE lcl_kana=>ty_kana-romaji,
        abs       TYPE i,
        abs_right TYPE i,
        abs_wrong TYPE i,
      END OF ty_frequency,

      tt_statistics    TYPE SORTED TABLE OF ty_statistics WITH UNIQUE KEY time,
      tt_statsunsorted TYPE STANDARD TABLE OF ty_statistics WITH KEY time,
      tt_frequencies   TYPE SORTED TABLE OF ty_frequency WITH UNIQUE KEY romaji.

*   ---------
    CONSTANTS:
      mc_display TYPE ty_status VALUE '0',
      mc_right   TYPE ty_status VALUE '1',
      mc_wrong   TYPE ty_status VALUE '2'.
*   -------
    METHODS:
      display,
      input,
      get_results RETURNING VALUE(rs_results) TYPE lcl_screen_handlerv2=>ty_results,
      set_source IMPORTING ir_source TYPE REF TO lcl_kana2,
      input_ok,
      input_wrong.
* ===============
  PRIVATE SECTION.
    DATA:
      mr_source      TYPE REF TO lcl_kana2,
      mt_statistics  TYPE tt_statistics,
      mt_frequencies TYPE tt_frequencies,
      ms_cumulatives TYPE ty_cumulative.

ENDCLASS.
