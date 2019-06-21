*&---------------------------------------------------------------------*
*& Include          ZKANA_P03
*&---------------------------------------------------------------------*

CLASS lcl_kana_statistics IMPLEMENTATION.
  METHOD display.
    DATA:
      ls_statistics TYPE ty_statistics,
      ls_frequency  TYPE ty_frequency,
      ls_curr_kana  TYPE lcl_kana2=>ty_kana.

    ls_curr_kana = mr_source->get_curr_kana( ).

    CLEAR ls_statistics.
    ls_statistics-romaji = ls_curr_kana-romaji.
    ls_statistics-status = mc_display.
    GET TIME STAMP FIELD ls_statistics-time.
    APPEND ls_statistics TO mt_statistics.


    READ TABLE mt_frequencies INTO ls_frequency
      WITH KEY romaji = ls_curr_kana-romaji.
    IF sy-subrc <> 0.
      CLEAR ls_frequency.
    ENDIF.
    ls_frequency-romaji = ls_curr_kana-romaji.
    ls_frequency-abs = ls_frequency-abs + 1.
    MODIFY TABLE mt_frequencies FROM ls_frequency.
    IF sy-subrc <> 0.
      INSERT ls_frequency INTO TABLE mt_frequencies.
    ENDIF.

    ms_cumulatives-absolute = ms_cumulatives-absolute + 1.
  ENDMETHOD.
  METHOD input.
    DATA:
      ls_statistics TYPE ty_statistics,
      ls_frequency  TYPE ty_frequency,
      ls_prev_kana  TYPE lcl_kana2=>ty_kana.

    ls_prev_kana = mr_source->get_prev_kana( ).

    CLEAR         ls_statistics.
    ls_statistics-romaji = ls_prev_kana-romaji.
    CASE ms_cumulatives-last_choice.
      WHEN mc_right.
        ls_statistics-status = mc_right.
      WHEN mc_wrong.
        ls_statistics-status = mc_wrong.
    ENDCASE.

    GET TIME STAMP FIELD ls_statistics-time.
    APPEND ls_statistics TO mt_statistics.


    READ TABLE mt_frequencies INTO ls_frequency
      WITH KEY romaji = ls_prev_kana-romaji.
    IF sy-subrc = 0.
      CLEAR ls_frequency.
      ls_frequency-romaji = ls_prev_kana-romaji.
      ls_frequency-abs = ls_frequency-abs + 1.
      CASE ls_statistics-status.
        WHEN mc_right.
          ls_frequency-abs_right = ls_frequency-abs_right + 1.
        WHEN mc_wrong.
          ls_frequency-abs_wrong = ls_frequency-abs_wrong + 1.
      ENDCASE.
      MODIFY TABLE mt_frequencies FROM ls_frequency.
    ENDIF.

    CLEAR: ms_cumulatives-abs_ok,
           ms_cumulatives-abs_wrong.
    LOOP AT mt_frequencies INTO ls_frequency.
      IF ls_frequency-abs_right IS INITIAL AND
         ls_frequency-abs_wrong IS INITIAL.
        CONTINUE.
      ENDIF.
      ms_cumulatives-abs_ok = ms_cumulatives-abs_ok + ls_frequency-abs_right.
      ms_cumulatives-abs_wrong = ms_cumulatives-abs_wrong + ls_frequency-abs_wrong.
    ENDLOOP.

  ENDMETHOD.

  METHOD get_results.
    DATA:
      lt_reversestats TYPE tt_statsunsorted,
      ls_firststat    TYPE ty_statistics,
      ls_endstat      TYPE ty_statistics,
      lt_kanastat     TYPE tt_statistics,
      ls_kanastat     TYPE ty_statistics,
      ls_results      TYPE lcl_screen_handlerv2=>ty_results,
      ls_prev_kana    TYPE lcl_kana2=>ty_kana,
      ls_curr_kana    TYPE lcl_kana2=>ty_kana,
      ls_frequency    TYPE ty_frequency.

    DATA: lv_dif TYPE i.
*      BEGIN OF ty_results,
*        avg_time       TYPE i,
*        avg_ok         TYPE i,
*        avg_wrong      TYPE i,
*        avg_kana_time  TYPE i,
*        avg_kana_ok    TYPE i,
*        avg_kana_wrong TYPE i,
*      END OF ty_results.


*      BEGIN OF ty_statistics,
*        time   TYPE ty_timestamp,
*        status TYPE ty_status,
*        romaji TYPE lcl_kana=>ty_kana-romaji,
*      END OF ty_statistics,

    IF ms_cumulatives-absolute < 2.
      CLEAR rs_results.
      RETURN.
    ENDIF.

    lt_reversestats = mt_statistics.
    SORT lt_reversestats DESCENDING.


    READ TABLE mt_statistics INTO ls_firststat INDEX 1.
    READ TABLE lt_reversestats INTO ls_endstat INDEX 1.

    ms_cumulatives-ellapsed_timestamp = cl_abap_tstmp=>subtract(
      tstmp1 = ls_endstat-time
      tstmp2 = ls_firststat-time
    ).

    ls_results-avg_time = trunc( ms_cumulatives-ellapsed_timestamp * 1000 ).
    ls_results-avg_ok =  ( ms_cumulatives-abs_ok * 100 ) / ( ms_cumulatives-absolute - 1 ).
    ls_results-avg_wrong = ( ms_cumulatives-abs_wrong * 100 ) / ( ms_cumulatives-absolute - 1 ).

    lt_kanastat = mt_statistics.
    ls_prev_kana = mr_source->get_prev_kana( ).
    ls_curr_kana = mr_source->get_curr_kana( ).
    DELETE lt_kanastat WHERE romaji <> ls_prev_kana-romaji.
    READ TABLE lt_kanastat INTO ls_firststat INDEX 1.
    lt_reversestats = lt_kanastat.
    SORT lt_reversestats DESCENDING.
    READ TABLE lt_reversestats INTO ls_endstat INDEX 1.

    ms_cumulatives-ell_kana_timestamp = cl_abap_tstmp=>subtract(
      tstmp1 = ls_endstat-time
      tstmp2 = ls_firststat-time
    ).

    ls_results-avg_kana_time = trunc( ms_cumulatives-ell_kana_timestamp * 1000 ).
    READ TABLE mt_frequencies INTO ls_frequency WITH KEY romaji = ls_prev_kana-romaji.
    IF sy-subrc = 0.
      IF ms_cumulatives-last_choice = mc_right.
        ls_results-kana = ls_prev_kana-romaji.
      ELSE.
        ls_results-kana = ls_curr_kana-romaji.
      ENDIF.
      ls_results-avg_kana_ok = ( ls_frequency-abs_right * 100 ) / ls_frequency-abs.
      ls_results-avg_kana_wrong = ( ls_frequency-abs_wrong * 100 ) / ls_frequency-abs.
    ENDIF.

    rs_results = ls_results.
  ENDMETHOD.

  METHOD set_source.
    mr_source = ir_source.
  ENDMETHOD.

  METHOD input_ok.
    ms_cumulatives-last_choice = mc_right.
  ENDMETHOD.

  METHOD input_wrong.
    ms_cumulatives-last_choice = mc_wrong.
  ENDMETHOD.

ENDCLASS.
