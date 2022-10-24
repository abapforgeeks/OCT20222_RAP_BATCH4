@EndUserText.label: 'Projecctio of BO Root'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: ['PurchaseOrderNumber']
@Search.searchable: true
define root view entity ZC_PURCHASEHEADERTP
  provider contract transactional_query
  as projection on ZI_PurchaseHeaderTP
{
      @ObjectModel.text.element: ['Description']
  key PurchaseOrderNumber,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      @Search.ranking: #HIGH
      Description,
      @Semantics.amount.currencyCode: 'PriceUnit'
      PurchaseTotalPrice,
      @UI.hidden: true
      PriceUnit,
      @Consumption.valueHelpDefinition: [{ entity:{name: 'ZC_ORDERTYPE',element: 'PoType'  } } ]
      OrderType,
      CompanyCode,
      Organization,
      @Search.defaultSearchElement: true
      @Search.ranking: #MEDIUM
      @Consumption.valueHelpDefinition: [{ entity:{ name: 'ZC_SUPPLIER', element: 'Supplierid' },
      additionalBinding: [{ element: 'CompanyCodeSupplier' ,localElement: 'CompanyCode'}] }]
      @ObjectModel.text.element: ['SupplierName']
      @Consumption.filter:{multipleSelections: false }
      Supplier,
      _SupplierData.SupplierName,
      @Semantics.imageUrl: true
      Imageurl,
      @UI.hidden: true
      CriticalityValue,

      CreateBy,
      @Consumption.valueHelpDefinition: [{ entity:{name: 'ZC_PURCHASESTATUS',element: 'Postatus'  } } ]
      @ObjectModel.text.element: ['StatusDesc']
      OrderStatus,
      last_changed_at,
      _OrderStatus.Statusdesc,
     
      CreatedDateTime,
      ChangedDateTime,
      LocalLastChangedBy,
      /* Associations */
      _OrderType,
      @Search.defaultSearchElement: true
      _POItems : redirected to composition child ZC_PURCHASEITEMSTP,
      _SupplierData
}
