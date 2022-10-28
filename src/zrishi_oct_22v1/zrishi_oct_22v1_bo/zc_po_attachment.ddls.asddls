@EndUserText.label: 'ZI_PO_ATTACHMENT'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@UI: { 
headerInfo: {
typeName: 'Attachment',
typeNamePlural: 'Attachment',
title:       { type: #STANDARD, value: 'Purchaseordernumber' },
description: { type: #STANDARD, value: 'Purchaseordernumber' } 
            }
            ,
         presentationVariant: [{
         sortOrder: [{ by: 'Purchaseordernumber', direction: #ASC }],
         visualizations: [{type: #AS_LINEITEM}] 
         }] 
      }
define view entity ZC_PO_ATTACHMENT
  as projection on ZI_PO_ATTACHMENT
{

      @UI.facet: [    {
                 label: 'General Information',
                 id: 'GeneralInfo',
                 type: #COLLECTION,
                 position: 10
                 },
                      { id:            'Invoicedet',
                     purpose:       #STANDARD,
                     type:          #IDENTIFICATION_REFERENCE,
                     label:         'Purchase Order',
                     parentId: 'GeneralInfo',
                     position:      10 },
                   {
                       id: 'Upload',
                       purpose: #STANDARD,
                       type: #FIELDGROUP_REFERENCE,
                       parentId: 'GeneralInfo',
                       label: 'Upload Attachment',
                       position: 20,
                       targetQualifier: 'Upload'
                   } ]

      @UI.lineItem: [{ position: 10, label: 'Purchase Order' }]
      @UI.identification: [{ position: 10, label: 'Purchase Order' }]
  key Purchaseordernumber,
      @UI.lineItem: [{ position: 20, label: 'Attachmenn Id' }]
      @UI.identification: [{ position: 20, label: 'Attachmenn Id' }]
  key attachId,
      @UI.fieldGroup: [{ position: 10, label: 'Attachment',qualifier: 'Upload' }]
      @UI.lineItem: [{ position: 30, label: 'File',importance: #HIGH  }]
      Attachment,
      @UI.hidden: true
      Mimetype,
      @UI.hidden: true
      Filename,
      @Semantics.systemDateTime.lastChangedAt: true
      LastChangedAt,
      /* Associations */
      _Header : redirected to parent ZC_PURCHASEHEADERTP
}
