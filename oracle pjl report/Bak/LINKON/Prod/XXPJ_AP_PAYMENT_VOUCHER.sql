*************  Group 1          **************************
     select 
    ACA.ORG_ID,
	ORG.ORGANIZATION_NAME,
    ACA.CHECK_ID,  
    ACA.CHECK_NUMBER,  
    ACA.VENDOR_NAME,
    ACA.VENDOR_SITE_CODE,
    ACA.CURRENCY_CODE,
	ACA.PAYMENT_METHOD_CODE,
	ACA.VOID_DATE,
	ACA.DOC_SEQUENCE_VALUE,
	ACA.STATUS_LOOKUP_CODE,
	ap_checks_pkg.get_posting_status(ACA.check_id) posting_status,
	APIP.INVOICE_ID,
    APIP.ACCTS_PAY_CODE_COMBINATION_ID,    
    APIP.ACCOUNTING_DATE,	
    ACA.AMOUNT AMOUNT_Total,
    APIP.AMOUNT AMOUNT_Invoice,
    APIP.BANK_ACCOUNT_NUM,
    CBA.BANK_ACCOUNT_NAME ,
    CBB.BANK_NAME,
    CBB.BANK_BRANCH_NAME  
 from
    AP_CHECKS_ALL ACA, 
	ORG_ORGANIZATION_DEFINITIONS ORG,
    AP_INVOICE_PAYMENTS_ALL APIP,
    CE_BANK_ACCOUNTS CBA,
    CE_BANK_BRANCHES_V CBB 
    where 1=1
	and ACA.DOC_SEQUENCE_VALUE=nvl(:P_PAYMENT_VOUCHER_NUMBER ,ACA.DOC_SEQUENCE_VALUE)  --500301
	and ACA.CHECK_NUMBER=nvl(:P_PAYMENT_NUMBER ,ACA.CHECK_NUMBER)  --500301
	and  ACA.ORG_ID=nvl(:P_ORG ,ACA.ORG_ID)
	and  ACA.VENDOR_NAME=nvl(:P_SUPPLIER ,ACA.VENDOR_NAME)
	and ACA.ORG_ID=ORG.ORGANIZATION_ID
    and   ACA.CHECK_ID=APIP.CHECK_ID
    and  CBA.BANK_ACCOUNT_NAME=ACA.BANK_ACCOUNT_NAME
    and  CBA.BANK_ID=CBB.BANK_PARTY_ID
    and  CBA.BANK_BRANCH_ID=CBB.BRANCH_PARTY_ID
 
 
 

*************  Group 2          **************************
SELECT  
apha.check_id,
xal.code_combination_id,
gck.concatenated_segments account,
xxpj_get_cc_desc (xal.code_combination_id) account_description ,
xal.DESCRIPTION ,
xal.ACCOUNTING_DATE,
xal.ENTERED_DR,
xal.ENTERED_CR,
xal.ACCOUNTED_DR,
xal.ACCOUNTED_CR,
xal.CURRENCY_CODE,
  xal.accounting_class_code
    FROM 
    ap_payment_history_all apha,
           xla_ae_headers xah,
         xla_ae_lines xal,
         gl_code_combinations_kfv  GCK
       
   WHERE 1=1
     AND xah.ae_header_id = xal.ae_header_id
     AND gck.code_combination_id=xal.code_combination_id
     and apha.accounting_event_id = xah.event_id 
	 --and apha.check_id = 10006--:p_check_id
	 
*************  Group 3          **************************

	select     
	API.INVOICE_ID,
	API.INVOICE_NUM,
	API.INVOICE_DATE,
	API.INVOICE_AMOUNT,
	API.AMOUNT_PAID,
    API.DOC_SEQUENCE_VALUE

	from  
	AP_INVOICES_ALL API where  API.INVOICE_ID='69073'
	
	
*****




select * from all_objects where object_name like '%BANK%' and object_type in ('TABLE','VIEW') ORDER BY object_name

select * from all_objects where object_name like '%CHECK%' and object_type in ('TABLE') ORDER BY object_name;
 
select * from AP_BANK_CHARGE_LINES WHERE bank_account_name='CD A/C No. 188.110.1172'
 
select * from CE_BANK_BRANCHES_V
select * from CE_CP_BANK_ACCOUNTS_V
 


select segment1=Flex_value from gl_code_combinations_kfv where code_combination_id

select flex_value_set_id from fnd_flex_value_sets where flex_value_set_name='XX Comp'
 
select description  from FND_FLEX_VALUES_VL where flex_value_set_id=1017056  and Flex_value





   
  
  select * from AP_BANK_BRANCHES
  
 select CBA.* ,CBAU.*,CBB.* FROM CE_BANK_ACCOUNTS CBA,CE_BANK_ACCT_USES_ALL CBAU, CE_BANK_BRANCHES_V CBB
 
 
 select * from AP_CHECKS_ALL where check_id=11002
 
 select *  FROM CE_BANK_ACCOUNTS;
 
 select * from HZ_ORGANIZATION_PROFILES order by PARTY_ID;
   

   select *  FROM CE_BANK_BRANCHES_V
 
 select * from  AP_INVOICES_ALL where Invoice_num='Test-103' ;
 select * from  AP_INVOICE_PAYMENTS_ALL where Invoice_ID='18007'

select * from ap_suppliers where vendor_id=1002

 

  
  
 
 BEGIN
MO_GLOBAL.SET_POLICY_CONTEXT('S',82);
END;

SELECT
  
     trx_number,DECODE(trx_number,'Receipt Write-off',rec_activity_name,trx_number) apply_to
    
 FROM
     ar_receivable_applications_V
 WHERE
     ( (         cash_receipt_id = 2000 ) )
     AND -1 =-1

	
-------------------------------------

select * from AP_CHECKS_ALL where check_number='500301';

select * from  AP_INVOICE_PAYMENTS_ALL where check_ID='11002';

select * from  AP_INVOICES_ALL where Invoice_ID='18007' ;

select * from iby_payment_methods_vl
where PAYMENT_METHOD_CODE='CHECK'




XXPJ_Payment_Number_VS



CE_BANK_ACC_NUM


bank_account_name "Account Name"(30), currency_code "Currency"(30)



----------------Group 1---------------------------	
	 
 select 
    ACA.ORG_ID,
	ORG.ORGANIZATION_NAME,
    ACA.CHECK_ID,  
    ACA.CHECK_NUMBER,  
    ACA.VENDOR_NAME,
    ACA.VENDOR_SITE_CODE,
    ACA.CURRENCY_CODE,
	ACA.PAYMENT_METHOD_CODE,
	ACA.VOID_DATE,
	ACA.DOC_SEQUENCE_VALUE,
	ACA.STATUS_LOOKUP_CODE,
	ap_checks_pkg.get_posting_status(ACA.check_id) posting_status,
	APIP.INVOICE_ID,
    APIP.ACCTS_PAY_CODE_COMBINATION_ID,    
    APIP.ACCOUNTING_DATE,	
    APIP.AMOUNT,
    APIP.BANK_ACCOUNT_NUM,
    CBA.BANK_ACCOUNT_NAME ,
    CBB.BANK_NAME,
    CBB.BANK_BRANCH_NAME  
 from
    AP_CHECKS_ALL ACA, 
	ORG_ORGANIZATION_DEFINITIONS ORG,
    AP_INVOICE_PAYMENTS_ALL APIP,
    CE_BANK_ACCOUNTS CBA,
    CE_BANK_BRANCHES_V CBB 
    where 1=1
	and ACA.DOC_SEQUENCE_VALUE=nvl(:P_PAYMENT_VOUCHER_NUMBER ,ACA.DOC_SEQUENCE_VALUE)  --500301
	and ACA.CHECK_NUMBER=nvl(:P_PAYMENT_NUMBER ,ACA.CHECK_NUMBER)  --500301
	and  ACA.ORG_ID=nvl(:P_ORG ,ACA.ORG_ID)
	and  ACA.VENDOR_NAME=nvl(:P_SUPPLIER ,ACA.VENDOR_NAME)
	and ACA.ORG_ID=ORG.ORGANIZATION_ID
    and   ACA.CHECK_ID=APIP.CHECK_ID
    and  CBA.BANK_ACCOUNT_NAME=ACA.BANK_ACCOUNT_NAME
    and  CBA.BANK_ID=CBB.BANK_PARTY_ID
    and  CBA.BANK_BRANCH_ID=CBB.BRANCH_PARTY_ID
 
 

----------------Group 2---------------------------	
	    
   
select fnd_flex_ext.get_segs('SQLGL', 'GL#', gl.chart_of_accounts_id, l.code_combination_id) ACCOUNT ,
xla_oa_functions_pkg.get_ccid_description (gl.chart_of_accounts_id, l.code_combination_id) account_description_2,
xxpj_get_cc_desc (l.code_combination_id) account_description ,
l.CODE_COMBINATION_ID,
l.DESCRIPTION ,
l.ACCOUNTING_DATE,
l.ENTERED_DR,
l.ENTERED_DR,
l.ENTERED_CR,
l.ACCOUNTED_DR,
l.ACCOUNTED_CR,
l.CURRENCY_CODE
 FROM xla_ae_headers h ,xla_ae_lines l,xla_gl_ledgers_v gl
 where gl.ledger_id = h.ledger_id and
h.ae_header_id = l.ae_header_id
and l.CODE_COMBINATION_ID=4086




-- select * from gl_import_references;
-- select * from xla_transaction_entities
-- select * from  gl_je_lines
-- select * from xla_gl_ledgers_v

SELECT  
distinct   
xte.SOURCE_ID_INT_1,
fnd_flex_ext.get_segs('SQLGL', 'GL#', gl.chart_of_accounts_id, xal.code_combination_id) ACCOUNT ,
xla_oa_functions_pkg.get_ccid_description (gl.chart_of_accounts_id, xal.code_combination_id) account_description ,
xal.DESCRIPTION ,
xal.ACCOUNTING_DATE,
xal.ENTERED_DR,
xal.ENTERED_CR,
xal.ACCOUNTED_DR,
xal.ACCOUNTED_CR,
xal.CURRENCY_CODE

    FROM 
        
         xla.xla_transaction_entities xte,
         xla_ae_headers xah,
         xla_ae_lines xal,
         gl_import_references gir,
         gl_ledgers gl
   WHERE 
      xte.entity_id = xah.entity_id
     AND xah.ae_header_id = xal.ae_header_id
     AND xal.gl_sl_link_id = gir.gl_sl_link_id
     AND xal.gl_sl_link_table = gir.gl_sl_link_table   
    -- AND aipa.invoice_id = '28011'  
     AND xte.SOURCE_ID_INT_1 ='16005'
     --Invoice Num
--GROUP BY aia.invoice_num, aia.invoice_amount



-- select * from gl_import_references;
--select * from xla_transaction_entities
-- select * from  gl_je_lines
--select * from xla_gl_ledgers_v

SELECT  
distinct   
fnd_flex_ext.get_segs('SQLGL', 'GL#', gl.chart_of_accounts_id, xal.code_combination_id) ACCOUNT ,
xla_oa_functions_pkg.get_ccid_description (gl.chart_of_accounts_id, xal.code_combination_id) account_description ,
xal.DESCRIPTION ,
xal.ACCOUNTING_DATE,
xal.ENTERED_DR,
xal.ENTERED_CR,
xal.ACCOUNTED_DR,
xal.ACCOUNTED_CR,
xal.CURRENCY_CODE,
aca.check_id,
NVL ("SOURCE_ID_INT_1", (-99))
    FROM 
         ap_checks_all aca,
         xla.xla_transaction_entities xte,
         xla_ae_headers xah,
         xla_ae_lines xal,
         gl_import_references gir,
         gl_ledgers gl
   WHERE aca.check_id = NVL ("SOURCE_ID_INT_1", (-99))
     AND xte.entity_code = 'AP_PAYMENTS'
     AND xte.application_id = 200
     AND xte.entity_id = xah.entity_id
     AND xah.ae_header_id = xal.ae_header_id
     AND xal.gl_sl_link_id = gir.gl_sl_link_id
     AND xal.gl_sl_link_table = gir.gl_sl_link_table   
    -- AND aipa.invoice_id = '28011'  
     AND aca.check_id ='16004'
     --Invoice Num
--GROUP BY aia.invoice_num, aia.invoice_amount



SELECT  distinct xal.*
    FROM ap_invoices_all aia,
         ap_invoice_payments_all aipa,
         ap_checks_all aca,
         xla.xla_transaction_entities xte,
         xla_ae_headers xah,
         xla_ae_lines xal,
         gl.gl_import_references gir,
         gl_je_lines gjl,
         gl_je_headers gjh
   WHERE 1 = 1
     AND aia.invoice_id = aipa.invoice_id
     AND aipa.check_id = aca.check_id
     AND aca.check_id = NVL ("SOURCE_ID_INT_1", (-99))
     AND xte.entity_code = 'AP_PAYMENTS'
     AND xte.application_id = 200
     AND xte.entity_id = xah.entity_id
     AND xah.ae_header_id = xal.ae_header_id
     AND xal.gl_sl_link_id = gir.gl_sl_link_id
     AND xal.gl_sl_link_table = gir.gl_sl_link_table
     AND gir.je_header_id = gjl.je_header_id
     AND gir.je_line_num = gjl.je_line_num
     AND gjl.je_header_id = gjh.je_header_id
     AND aia.invoice_num = 'Test-99'  --Invoice Num
--GROUP BY aia.invoice_num, aia.invoice_amount




----------------Group 3---------------------------	
	 
 
	select     
	API.INVOICE_ID,
	API.INVOICE_NUM,
	API.INVOICE_DATE,
	API.INVOICE_AMOUNT,
	API.AMOUNT_PAID,
    ACA.DOC_SEQUENCE_VALUE,

	from  
	AP_INVOICES_ALL API
   
   
   
   
   
   SELECT
     ac.rowid                            row_id,
     ac.address_line1                    address_line1,
     ac.address_line2                    address_line2,
     ac.address_line3                    address_line3,
     ac.address_line4                    address_line4,
     nvl(ac.address_style,'DEFAULT') address_style,
     ac.amount                           amount,
     ac.amount                           control_amount,
     ac.attribute1                       attribute1,
     ac.attribute10                      attribute10,
     ac.attribute11                      attribute11,
     ac.attribute12                      attribute12,
     ac.attribute13                      attribute13,
     ac.attribute14                      attribute14,
     ac.attribute15                      attribute15,
     ac.attribute2                       attribute2,
     ac.attribute3                       attribute3,
     ac.attribute4                       attribute4,
     ac.attribute5                       attribute5,
     ac.attribute6                       attribute6,
     ac.attribute7                       attribute7,
     ac.attribute8                       attribute8,
     ac.attribute9                       attribute9,
     ac.attribute_category               attribute_category,
     cba.bank_account_id                 bank_account_id,
     ac.bank_account_name                bank_account_name,
     ac.bank_account_num                 bank_account_num,
     ac.bank_account_type                bank_account_type,
     ac.bank_num                         bank_num,
     ac.base_amount                      base_amount,
     ac.checkrun_id                      checkrun_id,
     ac.checkrun_name                    checkrun_name,
     ac.check_date                       check_date,
     ac.check_id                         check_id,
     ac.check_number                     check_number,
     pd.payment_document_id,
     ac.check_voucher_num                check_voucher_num,
     ac.city                             city,
     ac.cleared_amount                   cleared_amount,
     ac.cleared_base_amount              cleared_base_amount,
     ac.cleared_date                     cleared_date,
     ac.cleared_exchange_date            cleared_exchange_date,
     ac.cleared_exchange_rate            cleared_exchange_rate,
     ac.cleared_exchange_rate_type       cleared_exchange_rate_type,
     ac.country                          country,
     ac.county                           county,
     ac.created_by                       created_by,
     ac.creation_date                    creation_date,
     ac.currency_code                    currency_code,
     ac.doc_category_code                doc_category_code,
     ac.doc_sequence_id                  doc_sequence_id,
     ac.doc_sequence_value               doc_sequence_value,
     ac.exchange_date                    exchange_date,
     ac.exchange_rate                    exchange_rate,
     ac.exchange_rate_type               exchange_rate_type,
     ac.future_pay_due_date              future_pay_due_date,
     ac.last_updated_by                  last_updated_by,
     ac.last_update_date                 last_update_date,
     ac.last_update_login                last_update_login,
     ac.org_id                           org_id,
     ac.payment_method_code,
     ac.payment_type_flag                payment_type_flag,
     ac.province                         province,
     ac.reconciliation_batch_id          reconciliation_batch_id,
     ac.released_date                    released_date,
     ac.released_by                      released_by,
     ac.state                            state,
     ac.status_lookup_code               status_lookup_code,
     ac.stopped_date                     stopped_date,
     ac.stopped_by                       stopped_by,
     ac.treasury_pay_date                treasury_pay_date,
     ac.treasury_pay_number              treasury_pay_number,
     ac.vendor_id                        vendor_id,
     ac.vendor_name                      vendor_name /* Bug 15966842 */,
     DECODE(asup.vendor_type_lookup_code,'EMPLOYEE',nvl( (
         SELECT
             nvl(alc.displayed_field,ac.vendor_site_code)
         FROM
             ap_lookup_codes alc
         WHERE
             alc.lookup_type(+) = 'VENDOR_SITE_CODE'
             AND alc.lookup_code(+) = ac.vendor_site_code
     ),ac.vendor_site_code),ac.vendor_site_code) vendor_site_code,
     ac.vendor_site_id                   vendor_site_id,
     ac.void_date                        void_date,
     ac.withholding_status_lookup_code   withholding_status_lookup_code,
     ac.zip                              zip,
     ac.address_line1
     || DECODE(ac.address_line1,NULL,'',fnd_global.local_chr(10) )
     || ac.address_line2
     || DECODE(ac.address_line2,NULL,'',fnd_global.local_chr(10) )
     || ac.address_line3
     || DECODE(ac.address_line3,NULL,'',fnd_global.local_chr(10) )
     || ac.city
     || ', '
     || ac.state
     || ' '
     || ac.zip
     || DECODE(ac.city,NULL,DECODE(ac.state,NULL,DECODE(ac.zip,NULL,'',fnd_global.local_chr(10) ),fnd_global.local_chr(10) ),fnd_global
     .local_chr(10) )
     || ac.country address,
     cbb.bank_name                       bank_name /*, CBA.BANK_ACCOUNT_NAME CURRENT_BANK_ACCOUNT_NAME*/,
     DECODE(paycard_reference_id,NULL,cba.bank_account_name,ac.bank_account_name) current_bank_account_name,
     cba.currency_code                   bank_currency_code,
     aspa.set_of_books_id                set_of_books_id,
     pd.payment_document_name,
     alc1.displayed_field                payment_type,
     iby1.payment_method_name            payment_method,
     alc3.displayed_field                check_status,
     stopped_date                        stop_date,
     fds.name                            doc_sequence_name,
     fdsc.name                           doc_category_name,
     ft.territory_short_name             territory_short_name,
     gdct.user_conversion_type           user_rate_type,
     nvl(asup.vendor_name,DECODE(ac.party_id,'','********************************************************************************'
    ,hzp.party_name) ) current_vendor_name,
     DECODE(ac.vendor_id,'',DECODE(ac.party_id,'','******************************',NULL),asup.segment1) vendor_number,
     DECODE(ac.vendor_id,'',DECODE(ac.party_id,'','******************************',NULL),asup.num_1099) num_1099 /* Bug 15966842 */,
     DECODE(ac.vendor_site_id,'',DECODE(ac.party_id,'','**************',NULL),DECODE(sign(ac.vendor_site_id),-1,NULL,DECODE(asup.
     vendor_type_lookup_code,'EMPLOYEE',nvl( (
         SELECT
             nvl(alc.displayed_field,pvs.vendor_site_code)
         FROM
             ap_lookup_codes alc
         WHERE
             alc.lookup_type(+) = 'VENDOR_SITE_CODE'
             AND alc.lookup_code(+) = pvs.vendor_site_code
     ),pvs.vendor_site_code),pvs.vendor_site_code) ) ) current_vendor_site_code,
     DECODE(sign(ac.vendor_site_id),-1,NULL,hzl.address1
                                                 || ' '
                                                 || hzl.address2
                                                 || ' '
                                                 || hzl.city
                                                 || ' '
                                                 || hzl.state
                                                 || ' '
                                                 || hzl.postal_code) trading_partner_address,
     csh.statement_number                statement_number,
     cslines.line_number                 statement_line_number,
     ap_auto_payment_pkg.selection_criteria_exists(ac.check_id) selection_criteria_flag,
     ap_invoice_payments_pkg.get_max_gl_date(ac.check_id) max_payment_gl_date,
     ac.positive_pay_status_code,
     ac.transfer_priority,
     ac.external_bank_account_id,
     ac.global_attribute_category        global_attribute_category,
     ac.global_attribute1                global_attribute1,
     ac.global_attribute2                global_attribute2,
     ac.global_attribute3                global_attribute3,
     ac.global_attribute4                global_attribute4,
     ac.global_attribute5                global_attribute5,
     ac.global_attribute6                global_attribute6,
     ac.global_attribute7                global_attribute7,
     ac.global_attribute8                global_attribute8,
     ac.global_attribute9                global_attribute9,
     ac.global_attribute10               global_attribute10,
     ac.global_attribute11               global_attribute11,
     ac.global_attribute12               global_attribute12,
     ac.global_attribute13               global_attribute13,
     ac.global_attribute14               global_attribute14,
     ac.global_attribute15               global_attribute15,
     ac.global_attribute16               global_attribute16,
     ac.global_attribute17               global_attribute17,
     ac.global_attribute18               global_attribute18,
     ac.global_attribute19               global_attribute19,
     ac.global_attribute20               global_attribute20,
     ac.stamp_duty_amt,
     ac.stamp_duty_base_amt,
     ac.maturity_exchange_date,
     ac.maturity_exchange_rate_type,
     ac.maturity_exchange_rate,
     gdct1.user_conversion_type          maturity_user_rate_type,
     ac.description,
     ac.anticipated_value_date,
     ac.actual_value_date,
     ap_checks_pkg.get_posting_status(ac.check_id),
     iby3.meaning                        AS bank_charge_bearer_dsp,
     iby5.meaning                        AS settlement_priority_dsp,
     ac.bank_charge_bearer,
     ac.settlement_priority,
     ac.party_id,
     ac.party_site_id,
     iby2.payment_profile_id,
     iby2.payment_profile_name,
     iby2.processing_type,
     ac.payment_id,
     ac.legal_entity_id,
     ac.void_check_id,
     ac.void_check_number,
     ac.ce_bank_acct_use_id /* Bug 7535348*/,
     ac.remit_to_supplier_name           remit_to_supplier_name,
     ac.remit_to_supplier_id             remit_to_supplier_id,
     ac.remit_to_supplier_site           remit_to_supplier_site,
     ac.remit_to_supplier_site_id        remit_to_supplier_site_id,
     pv1.segment1                        remit_to_supplier_number,
     DECODE(sign(ac.remit_to_supplier_site_id),-1,NULL,hzl1.address1
                                                            || ' '
                                                            || hzl1.address2
                                                            || ' '
                                                            || hzl1.city
                                                            || ' '
                                                            || hzl1.state
                                                            || ' '
                                                            || hzl1.postal_code) remit_to_supplier_address,
     ac.relationship_id                  relationship_id /* Bug 7535348*/,
     DECODE(ac.remit_to_supplier_id,'',DECODE(pv1.party_id,'','*******',NULL),pv1.num_1099) remit_num_1099,
     DECODE(pv1.party_id,'','************************',hzp1.party_name) current_remit_to_supplier_name,
     DECODE(ac.remit_to_supplier_site_id,'',DECODE(pv1.party_id,'','******',NULL),DECODE(sign(ac.remit_to_supplier_site_id),-1,NULL
    ,pvs1.vendor_site_code) ) current_remit_vendor_site_code,
     ac.acknowledged_flag                acknowledged_flag /* Added for NOEX */,
     ac.paycard_authorization_number,
     ac.paycard_reference_id
 FROM
     ce_bank_accounts cba,
     ce_bank_acct_uses_all cbau,
     ce_bank_branches_v cbb,
     ap_system_parameters_all aspa,
     ce_payment_documents pd,
     ap_lookup_codes alc1,
     iby_payment_methods_vl iby1,
     iby_payment_profiles iby2,
     fnd_lookups iby3,
     fnd_lookups iby5,
     ap_lookup_codes alc3,
     fnd_document_sequences fds,
     fnd_doc_sequence_categories fdsc,
     fnd_territories_vl ft,
     gl_daily_conversion_types gdct,
     ap_suppliers asup,
     ap_supplier_sites_all pvs,
     ce_statement_reconcils_all csra,
     ce_statement_headers csh,
     ce_statement_lines cslines,
     ap_checks ac,
     gl_daily_conversion_types gdct1,
     hz_parties hzp,
     hz_party_sites hps,
     hz_locations hzl /* Bug 7535348*/,
     ap_suppliers pv1,
     ap_supplier_sites_all pvs1,
     hz_party_sites hps1,
     hz_locations hzl1, /* Bug 7535348*/
     hz_parties hzp1
 WHERE
     ac.ce_bank_acct_use_id = cbau.bank_acct_use_id (+)
     AND cbau.bank_account_id = cba.bank_account_id (+)
     AND cbau.org_id = aspa.org_id (+)
     AND ac.maturity_exchange_rate_type = gdct1.conversion_type (+)
     AND cbb.branch_party_id (+) = cba.bank_branch_id
     AND ac.payment_document_id = pd.payment_document_id (+)
     AND alc1.lookup_type = 'PAYMENT TYPE'
     AND alc1.lookup_code = ac.payment_type_flag
     AND iby1.payment_method_code (+) = ac.payment_method_code
     AND iby2.payment_profile_id (+) = ac.payment_profile_id
     AND alc3.lookup_type (+) = 'CHECK STATE'
     AND alc3.lookup_code (+) = ac.status_lookup_code
     AND ac.bank_charge_bearer = iby3.lookup_code (+)
     AND iby3.lookup_type (+) = 'IBY_BANK_CHARGE_BEARER'
     AND ac.settlement_priority = iby5.lookup_code (+)
     AND iby5.lookup_type (+) = 'IBY_SETTLEMENT_PRIORITY'
     AND ac.doc_sequence_id = fds.doc_sequence_id (+)
     AND fdsc.application_id (+) = 200
     AND ac.doc_category_code = fdsc.code (+)
     AND ac.country = ft.territory_code (+)
     AND ac.exchange_rate_type = gdct.conversion_type (+)
     AND ac.vendor_id = asup.vendor_id (+)
     AND ac.party_id = hzp.party_id (+)
     AND ac.vendor_site_id = pvs.vendor_site_id (+)
     AND ac.party_site_id = hps.party_site_id (+)
     AND hps.location_id = hzl.location_id (+)
     AND csra.reference_type (+) = 'PAYMENT'
     AND csra.reference_id (+) = ac.check_id
     AND csra.current_record_flag (+) = 'Y'
     AND csra.statement_line_id = cslines.statement_line_id (+)
     AND cslines.statement_header_id = csh.statement_header_id (+)
     AND csra.status_flag (+) = 'M' /* Bug 7535348*/
     AND ac.remit_to_supplier_id = pv1.vendor_id (+)
     AND ac.remit_to_supplier_site_id = pvs1.vendor_site_id (+)
     AND pvs1.party_site_id = hps1.party_site_id (+)
     AND hps1.location_id = hzl1.location_id (+) /* Bug 7535348*/
     AND pv1.party_id = hzp1.party_id (+)
	 
	 
   
   
   
   SELECT * FROM
(SELECT /*+ OPTIMIZER_FEATURES_ENABLE('9.2.0') opt_param('hash_join_enabled','false') */ l.code_combination_id ,
fnd_flex_ext.get_segs('SQLGL', 'GL#', gl.chart_of_accounts_id, l.code_combination_id) ACCOUNT ,
xla_oa_functions_pkg.get_ccid_description (gl.chart_of_accounts_id, l.code_combination_id) account_description ,
l.accounting_class_code ,nvl(lk7.meaning, l.accounting_class_code) accounting_class ,null completion_acct_seq_name ,
h.completion_acct_seq_value ,h.completion_acct_seq_version_id completion_acct_seq_ver_id ,
null completion_acct_seq_ver_name ,h.balance_type_code ,null balance_type ,
h.budget_version_id ,bud.budget_name ,h.completed_date ,l.accounted_dr ,l.accounted_cr ,l.created_by ,
null created_by_user ,l.creation_date ,l.currency_code ,l.description line_description ,h.doc_sequence_id ,
null doc_sequence_name ,h.doc_sequence_value ,l.encumbrance_type_id ,null encumbrance_type ,l.entered_dr ,
l.entered_cr ,et.event_class_code ,ec.name event_class ,ue.user_name event_created_by_user ,
e.creation_date event_creation_date ,e.event_date ,et.name event_type ,e.event_number ,l.currency_conversion_date ,
l.currency_conversion_rate ,l.currency_conversion_type ,null user_conversion_type ,
decode(gl.enable_budgetary_control_flag, 'N', null, lk5.meaning) funds_status ,
nvl(h.FUNDS_STATUS_CODE, decode(gl.enable_budgetary_control_flag, 'REQUIRED', null)) 
FUNDS_STATUS_CODE ,h.accounting_date ,l.gl_sl_link_id ,l.gl_sl_link_table ,h.period_name ,
h.description header_description ,h.je_category_name ,null user_je_cat_name ,h.ae_header_id ,null journal_entry_name ,gl.currency_code ledger_currency ,h.ledger_id ,
gl.name ledger_name ,te.legal_entity_id ,le.name legal_entity_name ,le.legal_entity_identifier legal_entity_taxpayer_id ,
l.ae_line_num ,h.product_rule_type_code ,null prod_rule_type_dsp ,h.product_rule_code ,null prod_rule_name ,
h.product_rule_version prod_rule_version ,l.jgzz_recon_ref ,h.reference_date ,null close_acct_seq_name ,
h.close_acct_seq_value ,h.close_acct_seq_version_id close_acct_seq_ver_id ,null close_acct_seq_ver_name ,
l.statistical_amount ,h.event_type_code ,h.accounting_entry_status_code ,null ae_status ,h.accounting_entry_type_code ,
null ae_type ,decode(l.party_type_code,'C',l.party_id) CUSTOMER_ID ,null CUSTOMER_NAME ,null CUSTOMER_NUMBER ,null CUSTOMER_TAXPAYER_ID ,decode(l.party_type_code,'C',l.party_site_id) CUSTOMER_SITE_ID ,
null CUSTOMER_SITE_NAME ,l.party_type_code ,null PARTY_TYPE_DSP ,h.gl_transfer_date ,h.gl_transfer_status_code ,
null GL_TRANSFER_STATUS ,l.ussgl_transaction_code ,e.created_by event_created_by ,te.transaction_number ,
et.entity_code ,null batch_name ,h.application_id ,app.application_name ,te.source_id_int_1 ,te.source_id_int_2 ,
te.source_id_int_3 ,te.source_id_int_4 ,te.source_id_char_1 ,te.source_id_char_2 ,te.source_id_char_3 ,
te.source_id_char_4 ,h.event_id ,te.security_id_int_1 ,te.security_id_int_2 ,te.security_id_int_3 ,
te.security_id_char_1 ,te.security_id_char_2 ,te.security_id_char_3 ,te.valuation_method ,null SUPPLIER_NAME ,
null SUPPLIER_NUMBER ,null SUPPLIER_TAXPAYER_ID ,null SUPPLIER_SITE_NAME ,decode(l.party_type_code,'S',l.party_id) SUPPLIER_ID ,decode(l.party_type_code,'S',l.party_site_id) SUPPLIER_SITE_ID ,'N' populate_hdr_flag ,'N' populate_line_flag ,'N' populate_gl_flag ,'N' populate_seq_flag ,'N' populate_supp_flag ,'N' populate_cust_flag ,null balancing_seg ,null management_seg ,null cost_center_seg ,null natural_acct_seg ,h.parent_ae_header_id ,h.parent_ae_line_num ,te.ledger_id trx_ledger_id ,l.displayed_line_number ,null SR1 ,null SR2 ,null SR3 ,null SR4 ,null SR5 ,null SR6 ,null SR7 ,null SR8 ,null SR9 ,null SR10 ,null SR11 ,null SR12 ,null SR13 ,null SR14 ,null SR15 ,null SR16 ,null SR17 ,null SR18 ,null SR19 ,null SR20 ,null SR21 ,null SR22 ,null SR23 ,null SR24 ,null SR25 ,null SR26 ,null SR27 ,null SR28 ,null SR29 ,null SR30 ,null SR31 ,null SR32 ,null SR33 ,null SR34 ,null SR35 ,null SR36 ,null SR37 ,null SR38 ,null SR39 ,null SR40 ,null SR41 ,null SR42 ,null SR43 ,null SR44 ,null SR45 ,null SR46 ,null SR47 ,null SR48 ,null SR49 ,null SR50 ,null SR401 ,null SR402 ,null SR403 ,null SR404 ,null SR405 ,null SR406 ,null SR407 ,null SR408 ,null SR409 ,null SR410 ,null SR601 ,null SR602 ,null SR603 ,null SR604 ,null SR605 ,null SR606 ,null SR607 ,null SR608 ,null SR609 ,null SR610 ,null SR611 ,null SR612 ,null SR613 ,null SR614 ,null SR615 ,null SR616 ,null SR617 ,null SR618 ,null SR619 ,null SR620 ,null SR621 ,null SR622 ,null SR623 ,null SR624 ,null SR625 ,null SR626 ,null SR627 ,null SR628 ,null SR629 ,null SR630 ,null SR631 ,null SR632 ,null SR633 ,null SR634 ,null SR635 ,null SR636 ,null SR637 ,null SR638 ,null SR639 ,null SR640 ,h.upg_batch_id 

FROM xla_ae_headers h ,xla_ae_lines l ,xla_events e ,xla_transaction_entities te ,xla_gl_ledgers_v gl ,gl_budget_versions bud ,xle_entity_profiles le ,fnd_user ue ,fnd_application_vl app ,xla_event_types_tl et ,xla_event_classes_tl ec ,xla_lookups lk5 ,xla_lookups lk7 

where gl.ledger_id = h.ledger_id and bud.budget_version_id(+) = h.budget_version_id and le.legal_entity_id(+) = te.legal_entity_id and ue.user_id (+) = e.created_by and ec.application_id = et.application_id and ec.entity_code = et.entity_code and
ec.event_class_code = et.event_class_code and ec.language = USERENV('LANG') and et.application_id = h.application_id 
and et.entity_code = te.entity_code and e.entity_id=te.entity_id and e.application_id=te.application_id and 
e.application_id=et.application_id and e.event_type_code=et.event_type_code and et.event_type_code = h.event_type_code 
and et.language = USERENV('LANG') and app.application_id = h.application_id and et.application_id = te.application_id 
and te.application_id = h.application_id and te.entity_id = h.entity_id and e.event_id = h.event_id and e.application_id = h.application_id and h.ae_header_id = l.ae_header_id and h.application_id = l.application_id and lk5.lookup_code = nvl(h.funds_status_code, 'REQUIRED') and lk5.lookup_type = 'XLA_FUNDS_STATUS' and lk7.lookup_code(+) = l.accounting_class_code and lk7.lookup_type(+) = 'XLA_ACCOUNTING_CLASS' and (nvl(nvl(accounted_cr,accounted_dr),0) <> 0 or FND_PROFILE.value('XLA_SHOW_ZERO_AMT_JRNL')='Y')) QRSLT ORDER BY ACCOUNT desc

 





