*&---------------------------------------------------------------------*
*& Include          ZKANA_TOP
*&---------------------------------------------------------------------*
INCLUDE zkana_d01.
INCLUDE zkana_d02.
"{JACM20190620_2+
INCLUDE zkana_d04. "Changes needed in lcl_kana (inheritance test)
INCLUDE zkana_d05. "Adding fields to screen
INCLUDE zkana_d03. "Evolution 2. Adding statistics.
"}JACM20190620_2+
DATA:
  gr_kana    TYPE REF TO lcl_kana2.
