CLASS lhc_purchaseitems DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS setPurchaseStatus FOR DETERMINE ON SAVE
      IMPORTING keys FOR PurchaseItems~setPurchaseStatus.

ENDCLASS.

CLASS lhc_purchaseitems IMPLEMENTATION.

  METHOD setPurchaseStatus.
  data: lv_total_price type p LENGTH 10 DECIMALS 2.
*  data(lv_test) = abap_true.
    READ ENTITY in LOCAL MODE
    ZI_PurchaseItemsTP
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT data(lt_items).

    loop at lt_items into data(ls_item).

    lv_total_price = ( ls_item-ProductPrice * ls_item-OrderQunt ) + lv_total_price.

    ENDLOOP.

    data(lv_po_number) = keys[ 1 ]-PurchaseOrderNumber.

    if lv_total_price > 1000.

    MODIFY entity IN LOCAL MODE
    ZI_PurchaseHeaderTP
    UPDATE FIELDS ( OrderStatus   )
    WITH VALUE #( (   PurchaseOrderNumber = lv_po_number OrderStatus = '01' )  )
    REPORTED data(lt_reported).


    ENDIF.

  ENDMETHOD.

ENDCLASS.
