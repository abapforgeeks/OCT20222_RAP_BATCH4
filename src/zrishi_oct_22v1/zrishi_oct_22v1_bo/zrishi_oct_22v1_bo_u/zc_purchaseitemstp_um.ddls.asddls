@EndUserText.label: 'Projection BO Items'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@UI.headerInfo:{
typeName: 'PurchaseItem',
typeNamePlural: 'Purchase Items',

title:{ value: 'ShortText' },
description:{

label: 'Manage Purchase Orders',
type: #STANDARD,
value: 'PurchaseItem'
}
}
define view entity ZC_PURCHASEITEMSTP_UM
  as projection on ZI_PURCHASEITEMSTP_UM
{
      @UI.facet: [{
      id:'ItemData',
      type:#IDENTIFICATION_REFERENCE,
      label: 'Item Info',
      position: 10,
      purpose: #STANDARD
       }]
  key PurchaseOrderNumber,
      @ObjectModel.text.element: ['ShortText']
      @UI.lineItem: [{ position: 10, label: 'Item' }]
  key PurchaseItem,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      @UI.identification: [{ position: 10, label: 'Item Description' }]
      ShortText,
      @UI.lineItem: [{ position: 20, label: 'Material' }]
      @UI.identification: [{ position: 20, label: 'Material' }]
      Material,
      @UI.identification: [{ position: 30, label: 'Plant' }]
      @UI.lineItem: [{ position: 30, label: 'Plant' }]
      Plant,
      @UI.identification: [{ position: 40, label: 'Plant' }]
      @UI.lineItem: [{ position: 40, label: 'Material Group' }]
      MatGroup,
      @Semantics.quantity.unitOfMeasure: 'OrderUnit'
      @UI.lineItem: [{ position: 50, label: 'Quantity' }]
      // @UI.textArrangement: #TEXT_ONLY
      @UI.identification: [{ position: 50, label: 'Quantity' }]

      OrderQunt,
      //  @UI.hidden: true
      @UI.identification: [{ position: 50, label: 'Unit' }]
      OrderUnit,
      @Semantics.amount.currencyCode: 'PriceUnit'
      @UI.lineItem: [{ position: 60, label: 'Product Price' }]
      //@UI.textArrangement: #TEXT_ONLY
      @UI.identification: [{ position: 60, label: 'Product Price' }]
      ProductPrice,
      @UI.lineItem: [{ position: 70, label: 'Item Toal Price' }]
      //       @ObjectModel.readOnly: true
      @Semantics.amount.currencyCode: 'PriceUnit'
      @UI.identification: [{ position: 70, label: 'Item Toal Price' }]
      ItemPrice,
      @UI.identification: [{ position: 80, label: 'Currency' }]
      PriceUnit,
      LocalLastChangedBy,
      /* Associations */
      _Currency,
      _PurchaseHeader : redirected to parent ZC_PURCHASEHEADERTP_UM
}
