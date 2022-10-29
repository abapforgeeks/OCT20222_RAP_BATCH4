CLASS lcl_buffer_class_um DEFINITION.
  PUBLIC SECTION.
    CLASS-DATA: mt_po_data  TYPE zif_rishi_rap_types=>mt_po_header,
                mt_po_items TYPE zif_rishi_rap_types=>mt_po_items.
ENDCLASS.



CLASS lhc_ZI_PURCHASEHEADERTP_UM DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zi_purchaseheadertp_um RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE zi_purchaseheadertp_um.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zi_purchaseheadertp_um.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zi_purchaseheadertp_um.

    METHODS read FOR READ
      IMPORTING keys FOR READ zi_purchaseheadertp_um RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zi_purchaseheadertp_um.

    METHODS rba_Poitems FOR READ
      IMPORTING keys_rba FOR READ zi_purchaseheadertp_um\_Poitems FULL result_requested RESULT result LINK association_links.

    METHODS cba_Poitems FOR MODIFY
      IMPORTING entities_cba FOR CREATE zi_purchaseheadertp_um\_Poitems.

ENDCLASS.

CLASS lhc_ZI_PURCHASEHEADERTP_UM IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD create.

    DATA: ls_header TYPE zpoheader_db.
    DATA(lv_test) = abap_true.
    LOOP AT entities INTO DATA(ls_po_header).
      ls_header = CORRESPONDING #( ls_po_header MAPPING FROM ENTITY ).
      APPEND ls_header TO lcl_buffer_class_um=>mt_po_data.
*      mapped-purchaseorders[ sy-tabix ]-PurchaseOrderNumber = ls_header-po_order.
    ENDLOOP.
    mapped-purchaseorders = VALUE #( for ls_key in lcl_buffer_class_um=>mt_po_data
                                        (  PurchaseOrderNumber = ls_key-po_order )
                                            )    .

  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD rba_Poitems.
  ENDMETHOD.

  METHOD cba_Poitems.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZI_PURCHASEITEMSTP_UM DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zi_purchaseitemstp_um.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zi_purchaseitemstp_um.

    METHODS read FOR READ
      IMPORTING keys FOR READ zi_purchaseitemstp_um RESULT result.

    METHODS rba_Purchaseheader FOR READ
      IMPORTING keys_rba FOR READ zi_purchaseitemstp_um\_Purchaseheader FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_ZI_PURCHASEITEMSTP_UM IMPLEMENTATION.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD rba_Purchaseheader.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZI_PURCHASEHEADERTP_UM DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZI_PURCHASEHEADERTP_UM IMPLEMENTATION.

  METHOD finalize.
    DATA(lv_test) = abap_true.
  ENDMETHOD.

  METHOD check_before_save.
    DATA(lv_test) = abap_true.

  ENDMETHOD.

  METHOD save.
    DATA(lv_test) = abap_true.
    IF lcl_buffer_class_um=>mt_po_data IS NOT INITIAL.
      CALL FUNCTION 'ZRISHI_OCT22_SAVE_PO'
        EXPORTING
          it_po_header = lcl_buffer_class_um=>mt_po_data.
*        it_po_items  =
    ENDIF.
  ENDMETHOD.

  METHOD cleanup.
    DATA(lv_test) = abap_true.
  ENDMETHOD.

  METHOD cleanup_finalize.
    DATA(lv_test) = abap_true.
  ENDMETHOD.

ENDCLASS.
