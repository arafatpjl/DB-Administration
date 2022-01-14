SELECT AI.invoice_id,fnd_flex_ext.get_segs('SQLGL', 'GL#', xgl.chart_of_accounts_id, xal.code_combination_id) ACCOUNT ,
  xla_oa_functions_pkg.get_ccid_description(xgl.chart_of_accounts_id,xal.code_combination_id) account_description,
  xal.currency_code Transaction_Currency,
  xal.entered_dr ,
  xal.entered_cr ,
  xal.accounted_dr ,
  xal.accounted_cr,
  xal.currency_conversion_rate conversion_rate,
  xgl.currency_code Base_currency
FROM AP_INVOICES_ALL AI,
  XLA.xla_transaction_entities xte,
  XLA_AE_HEADERS xah,
  xla_ae_lines xal,
  xla_gl_ledgers_v xgl
WHERE AI.invoice_id   =xte.source_id_int_1
AND ai.invoice_num    =xte.transaction_number
AND xte.entity_id     =xah.entity_id
AND xah.ae_header_id  =xal.ae_header_id
AND ai.invoice_num    = 'test_adv_011018'
AND xgl.ledger_id                             = xah.ledger_id
AND (NVL(accounted_cr,0)                     <> 0
OR NVL(accounted_dr,0)                       <>0
OR FND_PROFILE.value('XLA_SHOW_ZERO_AMT_JRNL')='Y')