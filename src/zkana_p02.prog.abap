*&---------------------------------------------------------------------*
*& Include          ZKANA_P02
*&---------------------------------------------------------------------*
CLASS lcl_screen_handler IMPLEMENTATION.
  METHOD status_0100.
    SET PF-STATUS 'STATUS_MAIN'.
  ENDMETHOD.

  METHOD set_source.
    mr_source = ir_source.
  ENDMETHOD.

  METHOD show_0100.

    DATA:
      lt_raw_html TYPE tchar255,
      lv_url      TYPE char255.

    IF mr_container_html IS NOT BOUND.
      CREATE OBJECT mr_container_html
        EXPORTING
          container_name = 'SCC_KANA'.

      CREATE OBJECT mr_html_pic
        EXPORTING
          parent = mr_container_html.


    ENDIF.

    lt_raw_html = mr_source->get_random_html( ).


*...Loading data to HTML
    CALL METHOD mr_html_pic->load_data
      EXPORTING
        url          = lv_url
      IMPORTING
        assigned_url = lv_url
      CHANGING
        data_table   = lt_raw_html.

*...Showing data of HTML
    CALL METHOD mr_html_pic->show_data
      EXPORTING
        url = lv_url.

  ENDMETHOD.
ENDCLASS.
