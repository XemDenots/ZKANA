*&---------------------------------------------------------------------*
*& Include          ZKANA_D06
*&---------------------------------------------------------------------*
CLASS lcl_kana_statisticsv2 DEFINITION DEFERRED.
CLASS lcl_screen_handlerv3 DEFINITION DEFERRED.
CLASS lcl_kana3 DEFINITION INHERITING FROM lcl_kana2.
  PUBLIC SECTION.
    DATA:
      mr_screenhandlerv3 TYPE REF TO lcl_screen_handlerv3,
      mr_det_stats       TYPE REF TO lcl_kana_statisticsv2.
    METHODS:
      set_up REDEFINITION.

ENDCLASS.
