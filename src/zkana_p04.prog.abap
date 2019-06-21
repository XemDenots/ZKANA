*&---------------------------------------------------------------------*
*& Include          ZKANA_P04
*&---------------------------------------------------------------------*
CLASS lcl_kana2 IMPLEMENTATION.
  METHOD set_up.
    super->set_up( ).
    CREATE OBJECT mr_stats.
    mr_stats->set_source( me ).
    CREATE OBJECT mr_screenhandlerv2.
    mr_screenhandlerv2->set_sourcev2( me ).
    SET HANDLER on_display FOR me.
    SET HANDLER on_input FOR me.
  ENDMETHOD.
  METHOD check_input.
    super->check_input( iv_input ).

    IF iv_input = ms_prev_kana-romaji.
      mr_stats->input_ok( ).
    ELSE.
      mr_stats->input_wrong( ).
    ENDIF.
    RAISE EVENT kana_input.
  ENDMETHOD.
  METHOD get_prev_kana.
    rs_prev_kana = ms_prev_kana.
  ENDMETHOD.
  METHOD get_curr_kana.
    rs_curr_kana = ms_current_kana.
  ENDMETHOD.
  METHOD calc_random.
    ms_prev_kana = ms_current_kana.
    super->calc_random( ).
    RAISE EVENT kana_display.
  ENDMETHOD.
  METHOD on_display.
    mr_stats->display( ).
  ENDMETHOD.
  METHOD on_input.
    mr_stats->input( ).
  ENDMETHOD.
ENDCLASS.
