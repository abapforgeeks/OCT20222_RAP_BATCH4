@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Priority'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_PurchasePriority
  as select from zpo_priority
{
      @Search.defaultSearchElement: true
  key priority    as Priority,
      @Search.fuzzinessThreshold: 0.7
      @Search.ranking: #HIGH
      @Search.defaultSearchElement: true
      description as Description
}
