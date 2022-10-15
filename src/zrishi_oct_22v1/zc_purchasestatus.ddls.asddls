@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption PO Status'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZC_PURCHASESTATUS as select from ZI_PurchaseStatus {
@ObjectModel.text.element: ['Statusdesc']

    key Postatus,
    @Semantics.text: true
    @EndUserText.label: 'Status Description'
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.7
    Statusdesc
}
