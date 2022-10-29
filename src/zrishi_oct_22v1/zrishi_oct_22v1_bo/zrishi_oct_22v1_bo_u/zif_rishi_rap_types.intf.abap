INTERFACE zif_rishi_rap_types
  PUBLIC .
TYPES: mt_po_header TYPE STANDARD TABLE OF zpoheader_db WITH DEFAULT KEY,
       mt_po_items type STANDARD TABLE OF zpoitems_db with DEFAULT KEY.

ENDINTERFACE.
