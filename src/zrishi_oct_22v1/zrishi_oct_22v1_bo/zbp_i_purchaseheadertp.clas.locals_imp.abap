CLASS lhc_ZI_PurchaseHeaderTP DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR PurchaseOrder RESULT result.

    METHODS copy FOR MODIFY
      IMPORTING keys FOR ACTION purchaseorder~copy RESULT result.

    METHODS withdrawapproval FOR MODIFY
      IMPORTING keys FOR ACTION purchaseorder~withdrawapproval RESULT result.
    METHODS validatestatus FOR VALIDATE ON SAVE
      IMPORTING keys FOR purchaseorder~validatestatus.

    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE PurchaseOrder.

    METHODS earlynumbering_cba_poitems FOR NUMBERING
      IMPORTING entities FOR CREATE PurchaseOrder\_POItems.

    METHODS earlynumbering_cba_poattach FOR NUMBERING
      IMPORTING entities FOR CREATE PurchaseOrder\_POAttachment.

ENDCLASS.

CLASS lhc_ZI_PurchaseHeaderTP IMPLEMENTATION.

  METHOD get_instance_authorizations.
*  data(lv_test) = abap_true.
*  data(lv_test2) = requested_authorizations-
  ENDMETHOD.

  METHOD earlynumbering_create.
    DATA: lv_max_po TYPE c LENGTH 10.
    SELECT MAX( purchaseordernumber )
      FROM zc_purchaseheadertp
      INTO @lv_max_po.

    DATA(lt_entities) = entities.

    LOOP AT lt_entities INTO DATA(ls_entity).
      lv_max_po = lv_max_po + 1.
      ls_entity-PurchaseOrderNumber = |{ lv_max_po ALPHA = IN }|.

      APPEND VALUE #(   %cid = ls_entity-%cid
                        %is_draft = ls_entity-%is_draft
                        PurchaseOrderNumber = ls_entity-PurchaseOrderNumber )
                         TO mapped-purchaseorder.

    ENDLOOP.


  ENDMETHOD.

  METHOD earlynumbering_cba_poitems.

    READ ENTITY
    IN LOCAL MODE
    ZI_PurchaseHeaderTP
    BY \_POItems
    ALL FIELDS WITH CORRESPONDING #( entities )
    RESULT DATA(lt_poitems).


*    SELECT po_order,
*              po_item AS itemno
*       FROM zpoitems_db
*       FOR ALL ENTRIES IN @entities
*       WHERE po_order EQ @entities-purchaseordernumber
*       INTO TABLE @DATA(lt_poitems).


    DATA(lt_final_keys) = entities.


    LOOP AT lt_final_keys INTO DATA(ls_final_key) .
      "Get Maximum number from item from the PO
      SELECT MAX( purchaseitem ) FROM @lt_poitems AS itemkeys
       WHERE PurchaseOrderNumber = @ls_final_key-purchaseordernumber
       INTO @DATA(lv_itemno).

      LOOP AT ls_final_key-%target INTO DATA(ls_item).
*        lv_itemno += 10.
        IF ls_final_key-%is_draft = 01.
          lv_itemno = lv_itemno + 10.
        ELSE.
          lv_itemno = ls_item-PurchaseItem.
        ENDIF.
        ls_item-PurchaseItem = |{ lv_itemno ALPHA = IN }|.
        APPEND VALUE #( %cid = ls_item-%cid
                         %tky = ls_final_key-%tky
                         %key = ls_item-%key ) TO mapped-purchaseitems.
      ENDLOOP.


    ENDLOOP.

  ENDMETHOD.




  METHOD Copy.

    DATA: lt_keys TYPE TABLE FOR READ IMPORT ZI_PurchaseHeaderTP.

*
    LOOP AT keys INTO DATA(ls_keys).
      APPEND VALUE #( %tky = ls_keys-%tky
                     %control-description = 01
                     %control-companycode = 01
                     %control-OrderType = 01
                     %control-orderstatus = 01
                     %control-supplier = 01
                           ) TO lt_keys.
    ENDLOOP.

*1. Read the Purchase order from the keys which is to be copied.
    READ ENTITY IN LOCAL MODE
    ZI_PurchaseHeaderTP
    FROM lt_keys
    RESULT DATA(lt_purchase_data).

*    modify ENTITY IN LOCAL MODE
*    ZI_purchaseheadertp
*    EXECUTE Edit

*2. create a new entry from the copied PO.
    MODIFY ENTITIES OF
    ZI_PurchaseHeaderTP IN LOCAL MODE
    ENTITY PurchaseOrder
    CREATE AUTO FILL CID
    FIELDS ( description companycode OrderType supplier OrderStatus )
    WITH CORRESPONDING #( lt_purchase_data )
    MAPPED DATA(mapped_created).

*3. we have to retrieve new purchase order.
    READ ENTITIES OF
    ZI_PurchaseHeaderTP
    IN LOCAL MODE
    ENTITY PurchaseOrder
    ALL FIELDS WITH CORRESPONDING #( mapped_created-purchaseorder )
    RESULT DATA(lt_new_po).

    DATA: ls_result TYPE TABLE FOR READ RESULT ZI_PurchaseHeaderTP.
*4. Send back to UI
    LOOP AT lt_new_po INTO DATA(ls_po).


    ENDLOOP.
*    if the %key  is different from key value in %param framework navigates to Object page,
    result = VALUE #(  FOR ls_new_po IN lt_new_po INDEX INTO lv_index

                     (  %key =  ls_new_po-%key
                       %param = CORRESPONDING #( ls_new_po )   )


                      ).
*    result = VALUE #( (  ) ).


  ENDMETHOD.

  METHOD WithdrawApproval.

*    "modify the status
    MODIFY ENTITIES OF ZI_PurchaseHeaderTP
    IN LOCAL MODE
    ENTITY PurchaseOrder
    UPDATE FIELDS ( OrderStatus )
    WITH VALUE #( FOR ls_key IN keys ( %key = ls_key-%key
                                       OrderStatus = '03' )  )
                                       REPORTED DATA(reported_update).


    READ ENTITIES OF
     ZI_PurchaseHeaderTP
     IN LOCAL MODE
     ENTITY PurchaseOrder
     ALL FIELDS WITH CORRESPONDING #( keys )
     RESULT DATA(lt_new_po).

    RESUlt = VALUE #( FOR ls_new_po IN lt_new_po
                    ( %key = ls_new_po-%key
                      %param = CORRESPONDING #( ls_new_po ) )
        )  .


  ENDMETHOD.
*
  METHOD validateStatus.
*
    DATA: lo_ref TYPE REF TO cl_abap_behv.

    CREATE OBJECT lo_ref.
    READ ENTITIES OF
     ZI_PurchaseHeaderTP
     IN LOCAL MODE
     ENTITY PurchaseOrder
     FIELDS ( orderstatus )
     WITH CORRESPONDING #( keys )
     RESULT DATA(lt_new_po).

    LOOP AT lt_new_po INTO DATA(ls_new_po).

      CASE ls_new_po-OrderStatus.

        WHEN '01'.

        WHEN '02'.

        WHEN '03'.

        WHEN OTHERS.

          APPEND VALUE #( %key = ls_new_po-%key ) TO failed-purchaseorder.
          APPEND VALUE #( %key = ls_new_po-%key
*                         %msg = lo_ref->new_message(
*                                  id       =
*                                  number   =
*                                  severity =
**                                  v1       =
**                                  v2       =
**                                  v3       =
**                                  v4       =
*                                )
                          %msg = lo_ref->new_message_with_text(
                                   severity = if_abap_behv_message=>severity-error
                                   text     = 'Purchase Status is Invalid'
                                 )
                          %element-orderstatus = if_abap_behv=>mk-on
                          ) TO reported-purchaseorder.
      ENDCASE.
    ENDLOOP.



  ENDMETHOD.

  METHOD earlynumbering_cba_poattach.

    READ ENTITY
     IN LOCAL MODE
     ZI_PurchaseHeaderTP
     BY \_POAttachment
     ALL FIELDS WITH CORRESPONDING #( entities )
     RESULT DATA(lt_po_attachments).


    DATA(lt_final_keys) = entities.


    LOOP AT lt_final_keys INTO DATA(ls_final_key) .
      "Get Maximum number from item from the PO
      SELECT MAX( attachId ) FROM @lt_po_attachments AS itemkeys
       WHERE PurchaseOrderNumber = @ls_final_key-purchaseordernumber
       INTO @DATA(lv_attach_id).

      LOOP AT ls_final_key-%target INTO DATA(ls_item).
*        lv_itemno += 10.
        IF ls_final_key-%is_draft = 01.
          lv_attach_id = lv_attach_id + 10.
        ELSE.
          lv_attach_id = ls_item-attachId.
        ENDIF.
        ls_item-attachId = |{ lv_attach_id ALPHA = IN }|.
        APPEND VALUE #( %cid = ls_item-%cid
                         %tky = ls_final_key-%tky
                         %key = ls_item-%key ) TO mapped-attachment.
      ENDLOOP.


    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
