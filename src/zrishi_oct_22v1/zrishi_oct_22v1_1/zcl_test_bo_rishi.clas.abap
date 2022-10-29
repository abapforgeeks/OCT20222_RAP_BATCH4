CLASS zcl_test_bo_rishi DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TEST_BO_RISHI IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
*  //test Read
*    DATA: lt_po_keys TYPE TABLE FOR READ IMPORT zi_purchaseheaderv1.
*    lt_po_keys = VALUE #( (  %pky-PurchaseOrderNumber = '0000001000' )
*                           ( %pky-PurchaseOrderNumber = '0000001001' ) ).
*
*    "Read with All fields V1
*    READ ENTITY zi_purchaseheaderv1
*    ALL FIELDS WITH VALUE #( FOR keys IN lt_po_keys (  keys  ) )
*    RESULT DATA(lt_podata)
*    FAILED DATA(lt_failed)
*    REPORTED DATA(lt_reported).
*    out->write( lt_podata ).



*    "Read with morethan one key
*    READ ENTITY zi_purchaseheaderv1
*    FIELDS ( PurchaseOrderNumber Description Imageurl )
*    WITH VALUE #( (  %pky-PurchaseOrderNumber = '0000001000' )  )
*    RESULT lt_podata.
*
*
*    out->write( lt_podata ).

    "Read by association.
*    READ ENTITY zi_purchaseheaderv1
*    BY \_PurchaseItems
*    ALL FIELDS WITH VALUE #( ( %key-PurchaseOrderNumber = '0000001000' ) )
*    RESULT DATA(lt_items).
*    out->write( lt_items ).



    "Create
*    MODIFY ENTITY zi_purchaseheaderv1
*    CREATE FIELDS ( Description CompanyCode OrderStatus )
*     WITH VALUE #(
*            ( %cid = 'cid1'  Description = 'Test from BO'
*             CompanyCode = '10' OrderStatus = '02' ) )
*             MAPPED DATA(lt_mapped).
*    COMMIT ENTITIES.
    "Update
    "CREATE BY assoc (child entity)
    MODIFY ENTITY zi_purchaseheaderv1
    CREATE BY \_PurchaseItems
    FIELDS ( Plant ItemPrice Material MatGroup  ) WITH VALUE #(
        ( purchaseordernumber = '0000001011'
            %target = VALUE #( ( %cid = 'CID_1'
                                 Plant = '1010'
                                 itemprice = '100.00'
                                 material = 'Mat1'
                                 matgroup = 'MG1' )

                                 (
                                  %cid = 'CID_2'
                                Plant = '1010'
                                 itemprice = '100.00'
                                 material = 'Mat2'
                                 matgroup = 'MG2' ) )

         )


              ).
    COMMIT ENTITIES.

  ENDMETHOD.
ENDCLASS.
