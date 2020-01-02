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
"{JACM20190621_3+
"TODO: agregar un alv con la información recolectada de frecuencias.
include zkana_d06. "lcl_kana3
include zkana_d07. "lcl_kana_statisticsv2
include zkana_d08. "lcl_screen_handlerv3
"}JACM20190621_3+
DATA:
  "gr_kana    TYPE REF TO lcl_kana2."JACM20190625_3-
  gr_kana     TYPE REF TO lcl_kana3."JACM20190625_3+
