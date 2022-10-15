@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Supplier'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZC_Supplier
  as select from ZI_Supllier
{

      @ObjectModel.text.element: ['SupplierName']
  key Supplierid,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      @Search.ranking: #HIGH
      @EndUserText.label: 'Supplier Name'
      @Semantics.text: true
      @Semantics.name.fullName: true
      @UI.identification: [{ position: 10, label: 'Supplier Name' }]
      SupplierName,
      @EndUserText.label: 'Email'
      @Semantics.eMail.type: [  #WORK ]
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @UI.identification: [{ position: 10, label: 'Supplier Name' }] 
     EmailAddress,
      @EndUserText.label: 'Phone Number'
      @Semantics.telephone.type: [ #WORK ]
      @UI.identification: [{ position: 10, label: 'Supplier Name' }]
      PhoneNumber,
      @EndUserText.label: 'Fax Number'
      @Semantics.telephone.type: [ #FAX ]
      @UI.identification: [{ position: 10, label: 'Supplier Name' }] 
      FaxNumber,
      '1000' as CompanyCodeSupplier,
      WebAddress
}
