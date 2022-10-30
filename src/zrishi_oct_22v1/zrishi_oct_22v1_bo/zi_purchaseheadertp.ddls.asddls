@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Order BO'
define root view entity ZI_PurchaseHeaderTP
  as select from ZI_OverAllPOPrice
 
  composition [*] of ZI_PurchaseItemsTP  as _POItems
  composition [*] of ZI_PO_ATTACHMENT    as _POAttachment

  association [1] to ZC_Supplier         as _SupplierData on $projection.Supplier = _SupplierData.Supplierid
  association [1] to ZC_PURCHASESTATUS   as _OrderStatus  on $projection.OrderStatus = _OrderStatus.Postatus
  association [1] to ZI_PurchasePriority as _Priority     on $projection.Priority = _Priority.Priority
  association [1] to I_Currency          as _Currenty     on $projection.PriceUnit = _Currenty.Currency
{
  key PurchaseOrderNumber,
      Description,
      PurchaseTotalPrice,
      
      PriceUnit,
      OrderType, 
      CompanyCode,
      Organization,
      Supplier,
      Imageurl,
      case
          when OrderStatus = '01' then 2
          when OrderStatus = '02' then 3
          when OrderStatus = '03' then 1
          else 0
          end as CriticalityValue,
      case
      when PurchaseTotalPrice < 500 then '03'
      when PurchaseTotalPrice > 500 and PurchaseTotalPrice < 1000 then '02'
      when PurchaseTotalPrice > 1000 then '01'
      else '00'
      end     as Priority,
     @Semantics.user.createdBy: true
      CreateBy,
      OrderStatus,
      @Semantics.systemDateTime.createdAt: true
      CreatedDateTime,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      ChangedDateTime,
      @Semantics.user.lastChangedBy: true
      LocalLastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at,

      /* Associations */
      _OrderType,
      _SupplierData,
      _POItems,
      _POAttachment,
      _OrderStatus, // Make association public,
      _Priority,
      _Currenty
}
