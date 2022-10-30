@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Donut Chart for Purchase Orders Overview'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZC_PurchaseOrdersCard1_V1 as select from ZI_PurchaseHeaderTP {
    key PurchaseOrderNumber,
    Description,
    Priority,
    _Priority.Description as PriorityText,
    OrderStatus,
    _OrderStatus.Statusdesc as StatusText,
    @Aggregation.default: #SUM
    1 as SumofDocument
}
