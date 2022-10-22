@EndUserText.label: 'projcetion'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity ZC_PURCHASEITEMSV1
  as projection on ZI_PURCHASEITEMSV1

{
  key PurchaseOrderNumber,
  key PurchaseItem,
      ShortText,
      Material,
      Plant,
      MatGroup,
      OrderQunt,
      OrderUnit,
      ProductPrice,
      PriceUnit,
      ItemPrice,
      LocalLastChangedBy,
      LocalLastChangedAt,
      /* Associations */
      _Currency,
      _PurchaseOrder : redirected to parent ZC_PURCHASEHEADERV1
}
