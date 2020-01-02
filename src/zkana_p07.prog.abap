*&---------------------------------------------------------------------*
*& Include          ZKANA_P07
*&---------------------------------------------------------------------*
CLASS lcl_kana_statisticsv2 IMPLEMENTATION.
  METHOD set_source.
    super->set_source( me->mr_source ).
  ENDMETHOD.

  METHOD get_results.
    super->get_results( ).
  ENDMETHOD.

  METHOD add_stat.
    DATA:
      ls_stat TYPE ty_timestat.
    ls_stat-romaji = is_stat-kana.
    ls_stat-avg_time = is_stat-avg_kana_time DIV 2.
    ls_stat-avg_ok = is_stat-avg_kana_ok DIV 2.
    ls_stat-avg_wrong = is_stat-avg_kana_wrong.
    COLLECT ls_stat INTO mt_kana_stat.
    ms_gen_stat-avg_time = ( ms_gen_stat-avg_time + is_stat-avg_time ) DIV 2.
    ms_gen_stat-avg_ok = ( ms_gen_stat-avg_ok + is_stat-avg_ok ) DIV 2.
    ms_gen_stat-avg_wrong = ( ms_gen_stat-avg_ok + is_stat-avg_ok ) DIV 2.
  ENDMETHOD.

  METHOD get_timestat_ref.
    rt_timestat = mt_kana_stat.
  ENDMETHOD.
ENDCLASS.
