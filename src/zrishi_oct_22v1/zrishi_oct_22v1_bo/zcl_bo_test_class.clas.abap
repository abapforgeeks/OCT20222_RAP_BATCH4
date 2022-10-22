CLASS zcl_bo_test_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_bo_test_class IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA: lt_keys TYPE TABLE FOR READ IMPORT zc_purchaseheadertp.

    lt_keys = VALUE #(  ( %key-PurchaseOrderNumber = '0000001000'
                          %control-Description = 01
                          %control-CompanyCode = 01
                          %control-Imageurl = 01 )  ).


    "Read Enity.
    READ ENTITY zc_purchaseheadertp
    FROM lt_keys
    RESULT DATA(lt_result).
    out->write( lt_result ).

    "read entity with all fields
    READ ENTITY zc_purchaseheadertp
    ALL FIELDS WITH VALUE #( ( %key-PurchaseOrderNumber = '0000001000' ) )
    RESULT lt_result.

    out->write( lt_result ).

    "read by association with keys
    READ ENTITY zc_purchaseheadertp
    by \_POItems
    ALL FIELDS WITH VALUE #( ( %key-PurchaseOrderNumber = '0000001001' ) )
    RESULT data(lt_items).

    out->write( lt_items ).

    "Creation with multiple Fields on Purchase Header
    modify ENTITY zc_purchaseheadertp
    CREATE
*    AUTO FILL CID (if you don't pass %cid used this option
    FIELDS  ( description companycode )
    WITH VALUE #(
                  (
                  %cid = 'CID_1'
*                  PurchaseOrderNumber = '0000001012' //if you implement early number do not pass.
                  Description = 'Test from BO'
                  CompanyCode = '1001' )
                  (
                  %cid = 'CID_2'
*                  PurchaseOrderNumber = '0000001013'
                  Description = 'Test from BO 13'
                  CompanyCode = '1002' )

                   )
                  MAPPED data(lt_mapped).

"Create by association
*MODIFY ENTITY zc_purchaseheadertp
*CREATE
**AUTO FILL CID
*by \_POItems
*FIELDS ( PurchaseItem plant itemprice material matgroup )
*WITH VALUE #( (  purchaseordernumber = '0000001012'
*                 %target = VALUE #( ( %cid = 'CID_ITME_1'
*                                      PurchaseItem = '0010'
*                                      plant = '1010'
*                                      itemprice = 100
*                                       material = 'MaterialNew'
*                                       matgroup = '001')
*
*                                       ( %cid = 'CID_ITME_2'
*                                      PurchaseItem = '0020'
*                                      plant = '1012'
*                                      itemprice = 120
*                                       material = 'MaterialNew'
*                                       matgroup = '002')
*                                       )
*
* ) )
* FAILED data(lt_failed)
* MAPPED lt_mapped
* REPORTED data(lt_reported).
* .

 COMMIT ENTITIES.





  ENDMETHOD.
ENDCLASS.
