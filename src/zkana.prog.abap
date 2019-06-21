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


START-OF-SELECTION.
  CREATE OBJECT gr_kana.

  gr_kana->set_up( ).

  CALL SCREEN 100.
