*----------------------------------------------------------------------*
***INCLUDE ZKANA_I01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE lcl_screen_handler=>ms_dyn100-okcode.
    WHEN 'BACK'.
      "get_prev_dynnr( ).
      SET SCREEN 0.
    WHEN 'ENTER'.
      "get_next_dynnr( ).
    WHEN 'UP'.
      SET SCREEN 0.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'STATS'.
      gr_kana->mr_screenhandlerv3->show_det_stats( ).
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  CHECK_INPUT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_input INPUT.
  gr_kana->check_input( lcl_screen_handler=>ms_dyn100-romaji ).
ENDMODULE.
