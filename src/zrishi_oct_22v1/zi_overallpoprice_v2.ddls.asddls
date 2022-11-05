@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Header Overall Price'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
//@VDM.viewType: #COMPOSITE
define view entity ZI_OVERALLPOPRICE_V2 as select from ZI_PurchaseHeader 
{
    key PurchaseOrderNumber,
    Description,
    sum( _PurchaseItems.ItemPrice ) as PurchaseTotalPrice,
    _PurchaseItems.PriceUnit,
    OrderType,
    CompanyCode,
    Organization,
    Supplier,
    Imageurl,
 
    CreateBy,
    OrderStatus,
    CreatedDateTime,
    ChangedDateTime,
    LocalLastChangedBy,
    last_changed_at,
    
    /* Associations */
    _OrderType,
    _PurchaseItems,
    _Supplier
}
group by
    PurchaseOrderNumber,
    Description,
    OrderType,
    CompanyCode,
    Organization,
    Supplier,
    Imageurl,
    CreateBy,
    CreatedDateTime,
    ChangedDateTime,
    LocalLastChangedBy,
    OrderStatus,
    last_changed_at,
    _PurchaseItems.PriceUnit
