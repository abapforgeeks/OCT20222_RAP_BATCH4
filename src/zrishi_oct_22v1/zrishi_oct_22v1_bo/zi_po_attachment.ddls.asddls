@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Attachment'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}


define view entity ZI_PO_ATTACHMENT
  as select from zpo_attachment
  association to parent ZI_PurchaseHeaderTP as _Header on $projection.Purchaseordernumber = _Header.PurchaseOrderNumber
{
  key purchaseordernumber as Purchaseordernumber,
  key attah_id            as attachId,
      @Semantics.largeObject:
          { mimeType: 'Mimetype',
          fileName: 'Filename',
          contentDispositionPreference: #INLINE }
      attachment          as Attachment,
      @Semantics.mimeType: true

      mimetype            as Mimetype,

      filename            as Filename,
      last_changed_at     as LastChangedAt,
      _Header
}
