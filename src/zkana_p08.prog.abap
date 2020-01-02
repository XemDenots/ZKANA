*&---------------------------------------------------------------------*
*& Include          ZKANA_P08
*&---------------------------------------------------------------------*
CLASS lcl_screen_handlerv3 IMPLEMENTATION.

  METHOD show_det_stats.
    IF mr_container IS NOT BOUND.

      CREATE OBJECT mr_container
        EXPORTING
*         parent                      =
          width                       = 1000
          height                      = 200
*         style                       =
*         repid                       =
*         dynnr                       =
*         lifetime                    = lifetime_default
          top                         = 50
          left                        = 800
          caption                     = sy-title
*         no_autodef_progid_dynnr     =
*         metric                      = 0
*         name                        =
        EXCEPTIONS
          cntl_error                  = 1
          cntl_system_error           = 2
          create_error                = 3
          lifetime_error              = 4
          lifetime_dynpro_dynpro_link = 5
          event_already_registered    = 6
          error_regist_event          = 7
          OTHERS                      = 8.
      IF sy-subrc <> 0.
*     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*                WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
      ENDIF.

      SET HANDLER on_close FOR mr_container.

      prepare_alvstat( ).
      set_fieldcatalog( ).

    ENDIF.

    show_alvstat( ).


  ENDMETHOD.

  METHOD status_0200.
    status_0100( ).
  ENDMETHOD.

  METHOD show_0100.
    super->show_0100( ).
    mr_sourcev3->mr_det_stats->add_stat( ms_results ).

  ENDMETHOD.

  METHOD set_sourcev3.
    mr_sourcev3 = ir_source.
  ENDMETHOD.

  METHOD prepare_alvstat.
    IF mr_alvstat IS NOT BOUND.
      CREATE OBJECT mr_alvstat
        EXPORTING
*         i_shellstyle      = 0
*         i_lifetime        =
          i_parent          = mr_container
*         i_appl_events     = space
*         i_parentdbg       =
*         i_applogparent    =
*         i_graphicsparent  =
*         i_name            =
*         i_fcat_complete   = SPACE
        EXCEPTIONS
          error_cntl_create = 1
          error_cntl_init   = 2
          error_cntl_link   = 3
          error_dp_create   = 4
          OTHERS            = 5.
      IF sy-subrc <> 0.
*       MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*                  WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
      ENDIF.
    ENDIF.



  ENDMETHOD.

  METHOD show_alvstat.
    IF mt_datatab IS INITIAL.
      mt_datatab = mr_sourcev3->mr_det_stats->get_timestat_ref( ).
    ENDIF.
    CALL METHOD mr_alvstat->set_table_for_first_display
*      EXPORTING
*       i_buffer_active =
*       i_bypassing_buffer            =
*       i_consistency_check           =
*       i_structure_name              =
*       is_variant      =
*       i_save          =
*       i_default       = 'X'
*       is_layout       =
*       is_print        =
*       it_special_groups             =
*       it_toolbar_excluding          =
*       it_hyperlink    =
*       it_alv_graphics =
*       it_except_qinfo =
*       ir_salv_adapter =
      CHANGING
        it_outtab                     = mt_datatab
        it_fieldcatalog               = mt_fieldcatalog
*       it_sort                       =
*       it_filter                     =
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        OTHERS                        = 4.
    IF sy-subrc <> 0.
*     Implement suitable error handling here
    ENDIF.

  ENDMETHOD.

  METHOD set_fieldcatalog.
    DATA:
      ls_fieldcatalog TYPE lvc_s_fcat.

    IF mt_fieldcatalog IS NOT INITIAL.
      RETURN.
    ENDIF.

    CLEAR ls_fieldcatalog.
    ls_fieldcatalog-fieldname = 'SYMBOL'.
    ls_fieldcatalog-inttype = 'c'.
    ls_fieldcatalog-outputlen = 3.
    ls_fieldcatalog-reptext = 'Kana'.
    ls_fieldcatalog-key = 'X'.
    APPEND ls_fieldcatalog TO mt_fieldcatalog.

    CLEAR ls_fieldcatalog.
    ls_fieldcatalog-fieldname = 'ROMAJI'.
    ls_fieldcatalog-inttype = 'c'.
    ls_fieldcatalog-outputlen = 5.
    ls_fieldcatalog-reptext = 'Romaji'.
    ls_fieldcatalog-key = 'X'.
    APPEND ls_fieldcatalog TO mt_fieldcatalog.

    CLEAR ls_fieldcatalog.
    ls_fieldcatalog-fieldname = 'AVG_TIME'.
    ls_fieldcatalog-datatype = 'INT4'.
    ls_fieldcatalog-outputlen = 15.
    ls_fieldcatalog-reptext = 'Avg'.
    APPEND ls_fieldcatalog TO mt_fieldcatalog.

    CLEAR ls_fieldcatalog.
    ls_fieldcatalog-fieldname = 'AVG_OK'.
    ls_fieldcatalog-datatype = 'INT4'.
    ls_fieldcatalog-outputlen = 15.
    ls_fieldcatalog-reptext = 'Avg Ok'.
    APPEND ls_fieldcatalog TO mt_fieldcatalog.

    CLEAR ls_fieldcatalog.
    ls_fieldcatalog-fieldname = 'AVG_WRONG'.
    ls_fieldcatalog-datatype = 'INT4'.
    ls_fieldcatalog-outputlen = 15.
    ls_fieldcatalog-reptext = 'Avg Wrong'.
    APPEND ls_fieldcatalog TO mt_fieldcatalog.

  ENDMETHOD.

  METHOD on_close.
    IF sender IS NOT INITIAL.
      sender->free( ).
    ENDIF.
    FREE mr_container.
    SET USER-COMMAND 'ENTE'.
  ENDMETHOD.
ENDCLASS.
