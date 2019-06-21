*&---------------------------------------------------------------------*
*& Include          ZKANA_P05
*&---------------------------------------------------------------------*
CLASS lcl_screen_handlerv2 IMPLEMENTATION.
  METHOD show_0100.
    DATA: lr_stats TYPE REF TO lcl_kana_statistics.
    super->show_0100( ).
    lr_stats = mr_sourcev2->mr_stats.
    ms_results = lr_stats->get_results( ).
  ENDMETHOD.
  METHOD set_sourcev2.
    mr_sourcev2 = ir_source.
  ENDMETHOD.
ENDCLASS.
