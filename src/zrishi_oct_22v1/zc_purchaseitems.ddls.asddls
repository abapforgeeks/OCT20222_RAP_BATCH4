@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Items'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZC_PurchaseItems
  as select from ZI_PurchaseItems
  association [1] to ZC_PurchaseHeaderDetails as _PurchaseHeader on $projection.PurchaseOrderNumber = _PurchaseHeader.PurchaseOrderNumber
{

  key PurchaseOrderNumber,
      @ObjectModel.text.element: ['ShortText']
      @UI.lineItem: [{ position: 10, label: 'Item' }]
  key PurchaseItem,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      ShortText,
      @UI.lineItem: [{ position: 20, label: 'Material' }]
      Material,
      @UI.lineItem: [{ position: 30, label: 'Plant' }]
      Plant,
      @UI.lineItem: [{ position: 40, label: 'Material Group' }]
      MatGroup,
      @Semantics.quantity.unitOfMeasure: 'OrderUnit'
      @UI.lineItem: [{ position: 50, label: 'Quantity' }]
     // @UI.textArrangement: #TEXT_ONLY
      OrderQunt,
      //  @UI.hidden: true
      OrderUnit,
      @Semantics.amount.currencyCode: 'PriceUnit'
      @UI.lineItem: [{ position: 60, label: 'Price' }]
      //@UI.textArrangement: #TEXT_ONLY
      ProductPrice,
      @UI.lineItem: [{ position: 70, label: 'Item Toal Price' }]
      @Semantics.amount.currencyCode: 'PriceUnit'
      ItemPrice,
      PriceUnit,
      LocalLastChangedBy,
      /* Associations */
      _Currency,
      _PurchaseHeader
}
