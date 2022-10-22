@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Items'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_PURCHASEITEMSV1 as select from zpoitems_db
association to parent ZI_PURCHASEHEADERV1 as _PurchaseOrder 
on $projection.PurchaseOrderNumber = _PurchaseOrder.PurchaseOrderNumber

association[1] to I_Currency as _Currency on $projection.PriceUnit = _Currency.Currency

{
    key po_order as PurchaseOrderNumber,
    key po_item as PurchaseItem,
    short_text as ShortText,
    material as Material,
    plant as Plant,
    mat_group as MatGroup,
    @Semantics.quantity.unitOfMeasure: 'OrderUnit'
    order_qunt as OrderQunt,
    order_unit as OrderUnit,
    @Semantics.amount.currencyCode: 'PriceUnit'
    product_price as ProductPrice,
    price_unit as PriceUnit,
   // @Semantics.amount.currencyCode: 'PriceUnit'
    cast(  cast( order_qunt as abap.dec( 10, 2 )) * cast( product_price as abap.dec(10,2)) as abap.dec(10,2))   as ItemPrice,
    @Semantics.user.lastChangedBy: true
    local_last_changed_by as LocalLastChangedBy,
    @Semantics.systemDateTime.localInstanceLastChangedAt: true
    local_last_changed_at as LocalLastChangedAt,
    _PurchaseOrder,
    _Currency
}
