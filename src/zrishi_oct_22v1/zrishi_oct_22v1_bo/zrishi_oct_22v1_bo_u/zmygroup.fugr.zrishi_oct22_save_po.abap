FUNCTION zrishi_oct22_save_po.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IT_PO_HEADER) TYPE  ZIF_RISHI_RAP_TYPES=>MT_PO_HEADER
*"     VALUE(IT_PO_ITEMS) TYPE  ZIF_RISHI_RAP_TYPES=>MT_PO_ITEMS
*"       OPTIONAL
*"----------------------------------------------------------------------
  MODIFY zpoheader_db FROM TABLE @it_po_header.




ENDFUNCTION.
