*&---------------------------------------------------------------------*
*& Report YRB_SAMPLE_ALV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT yrb_sample_alv.

*Data declaration
DATA: lv_vbeln TYPE vbak-vbeln.
*Select option for input file
SELECT-OPTIONS: s_vbeln FOR lv_vbeln.
*Create Structure for VBAK and VBAP
TYPES : BEGIN OF lty_vbak,
          vbeln TYPE vbeln_va,
          erdat TYPE erdat,
          erzet TYPE erzet,
          ernam TYPE ernam,
          vbtyp TYPE vbtyp,
        END OF lty_vbak,

        BEGIN OF lty_vbap,
          vbeln TYPE vbeln_va,
          posnr TYPE posnr_va,
          matnr TYPE matnr,
        END OF lty_vbap.
*Declare Internal Table and Work Area:
DATA : lt_vbak TYPE TABLE OF lty_vbak,
       ls_vbak TYPE lty_vbak,
       lt_vbap TYPE TABLE OF lty_vbap,
       ls_vbap TYPE lty_vbap.
*Fetch Data from VBAK:
SELECT vbeln erdat erzet ernam vbtyp
  FROM vbak
  INTO TABLE lt_vbak
  WHERE vbeln IN s_vbeln.

IF lt_vbak IS NOT INITIAL.
  SELECT vbeln posnr matnr
    FROM vbap
    INTO TABLE lt_vbap
    FOR ALL ENTRIES IN lt_vbak    "fetch data based on first internal table
    WHERE vbeln = lt_vbak-vbeln.
ENDIF.
