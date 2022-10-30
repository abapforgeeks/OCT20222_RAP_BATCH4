@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Filter View'
@Metadata.allowExtensions: true
define view entity ZC_PURCHASE_OVP_FILTER
  as select from ZI_PurchaseHeaderTP

{
  key PurchaseOrderNumber,
      @Consumption.valueHelpDefinition: [{ entity:{ name:
      'ZC_PURCHASESTATUS',element: 'Postatus'} }]
      OrderStatus,
      @Consumption.valueHelpDefinition: [{ entity:{ name:
      'ZI_PurchasePriority',element: 'Priority'} }]
      Priority
}
