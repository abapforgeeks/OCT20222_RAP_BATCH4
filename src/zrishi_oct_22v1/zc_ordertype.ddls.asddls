@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Order Type'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
//Enable text search and also make it Valuhelp
define view entity ZC_ORDERTYPE
  as select from ZI_OrderType
{
      @Search.defaultSearchElement: true

  key PoType,
      IsActive
}
