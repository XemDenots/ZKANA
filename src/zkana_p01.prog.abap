*&---------------------------------------------------------------------*
*& Include          ZKANA_P01
*&---------------------------------------------------------------------*
CLASS lcl_kana IMPLEMENTATION.
  METHOD set_up.
    DATA:
      lv_numentries TYPE i,
      lv_seed       TYPE i.

    SELECT romaji hira_url kata_url INTO TABLE mt_kana FROM ztkana.

    DESCRIBE TABLE mt_kana LINES lv_numentries.
    lv_seed   = cl_abap_random=>seed( ).

    cl_abap_random_int=>create(
      EXPORTING
        seed = lv_seed
        min  = 1
        max  = lv_numentries
      RECEIVING
        prng = mr_rand
    ).

    CREATE OBJECT mr_screenhandler.

    mr_screenhandler->set_source( me ).


  ENDMETHOD.


  METHOD get_random_html.
    IF ms_current_kana IS INITIAL.
      calc_random( ).
    ENDIF.

    APPEND '<HTML><head><base href="https://upload.wikimedia.org/wikipedia/commons/" target="_blank"></head><BODY>' TO rt_html.
    APPEND |<img src="{ ms_current_kana-hira_url }"/>| TO rt_html.
    APPEND |<img src="{ ms_current_kana-kata_url }"/>| TO rt_html.
    " Angle brackets without space
    APPEND '</BODY></HTML>' TO rt_html.
  ENDMETHOD.

  METHOD check_input.
    IF iv_input = ms_current_kana-romaji.
      calc_random( ).
    ENDIF.
  ENDMETHOD.

  METHOD calc_random.
    DATA:
      n    TYPE i.

    n = mr_rand->get_next( ).

    READ TABLE mt_kana INTO ms_current_kana INDEX n.

  ENDMETHOD.
ENDCLASS.
