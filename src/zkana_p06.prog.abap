*&---------------------------------------------------------------------*
*& Include          ZKANA_P06
*&---------------------------------------------------------------------*
CLASS lcl_kana3 IMPLEMENTATION.
  METHOD set_up.
    super->set_up( ).

    CREATE OBJECT mr_det_stats.
    mr_det_stats->set_source( me ).
    CREATE OBJECT mr_screenhandlerv3.
    mr_screenhandlerv3->set_sourcev3( me ).

  ENDMETHOD.
ENDCLASS.
