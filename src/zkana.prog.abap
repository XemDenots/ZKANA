*&---------------------------------------------------------------------*
*& Report ZKANA
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

REPORT zkana.

INCLUDE zkana_top.
INCLUDE zkana_o01.
INCLUDE zkana_i01.
INCLUDE zkana_p01.
INCLUDE zkana_p02.
INCLUDE zkana_p04.
INCLUDE zkana_p03.
INCLUDE zkana_p05.
INCLUDE zkana_p06. "lcl_kana3
INCLUDE zkana_p07. "lcl_kana_statisticsv2
INCLUDE zkana_p08. "lcl_screen_handlerv3





START-OF-SELECTION.
  CREATE OBJECT gr_kana.

  gr_kana->set_up( ).

  CALL SCREEN 100.
