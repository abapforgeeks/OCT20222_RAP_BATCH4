@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'List Card type Bar, Purchase Utilization'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZC_PurchaseOrdersCard2_V1 as select from ZI_PurchaseHeaderTP {
    key PurchaseOrderNumber,
    Description,
    PurchaseTotalPrice,
    PriceUnit,
    Priority,
    CreateBy,
    OrderStatus,
    CreatedDateTime,
    @Semantics.quantity.unitOfMeasure: 'Percentage'  
    cast( ( PurchaseTotalPrice * 100 ) / 50000 as abap.int2 ) as BudgetUsage,
    cast( ' % ' as abap.unit( 3 ) ) as Percentage
    
}
