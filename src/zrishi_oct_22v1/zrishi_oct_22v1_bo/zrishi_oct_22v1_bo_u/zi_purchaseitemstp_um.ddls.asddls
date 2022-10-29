@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Order Items child of ZZI_PurchaseHeaderTP'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_PURCHASEITEMSTP_UM as select from ZI_PurchaseItems
association to parent ZI_PURCHASEHEADERTP_UM as _PurchaseHeader 
on $projection.PurchaseOrderNumber
= _PurchaseHeader.PurchaseOrderNumber 
 { 
    key PurchaseOrderNumber,
    key PurchaseItem,
    ShortText,
    Material,
    Plant,
    MatGroup,
    @Semantics.quantity.unitOfMeasure: 'OrderUnit'
    OrderQunt,
    OrderUnit,
    @Semantics.amount.currencyCode: 'PriceUnit'
    ProductPrice,
    PriceUnit,
    ItemPrice,
    LocalLastChangedBy,
    local_last_changed_at as LocalLastChangedAt,
    /* Associations */
    _Currency,
    _PurchaseHeader
}
