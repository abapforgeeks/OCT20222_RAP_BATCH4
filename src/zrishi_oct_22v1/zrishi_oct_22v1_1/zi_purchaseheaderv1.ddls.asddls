@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Header Details'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
//@VDM.viewtype: #BASIC
define root view entity ZI_PURCHASEHEADERV1 as select from zpoheader_db
composition[*] of ZI_PURCHASEITEMSV1 as _PurchaseItems
association[1] to ZI_OrderType as _OrderType on $projection.OrderType = _OrderType.PoType
association[1] to ZI_PurchaseStatus as _OrderStatus on $projection.OrderStatus = _OrderStatus.Postatus
association[1] to ZI_Supllier as _Supplier on $projection.Supplier = _Supplier.Supplierid
{
    key po_order as PurchaseOrderNumber,
    po_desc as Description,
    po_type as OrderType,
    comp_code as CompanyCode,
    po_org as Organization,
    po_status as OrderStatus,
    supplier as Supplier,
    imageurl as Imageurl,
    @Semantics.user.createdBy: true
    create_by as CreateBy,
    @Semantics.systemDateTime.createdAt: true
    created_date_time as CreatedDateTime,
    @Semantics.systemDateTime.localInstanceLastChangedAt: true
    
    changed_date_time as ChangedDateTime,
    @Semantics.user.lastChangedBy: true
    local_last_changed_by as LocalLastChangedBy,
  
    _PurchaseItems,
    _OrderType,
    _OrderStatus,
    _Supplier
}
