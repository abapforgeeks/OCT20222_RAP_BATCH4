@EndUserText.label: 'Projection Unmanaged'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity ZC_PURCHASEHEADERTP_UM
provider contract transactional_query
  as projection on ZI_PURCHASEHEADERTP_UM
{
  key PurchaseOrderNumber,
      Description,
      PurchaseTotalPrice,
      PriceUnit,
      OrderType,
      CompanyCode,
      Organization,
      Supplier,
      Imageurl,
      CriticalityValue, 
      CreateBy,
      OrderStatus,
      CreatedDateTime,
      ChangedDateTime,
      LocalLastChangedBy,
      last_changed_at,
      /* Associations */
      _OrderStatus,
      _OrderType,
      _POItems  : redirected to composition child ZC_PURCHASEITEMSTP_UM,
      _SupplierData
}
