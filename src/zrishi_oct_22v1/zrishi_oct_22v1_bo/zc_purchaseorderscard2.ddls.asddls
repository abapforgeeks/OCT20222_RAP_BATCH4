@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Budget Utilization'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZC_PurchaseOrdersCard2
  as select from ZI_PurchaseHeaderTP
{
  key PurchaseOrderNumber,
      Description,
      PurchaseTotalPrice, 
      PriceUnit,
      Priority,
      CreateBy,
      OrderStatus,
      cast(  PurchaseTotalPrice * 100 / 25000 as abap.int2 ) as BudgentUsage,
      /* Associations */
      _OrderStatus,
      _POItems,
      _Priority
}
