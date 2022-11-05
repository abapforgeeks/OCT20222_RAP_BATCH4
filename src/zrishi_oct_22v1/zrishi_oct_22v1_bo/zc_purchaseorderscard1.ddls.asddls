@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Order BO'
@Metadata.allowExtensions: true
define root view entity ZC_PurchaseOrdersCard1
  as select from ZI_PurchaseHeaderTP
{
  key PurchaseOrderNumber,
      Description,
      @ObjectModel.text.element: ['PriorityText']
      
      Priority,
      _Priority.Description   as PriorityText,
      @ObjectModel.text.element: ['StatusText']
      OrderStatus,
      _OrderStatus.Statusdesc as StatusText,
      @Aggregation.default: #SUM
      1                       as SumofDocuments,
      _Priority,
      _OrderStatus

}
