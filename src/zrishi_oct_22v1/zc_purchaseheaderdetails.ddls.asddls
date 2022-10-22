@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Header Overall Details'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: ['PurchaseOrderNumber']
@Search.searchable: true
define view entity ZC_PurchaseHeaderDetails
  as select from ZI_OverAllPOPrice
  association [*] to ZC_PurchaseItems  as _Items     on $projection.PurchaseOrderNumber = _Items.PurchaseOrderNumber
  association [1] to ZC_Supplier       as _Supplier  on $projection.Supplier = _Supplier.Supplierid
  association [1] to ZC_ORDERTYPE      as _OrderType on $projection.OrderType = _OrderType.PoType
  association [1] to ZC_PURCHASESTATUS as _Status    on $projection.OrderStatus = _Status.Postatus
{
      @ObjectModel.text.element: ['Description']

  key PurchaseOrderNumber,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      @Search.ranking: #HIGH
      Description,
      @Semantics.amount.currencyCode: 'PriceUnit'
      PurchaseTotalPrice,
      PriceUnit,
      OrderType,
      CompanyCode,
      Organization,
      @Consumption.valueHelpDefinition: [{ entity:{name: 'ZC_PURCHASESTATUS',element: 'Postatus'  } } ]
      @ObjectModel.text.element: ['StatusDesc']
      OrderStatus,
      _Status.Statusdesc     as StatusDesc,
      @Search.defaultSearchElement: true
      @Search.ranking: #MEDIUM
      @Consumption.valueHelpDefinition: [{ entity:{ name: 'ZC_SUPPLIER', element: 'Supplierid' },
      additionalBinding: [{ element: 'CompanyCodeSupplier' ,localElement: 'CompanyCode'}] }]
      @ObjectModel.text.element: ['SupplierName']
      @Consumption.filter:{multipleSelections: false }
      Supplier,
 
      case
      when OrderStatus = '01' then 2
      when OrderStatus = '02' then 3
      when OrderStatus = '03' then 1
      else 0
      end                    as CriticalityValue,



      _Supplier.SupplierName as SupplierName,
      @Semantics.imageUrl: true
      Imageurl,
      CreateBy,
      CreatedDateTime,
      ChangedDateTime,
      LocalLastChangedBy,
      /* Associations */
      _OrderType,
      @Search.defaultSearchElement: true
      _Items,
      _Supplier,
      _Status
}
