@EndUserText.label: 'As Projection'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZC_PURCHASEHEADERV1
  provider contract transactional_query
  as projection on ZI_PURCHASEHEADERV1
{
  key PurchaseOrderNumber,
      Description,
      OrderType,
      CompanyCode,
      Organization,
      OrderStatus,
      Supplier,
      Imageurl,
      CreateBy,
      CreatedDateTime,
      ChangedDateTime, 
      LocalLastChangedBy,
      /* Associations */
      _OrderStatus,
      _OrderType,
      _PurchaseItems : redirected to composition child ZC_PURCHASEITEMSV1,
      _Supplier
}
