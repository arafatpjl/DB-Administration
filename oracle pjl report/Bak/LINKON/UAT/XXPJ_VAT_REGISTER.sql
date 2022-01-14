
***********************   VAT   ****************************

SELECT
        invoice_details.DataSource,
        invoice_details.ORG_ID,
        invoice_details.SUPPLIER_NAME,
        invoice_details.VATpayerID ,
        invoice_details.address_line1,
        invoice_details.phone	,
        invoice_details.SERVICECODE, 
        invoice_details.EXPENSEHEAD,
        invoice_details.BILLNO,
        invoice_details.BILLDATE,   
        invoice_details.BillAmountExVAT,
        invoice_details.Discount,
        SUM(invoice_details.BillAmountExVAT) OVER (PARTITION BY invoice_details.SUPPLIER_NAME,invoice_details.SERVICECODE ORDER BY invoice_details.SUPPLIER_NAME,invoice_details.SERVICECODE,invoice_details.BILLDATE,invoice_details.BILLNO) InvoiceAmountCumuSum,
        invoice_details.VAT_RATE,
        Round(SUM(invoice_details.BillAmountExVAT) OVER (PARTITION BY invoice_details.SUPPLIER_NAME,invoice_details.SERVICECODE ORDER BY invoice_details.SUPPLIER_NAME,invoice_details.SERVICECODE,invoice_details.BILLDATE,invoice_details.BILLNO)*(invoice_details.VAT_RATE/100),0) as TotalVAT,
        invoice_details.VAT_PAYABLE VAT_Invoice_De ,        
        SUM( invoice_details.VAT_PAYABLE) OVER (PARTITION BY invoice_details.SUPPLIER_NAME,invoice_details.SERVICECODE ORDER BY invoice_details.SUPPLIER_NAME,invoice_details.SERVICECODE,invoice_details.BILLDATE,invoice_details.BILLNO) VATAmountCumuSum,
        invoice_details.VAT_CHALLANNO, 
        invoice_details.VAT_CHALLANDATE,
        invoice_details.VAT_DEPOSTIEDTHROUGH
        
 FROM
     (   SELECT       'History' DataSource
                , ORG_ID
                ,SUPPLIER_NAME     
                ,'' VATpayerID
                ,'' address_line1
                ,'' phone	
                ,BILLNO
                ,BILLDATE              
                ,EXPENSEHEAD
                ,SERVICECODE 
                ,BillAmountExVAT
                ,Discount
                ,VAT_RATE                
                ,VAT_PAYABLE
                ,VAT_CHALLANNO
                ,VAT_CHALLANDATE
                ,VAT_DEPOSTIEDTHROUGH
            
         FROM
               xxpj_TDS_VDS_RegisterHistory     
                 where  ORG_ID=nvl(:P_ORG ,ORG_ID)
               union all 
SELECT
            'System' DataSource
           , invoice_details.ORG_ID     
            ,invoice_details.vendor_name
             ,invoice_details.VATpayerID 
             ,invoice_details.address_line1
             ,invoice_details.phone	
            ,invoice_details.invoice_num
            ,invoice_details.invoice_date           
            ,invoice_details.Head_Expense           
            ,vat_invoice.Section
            ,invoice_details.invoice_amount
            ,vat_invoice.Discount
            ,vat_invoice.VAT_Rate
            ,vat_invoice.totalamount
            ,Challan_Details.Challan_No 
            ,Challan_Details.Challan_Date
            ,vat_invoice.VAT_DEPOSTIEDTHROUGH
        
 FROM
 
      (
        SELECT  
                aia.ORG_ID,
                aia.invoice_id,  
                aia.invoice_date,
                aia.invoice_num,
                aila.line_number,              
                aia.invoice_amount,
                aida.amount,             
                aia.vendor_id,          
                aps.vendor_name,               
                aps.TCA_SYNC_VAT_REG_NUM VATpayerID,
                apssa.vendor_site_id,
                apssa.vendor_site_code,
                apssa.address_line1,
                apssa.address_line2,
                apssa.city,
                apssa.state,
                apssa.zip,
                apssa.country,
                apssa.phone,			 
                apssa.customer_num  ,
                xxpj_get_segment_desc(  gckv.code_combination_id,'segment3') Head_Expense,
                gckv.segment3 NaturalAccount
            
         FROM
                ap_invoices_all aia,
                ap_invoice_lines_all aila,
                ap_invoice_distributions_all aida,
                gl_code_combinations_kfv gckv,             
                ap_suppliers aps,
                ap_supplier_sites_all apssa
         WHERE
             1 = 1             
             AND aia.invoice_id = aila.invoice_id
             AND aia.invoice_id = aida.invoice_id
             AND aila.line_number = aida.invoice_line_number
             AND aida.dist_code_combination_id = gckv.code_combination_id
             AND aida.LINE_TYPE_LOOKUP_CODE='ITEM'
             AND aila.LINE_TYPE_LOOKUP_CODE='ITEM'
             AND aila.amount>0
             AND aia.vendor_id = aps.vendor_id
             AND aps.vendor_id = apssa.vendor_id
             AND aia.vendor_site_id = apssa.vendor_site_id
            
     ) invoice_details,
     (            
      SELECT
            aia.invoice_num,
            aia.invoice_id,
            aila.DEFAULT_DIST_CCID,
              CASE aila.ATTRIBUTE12 WHEN 'YES' then 'Mushak-11'
             ELSE  'Others' END  VAT_DEPOSTIEDTHROUGH,
            TO_NUMBER ( aila.ATTRIBUTE13) Discount,
            TO_NUMBER ( aila.ATTRIBUTE14) VAT_Rate,
            aida.dist_code_combination_id,    
            trim(SUBSTR(xxpj_get_segment_desc( aida.dist_code_combination_id,'segment4'),14,INSTR(xxpj_get_segment_desc( aida.dist_code_combination_id,'segment4'),'-',1)-14)) Section,
            aila.attribute15   line_number,
            abs(SUM(aida.amount)) totalamount,
            xxpj_get_segment_desc( aida.dist_code_combination_id,'segment4')ExpenseHead 
 FROM
     ap_invoices_all aia,
     ap_invoice_lines_all aila,
     ap_invoice_distributions_all aida,
     gl_code_combinations_kfv gckv
 WHERE
     1 = 1
     AND aia.invoice_id = aila.invoice_id
     AND aia.invoice_id = aida.invoice_id
     AND aila.line_number = aida.invoice_line_number
     AND aida.dist_code_combination_id = gckv.code_combination_id
     AND (aila.amount < 0 or  aila.ATTRIBUTE12='YES')
     AND aila.attribute_category = 'Item Line Reference'
     AND gckv.segment3 = 325401
    --325301=TDS
    --325401=VDS
     
 GROUP BY
     aia.invoice_num,
     aia.invoice_id,
     aila.DEFAULT_DIST_CCID,
     aila.ATTRIBUTE12,
     aila.ATTRIBUTE13,
     aila.ATTRIBUTE14,
     aida.dist_code_combination_id,
     aila.attribute15
        
     
     ) vat_invoice,
     
     ( SELECT 
     aila.ATTRIBUTE4 invoice_num
     ,aila.DEFAULT_DIST_CCID
     ,aila.ATTRIBUTE6 Challan_No  
   -- , aila.ATTRIBUTE7 Challan_Date
     ,TO_DATE(aila.ATTRIBUTE7, 'YYYY/MM/DD HH24:MI:SS') Challan_Date
                  FROM ap_invoices_all aia,
                  ap_invoice_lines_all aila
                 WHERE     aia.invoice_id = aila.invoice_id
                 and aia.invoice_num like 'VDS%'
                -- and aila.ATTRIBUTE4='04-DEC-2018'
                 ) Challan_Details
     
 WHERE    1=1   
            AND invoice_details.invoice_id  = vat_invoice.invoice_id 
            AND invoice_details.line_number = vat_invoice.line_number
            
            AND vat_invoice.invoice_num = Challan_Details.invoice_num(+)
            AND vat_invoice.DEFAULT_DIST_CCID = Challan_Details.DEFAULT_DIST_CCID(+)
              
           -- AND invoice_details.invoice_num  IN ('04-DEC-2018')
            AND invoice_details.ORG_ID=nvl(:P_ORG ,invoice_details.ORG_ID)
            AND invoice_details.invoice_date BETWEEN nvl(:P_DateFrom ,invoice_details.invoice_date) AND nvl(:P_DateTo ,invoice_details.invoice_date)
            AND invoice_details.VENDOR_NAME=nvl(:P_SUPPLIER , invoice_details.VENDOR_NAME)
            
         --   order by  tds_invoice.Section,invoice_details.vendor_id,invoice_details.invoice_id,invoice_details.line_number
         ) invoice_details
         
         
        Order by   invoice_details.SUPPLIER_NAME,invoice_details.SERVICECODE,invoice_details.BILLDATE
		
		
		
		*******************************************
		
		
SELECT 
SUPPLIER_NAME
,SUM(DECODE(SECTION, 'S 003.10', amount, 0)) AS SeC_003
,SUM(DECODE(SECTION, 'S 007.00', amount, 0)) AS SeC_007
,SUM(DECODE(SECTION, 'S 008.10', amount, 0)) AS SeC_008
,SUM(DECODE(SECTION, 'S 032.00', amount, 0)) AS SeC_032
,SUM(DECODE(SECTION, 'S 034.00', amount, 0)) AS SeC_034
,SUM(DECODE(SECTION, 'S 040.00', amount, 0)) AS SeC_040
,SUM(DECODE(SECTION, 'S 045.00', amount, 0)) AS SeC_045
,SUM(DECODE(SECTION, 'S 048.00', amount, 0)) AS SeC_048
,SUM(DECODE(SECTION, 'S 074.00', amount, 0)) AS SeC_074
,SUM(DECODE(SECTION, 'S 099.00', amount, 0)) AS SeC_099
,SUM(DECODE(SECTION, 'S 099.10', amount, 0)) AS SeC_099_10

-- S 003.10	S 007.00	S 008.10	S 032.00	S 034.00	S 040.00	S 045.00	S 048.00	S 074.00	S 099.00	 S 099.10 

FROM
(
            SELECT  SUPPLIER_NAME              
                    ,VAT_PAYABLE amount                
                    ,SECTION 
                    FROM
                    xxpj_TDS_VDS_RegisterHistory     
                    where  ORG_ID=nvl(:P_ORG ,ORG_ID)
                    AND BILLDATE BETWEEN nvl(:P_DateFrom ,BILLDATE) AND nvl(:P_DateTo ,BILLDATE)
                    AND SUPPLIER_NAME=nvl(:P_SUPPLIER , SUPPLIER_NAME)
            
            union all
            
SELECT  
aps.vendor_name,
 aida.amount,
  CASE gckv.SEGMENT3 WHEN '325401' then
           trim(  SUBSTR(xxpj_get_segment_desc( aida.dist_code_combination_id,'segment4'),14,INSTR(xxpj_get_segment_desc( aida.dist_code_combination_id,'segment4'),'-',1)-14)) 
             ELSE 
             null
             END Section         
--             CASE gckv.SEGMENT3 WHEN '325401' then
--             SUBSTR(xxpj_get_segment_desc( aida.dist_code_combination_id,'segment4'),14,INSTR(xxpj_get_segment_desc( aida.dist_code_combination_id,'segment4'),'-',1)-14) 
--             ELSE 
--             null
--             END SeviceCode
--            
            
           FROM
             ap_invoices_all aia,
             ap_invoice_distributions_all aida,
             gl_code_combinations_kfv gckv,
             ap_suppliers aps,
             ap_supplier_sites_all apssa
         WHERE
             1 = 1
             AND aia.invoice_id = aida.invoice_id
             AND aida.dist_code_combination_id = gckv.code_combination_id
             AND gckv.SEGMENT3=325401
               --325301=TDS
             --325401=VDS
             AND aia.vendor_id = aps.vendor_id
             AND aps.vendor_id = apssa.vendor_id
             AND aia.vendor_site_id = apssa.vendor_site_id
             and  aia.ORG_ID=nvl(:P_ORG ,aia.ORG_ID)
             AND aia.invoice_date BETWEEN nvl(:P_DateFrom ,aia.invoice_date) AND nvl(:P_DateTo ,aia.invoice_date)
             AND  aps.VENDOR_NAME=nvl(:P_SUPPLIER , aps.VENDOR_NAME)
           
)
group by SUPPLIER_NAME
ORDER BY SUPPLIER_NAME;


*****************************************************************************

SELECT 
SUPPLIER_NAME
,SUM(DECODE(SECTION, '50', amount, 0)) AS Sec_50
,SUM(DECODE(SECTION, '52', amount, 0)) AS Sec_52
,SUM(DECODE(SECTION, '52A', amount, 0)) AS Sec_52A
,SUM(DECODE(SECTION, '52A(3)', amount, 0)) AS Sec_52A_3
,SUM(DECODE(SECTION, '52AA', amount, 0)) AS Sec_52AA
,SUM(DECODE(SECTION, '52K', amount, 0)) AS Sec_52K
,SUM(DECODE(SECTION, '53A', amount, 0)) AS Sec_53A
,SUM(DECODE(SECTION, '53BB', amount, 0)) AS Sec_53BB
,SUM(DECODE(SECTION, '53K', amount, 0)) AS Sec_53K
,SUM(DECODE(SECTION, '54', amount, 0)) AS Sec_54
,SUM(DECODE(SECTION, '56', amount, 0)) AS Sec_56
-- S 003.10	S 007.00	S 008.10	S 032.00	S 034.00	S 040.00	S 045.00	S 048.00	S 074.00	S 099.00	 S 099.10 

FROM
(
            SELECT  SUPPLIER_NAME              
                    ,TDSPAYABLE amount                
                    ,SECTION 
                    FROM
                    xxpj_TDS_VDS_RegisterHistory     
                    where  ORG_ID=nvl(:P_ORG ,ORG_ID)
                    AND BILLDATE BETWEEN nvl(:P_DateFrom ,BILLDATE) AND nvl(:P_DateTo ,BILLDATE)
                    AND SUPPLIER_NAME=nvl(:P_SUPPLIER , SUPPLIER_NAME)
            
            union all
            
SELECT  
aps.vendor_name,
 aida.amount,
  CASE gckv.SEGMENT3 WHEN '325301' then
           trim(  SUBSTR(xxpj_get_segment_desc( aida.dist_code_combination_id,'segment4'),9,INSTR(xxpj_get_segment_desc( aida.dist_code_combination_id,'segment4'),'-',1)-9)) 
             ELSE 
             null
             END Section         
--             CASE gckv.SEGMENT3 WHEN '325401' then
--             SUBSTR(xxpj_get_segment_desc( aida.dist_code_combination_id,'segment4'),14,INSTR(xxpj_get_segment_desc( aida.dist_code_combination_id,'segment4'),'-',1)-14) 
--             ELSE 
--             null
--             END SeviceCode
--            
            
           FROM
             ap_invoices_all aia,
             ap_invoice_distributions_all aida,
             gl_code_combinations_kfv gckv,
             ap_suppliers aps,
             ap_supplier_sites_all apssa
         WHERE
             1 = 1
             AND aia.invoice_id = aida.invoice_id
             AND aida.dist_code_combination_id = gckv.code_combination_id
             AND gckv.SEGMENT3=325301
               --325301=TDS
             --325401=VDS
             AND aia.vendor_id = aps.vendor_id
             AND aps.vendor_id = apssa.vendor_id
             AND aia.vendor_site_id = apssa.vendor_site_id
             and  aia.ORG_ID=nvl(:P_ORG ,aia.ORG_ID)
             AND aia.invoice_date BETWEEN nvl(:P_DateFrom ,aia.invoice_date) AND nvl(:P_DateTo ,aia.invoice_date)
             AND  aps.VENDOR_NAME=nvl(:P_SUPPLIER , aps.VENDOR_NAME)
           
)
group by SUPPLIER_NAME
ORDER BY SUPPLIER_NAME;
