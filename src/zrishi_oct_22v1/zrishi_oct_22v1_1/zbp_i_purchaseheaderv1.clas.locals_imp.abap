

CLASS lhc_ZI_PURCHASEHEADERV1 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR PurchaseOrder RESULT result.

    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE purchaseorder.
    METHODS earlynumbering_cba_poitems FOR NUMBERING
      IMPORTING entities FOR CREATE purchaseorder\_PurchaseItems.


ENDCLASS.

CLASS lhc_ZI_PURCHASEHEADERV1 IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD earlynumbering_create.
    DATA: lv_ponumber TYPE c LENGTH 10.

    SELECT MAX( po_order ) FROM zpoheader_db INTO @lv_ponumber.
    IF sy-subrc EQ 0.
      DATA(lt_final_keys) = entities.
      LOOP AT lt_final_keys INTO DATA(ls_entity) .
        lv_ponumber += 1.
*        unpack lv_ponumber to input.
        ls_entity-PurchaseOrderNumber = |{ lv_ponumber  ALPHA = IN }| .
        APPEND VALUE #( %cid = ls_entity-%cid %key = ls_entity-%key ) TO mapped-purchaseorder.
      ENDLOOP.

    ENDIF.
  ENDMETHOD.


  METHOD earlynumbering_cba_poitems.
    DATA: lv_po_item TYPE ebelp.
    SELECT po_order,
           po_item AS itemno
    FROM zpoitems_db
    FOR ALL ENTRIES IN @entities
    WHERE po_order EQ @entities-purchaseordernumber
    INTO TABLE @DATA(lt_poitems).


      DATA(lt_final_keys) = entities.


      LOOP AT lt_final_keys INTO DATA(ls_final_key) .

        SELECT MAX( itemno ) FROM @lt_poitems AS itemkeys
         WHERE po_order = @ls_final_key-purchaseordernumber
         INTO @DATA(lv_itemno).

        LOOP AT ls_final_key-%target INTO DATA(ls_item).

          lv_itemno += 10.
          ls_item-PurchaseItem = |{ lv_itemno ALPHA = IN }|.
          APPEND VALUE #( %cid = ls_item-%cid %key = ls_item-%key ) TO mapped-purchaseitems.

        ENDLOOP.


      ENDLOOP.


  ENDMETHOD.

ENDCLASS.
