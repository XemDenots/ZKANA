*&---------------------------------------------------------------------*
*& Include          ZKANA_D01
*&---------------------------------------------------------------------*
CLASS lcl_screen_handler DEFINITION DEFERRED.
CLASS lcl_kana DEFINITION.
  PUBLIC SECTION.
    TYPES:
      BEGIN OF ty_kana,
        romaji   TYPE ztkana-romaji,
        hira_url TYPE ztkana-hira_url,
        kata_url TYPE ztkana-kata_url,
      END OF ty_kana,

      tt_kana TYPE SORTED TABLE OF ty_kana WITH UNIQUE KEY romaji.

    METHODS:
      set_up,
      get_random_html RETURNING VALUE(rt_html) TYPE tchar255,
      check_input IMPORTING iv_input TYPE ty_kana-romaji.
    DATA:
      mr_screenhandler TYPE REF TO lcl_screen_handler.

  PROTECTED SECTION.
    DATA:
      ms_current_kana TYPE ty_kana.
    METHODS:
      calc_random.

  PRIVATE SECTION.
    DATA:
      mr_rand TYPE REF TO cl_abap_random_int,
      mt_kana TYPE tt_kana.


ENDCLASS.
