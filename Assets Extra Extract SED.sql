SELECT	A.ID,
		EC.ID 'CONTRACT_ID',
		ET.ID 'ENROLL_TRAN',
		EA.ID 'ASSET_ID',
		CAST(JSON_VALUE(A.Message, '$.gaInsObj.coverageEndDate') AS DATE) 'Cov_End',
		JSON_VALUE(A.Message, '$.gaInsObj.contractNumber') 'Contract_Num',
		JSON_VALUE(A.Message, '$.gaInsObj.customer.customerNumber') 'Customer_Num',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[0].assetNumber') 'Bike_Num',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[0].acquisitionYear') 'Year',
		UPPER(JSON_VALUE(A.Message, '$.gaInsObj.assets[0].manufacturer')) 'Manufacturer',
		UPPER(JSON_VALUE(A.Message, '$.gaInsObj.assets[0].model')) 'Model',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[0].assetSerialNumber') 'Serial',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[0].reportedValue') 'Value',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[0].funder.funderName') 'LP_Name',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[0].usage') 'Usage',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[0].accessories') 'Accessories',
		JSON_VALUE(A.Message, '$.returnResponse.Assets[0].ProgramDescriptionExternal') 'Coverage',
		JSON_VALUE(A.Message, '$.returnResponse.Assets[0].ProgramCode') 'Program Code'

FROM	SESENROLLMENTAPIPRODCOPY.DBO.SERVICEREQUEST A
INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTCONTRACT EC ON			(	EC.CONTRACTNUMBER = JSON_VALUE(A.Message, '$.gaInsObj.contractNumber'))
INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENT E ON					(	EC.ID = E.ENROLLMENTCONTRACTID)

INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTCOVERAGEPERIOD ECP ON	(	E.ID = ECP.ENROLLMENTID AND
																		ECP.COVERAGEENDDATE > GETDATE() AND
																		ECP.ID = (	SELECT MAX(ECP2.ID) 
																					FROM SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTCOVERAGEPERIOD ECP2 
																					WHERE ECP2.ENROLLMENTID = E.ID
																					AND ECP2.COVERAGEPERIOD = ECP.COVERAGEPERIOD))
INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTTRANS ET ON				(	ET.ENROLLMENTCOVERAGEPERIODID = ECP.ID AND
																		ET.TRANSACTIONTYPEID = '1' AND
																		ET.ID = (	SELECT MAX(ET2.ID) 
																					FROM SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTTRANS ET2 
																					WHERE ET2.ENROLLMENTCOVERAGEPERIODID = ECP.ID))

INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTASSETLIST EAL ON			(	ET.ID = EAL.ENROLLMENTTRANSID)
INNER JOIN  SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTASSET EA ON				(	EA.ENROLLMENTASSETLISTID = EAL.ID AND
																		EA.ASSETNUMBER = JSON_VALUE(A.Message, '$.gaInsObj.assets[0].assetNumber'))

WHERE	A.CLIENTID = '2975'
AND		A.[FUNCTION] IN ('Lease_EnrSubmitPostRuleGroup','Lease_EnrReSubmitPostRuleGroup','Lease_ChangePostRuleGroup')
AND		JSON_VALUE(A.Message, '$.gaEnrollmentId') IS NOT NULL
AND		A.ID = (SELECT MAX(B.ID) FROM SESENROLLMENTAPIPRODCOPY.DBO.SERVICEREQUEST B 
				WHERE JSON_VALUE(B.Message, '$.gaInsObj.referenceId') = JSON_VALUE(A.Message, '$.gaInsObj.referenceId')
				AND B.ID = A.ID
				AND B.[FUNCTION] <> 'IC_PostErrRuleGroup')

UNION

SELECT	A.ID,
		EC.ID 'CONTRACT_ID',
		ET.ID 'ENROLL_TRAN',
		EA.ID 'ASSET_ID',
		CAST(JSON_VALUE(A.Message, '$.gaInsObj.coverageEndDate') AS DATE) 'Cov_End',
		JSON_VALUE(A.Message, '$.gaInsObj.contractNumber') 'Contract_Num',
		JSON_VALUE(A.Message, '$.gaInsObj.customer.customerNumber') 'Customer_Num',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[1].assetNumber') 'Bike_Num',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[1].acquisitionYear') 'Year',
		UPPER(JSON_VALUE(A.Message, '$.gaInsObj.assets[1].manufacturer')) 'Manufacturer',
		UPPER(JSON_VALUE(A.Message, '$.gaInsObj.assets[1].model')) 'Model',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[1].assetSerialNumber') 'Serial',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[1].reportedValue') 'Value',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[1].funder.funderName') 'LP_Name',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[1].usage') 'Usage',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[1].accessories') 'Accessories',
		JSON_VALUE(A.Message, '$.returnResponse.Assets[1].ProgramDescriptionExternal') 'Coverage',
		JSON_VALUE(A.Message, '$.returnResponse.Assets[1].ProgramCode') 'Program Code'

FROM	SESENROLLMENTAPIPRODCOPY.DBO.SERVICEREQUEST A
INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTCONTRACT EC ON			(	EC.CONTRACTNUMBER = JSON_VALUE(A.Message, '$.gaInsObj.contractNumber'))
INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENT E ON					(	EC.ID = E.ENROLLMENTCONTRACTID)

INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTCOVERAGEPERIOD ECP ON	(	E.ID = ECP.ENROLLMENTID AND
																		ECP.COVERAGEENDDATE > GETDATE() AND
																		ECP.ID = (	SELECT MAX(ECP2.ID) 
																					FROM SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTCOVERAGEPERIOD ECP2 
																					WHERE ECP2.ENROLLMENTID = E.ID
																					AND ECP2.COVERAGEPERIOD = ECP.COVERAGEPERIOD))
INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTTRANS ET ON				(	ET.ENROLLMENTCOVERAGEPERIODID = ECP.ID AND
																		ET.TRANSACTIONTYPEID = '1' AND
																		ET.ID = (	SELECT MAX(ET2.ID) 
																					FROM SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTTRANS ET2 
																					WHERE ET2.ENROLLMENTCOVERAGEPERIODID = ECP.ID))

INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTASSETLIST EAL ON			(	ET.ID = EAL.ENROLLMENTTRANSID)
INNER JOIN  SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTASSET EA ON				(	EA.ENROLLMENTASSETLISTID = EAL.ID AND
																		EA.ASSETNUMBER = JSON_VALUE(A.Message, '$.gaInsObj.assets[1].assetNumber'))

WHERE	A.CLIENTID = '2975'
AND		A.[FUNCTION] IN ('Lease_EnrSubmitPostRuleGroup','Lease_EnrReSubmitPostRuleGroup','Lease_ChangePostRuleGroup')
AND		JSON_VALUE(A.Message, '$.gaEnrollmentId') IS NOT NULL
AND		A.ID = (SELECT MAX(B.ID) FROM SESENROLLMENTAPIPRODCOPY.DBO.SERVICEREQUEST B 
				WHERE JSON_VALUE(B.Message, '$.gaInsObj.referenceId') = JSON_VALUE(A.Message, '$.gaInsObj.referenceId')
				AND B.ID = A.ID
				AND B.[FUNCTION] <> 'IC_PostErrRuleGroup')

UNION

SELECT	A.ID,
		EC.ID 'CONTRACT_ID',
		ET.ID 'ENROLL_TRAN',
		EA.ID 'ASSET_ID',
		CAST(JSON_VALUE(A.Message, '$.gaInsObj.coverageEndDate') AS DATE) 'Cov_End',
		JSON_VALUE(A.Message, '$.gaInsObj.contractNumber') 'Contract_Num',
		JSON_VALUE(A.Message, '$.gaInsObj.customer.customerNumber') 'Customer_Num',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[2].assetNumber') 'Bike_Num',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[2].acquisitionYear') 'Year',
		UPPER(JSON_VALUE(A.Message, '$.gaInsObj.assets[2].manufacturer')) 'Manufacturer',
		UPPER(JSON_VALUE(A.Message, '$.gaInsObj.assets[2].model')) 'Model',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[2].assetSerialNumber') 'Serial',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[2].reportedValue') 'Value',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[2].funder.funderName') 'LP_Name',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[2].usage') 'Usage',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[2].accessories') 'Accessories',
		JSON_VALUE(A.Message, '$.returnResponse.Assets[2].ProgramDescriptionExternal') 'Coverage',
		JSON_VALUE(A.Message, '$.returnResponse.Assets[2].ProgramCode') 'Program Code'

FROM	SESENROLLMENTAPIPRODCOPY.DBO.SERVICEREQUEST A
INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTCONTRACT EC ON			(	EC.CONTRACTNUMBER = JSON_VALUE(A.Message, '$.gaInsObj.contractNumber'))
INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENT E ON					(	EC.ID = E.ENROLLMENTCONTRACTID)

INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTCOVERAGEPERIOD ECP ON	(	E.ID = ECP.ENROLLMENTID AND
																		ECP.COVERAGEENDDATE > GETDATE() AND
																		ECP.ID = (	SELECT MAX(ECP2.ID) 
																					FROM SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTCOVERAGEPERIOD ECP2 
																					WHERE ECP2.ENROLLMENTID = E.ID
																					AND ECP2.COVERAGEPERIOD = ECP.COVERAGEPERIOD))
INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTTRANS ET ON				(	ET.ENROLLMENTCOVERAGEPERIODID = ECP.ID AND
																		ET.TRANSACTIONTYPEID = '1' AND
																		ET.ID = (	SELECT MAX(ET2.ID) 
																					FROM SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTTRANS ET2 
																					WHERE ET2.ENROLLMENTCOVERAGEPERIODID = ECP.ID))

INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTASSETLIST EAL ON			(	ET.ID = EAL.ENROLLMENTTRANSID)
INNER JOIN  SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTASSET EA ON				(	EA.ENROLLMENTASSETLISTID = EAL.ID AND
																		EA.ASSETNUMBER = JSON_VALUE(A.Message, '$.gaInsObj.assets[2].assetNumber'))

WHERE	A.CLIENTID = '2975'
AND		A.[FUNCTION] IN ('Lease_EnrSubmitPostRuleGroup','Lease_EnrReSubmitPostRuleGroup','Lease_ChangePostRuleGroup')
AND		JSON_VALUE(A.Message, '$.gaEnrollmentId') IS NOT NULL
AND		A.ID = (SELECT MAX(B.ID) FROM SESENROLLMENTAPIPRODCOPY.DBO.SERVICEREQUEST B 
				WHERE JSON_VALUE(B.Message, '$.gaInsObj.referenceId') = JSON_VALUE(A.Message, '$.gaInsObj.referenceId')
				AND B.ID = A.ID
				AND B.[FUNCTION] <> 'IC_PostErrRuleGroup')

UNION

SELECT	A.ID,
		EC.ID 'CONTRACT_ID',
		ET.ID 'ENROLL_TRAN',
		EA.ID 'ASSET_ID',
		CAST(JSON_VALUE(A.Message, '$.gaInsObj.coverageEndDate') AS DATE) 'Cov_End',
		JSON_VALUE(A.Message, '$.gaInsObj.contractNumber') 'Contract_Num',
		JSON_VALUE(A.Message, '$.gaInsObj.customer.customerNumber') 'Customer_Num',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[3].assetNumber') 'Bike_Num',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[3].acquisitionYear') 'Year',
		UPPER(JSON_VALUE(A.Message, '$.gaInsObj.assets[3].manufacturer')) 'Manufacturer',
		UPPER(JSON_VALUE(A.Message, '$.gaInsObj.assets[3].model')) 'Model',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[3].assetSerialNumber') 'Serial',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[3].reportedValue') 'Value',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[3].funder.funderName') 'LP_Name',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[3].usage') 'Usage',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[3].accessories') 'Accessories',
		JSON_VALUE(A.Message, '$.returnResponse.Assets[3].ProgramDescriptionExternal') 'Coverage',
		JSON_VALUE(A.Message, '$.returnResponse.Assets[3].ProgramCode') 'Program Code'

FROM	SESENROLLMENTAPIPRODCOPY.DBO.SERVICEREQUEST A
INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTCONTRACT EC ON			(	EC.CONTRACTNUMBER = JSON_VALUE(A.Message, '$.gaInsObj.contractNumber'))
INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENT E ON					(	EC.ID = E.ENROLLMENTCONTRACTID)

INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTCOVERAGEPERIOD ECP ON	(	E.ID = ECP.ENROLLMENTID AND
																		ECP.COVERAGEENDDATE > GETDATE() AND
																		ECP.ID = (	SELECT MAX(ECP2.ID) 
																					FROM SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTCOVERAGEPERIOD ECP2 
																					WHERE ECP2.ENROLLMENTID = E.ID
																					AND ECP2.COVERAGEPERIOD = ECP.COVERAGEPERIOD))
INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTTRANS ET ON				(	ET.ENROLLMENTCOVERAGEPERIODID = ECP.ID AND
																		ET.TRANSACTIONTYPEID = '1' AND
																		ET.ID = (	SELECT MAX(ET2.ID) 
																					FROM SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTTRANS ET2 
																					WHERE ET2.ENROLLMENTCOVERAGEPERIODID = ECP.ID))

INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTASSETLIST EAL ON			(	ET.ID = EAL.ENROLLMENTTRANSID)
INNER JOIN  SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTASSET EA ON				(	EA.ENROLLMENTASSETLISTID = EAL.ID AND
																		EA.ASSETNUMBER = JSON_VALUE(A.Message, '$.gaInsObj.assets[3].assetNumber'))

WHERE	A.CLIENTID = '2975'
AND		A.[FUNCTION] IN ('Lease_EnrSubmitPostRuleGroup','Lease_EnrReSubmitPostRuleGroup','Lease_ChangePostRuleGroup')
AND		JSON_VALUE(A.Message, '$.gaEnrollmentId') IS NOT NULL
AND		A.ID = (SELECT MAX(B.ID) FROM SESENROLLMENTAPIPRODCOPY.DBO.SERVICEREQUEST B 
				WHERE JSON_VALUE(B.Message, '$.gaInsObj.referenceId') = JSON_VALUE(A.Message, '$.gaInsObj.referenceId')
				AND B.ID = A.ID
				AND B.[FUNCTION] <> 'IC_PostErrRuleGroup')

UNION

SELECT	A.ID,
		EC.ID 'CONTRACT_ID',
		ET.ID 'ENROLL_TRAN',
		EA.ID 'ASSET_ID',
		CAST(JSON_VALUE(A.Message, '$.gaInsObj.coverageEndDate') AS DATE) 'Cov_End',
		JSON_VALUE(A.Message, '$.gaInsObj.contractNumber') 'Contract_Num',
		JSON_VALUE(A.Message, '$.gaInsObj.customer.customerNumber') 'Customer_Num',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[4].assetNumber') 'Bike_Num',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[4].acquisitionYear') 'Year',
		UPPER(JSON_VALUE(A.Message, '$.gaInsObj.assets[4].manufacturer')) 'Manufacturer',
		UPPER(JSON_VALUE(A.Message, '$.gaInsObj.assets[4].model')) 'Model',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[4].assetSerialNumber') 'Serial',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[4].reportedValue') 'Value',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[4].funder.funderName') 'LP_Name',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[4].usage') 'Usage',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[4].accessories') 'Accessories',
		JSON_VALUE(A.Message, '$.returnResponse.Assets[4].ProgramDescriptionExternal') 'Coverage',
		JSON_VALUE(A.Message, '$.returnResponse.Assets[4].ProgramCode') 'Program Code'

FROM	SESENROLLMENTAPIPRODCOPY.DBO.SERVICEREQUEST A
INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTCONTRACT EC ON			(	EC.CONTRACTNUMBER = JSON_VALUE(A.Message, '$.gaInsObj.contractNumber'))
INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENT E ON					(	EC.ID = E.ENROLLMENTCONTRACTID)

INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTCOVERAGEPERIOD ECP ON	(	E.ID = ECP.ENROLLMENTID AND
																		ECP.COVERAGEENDDATE > GETDATE() AND
																		ECP.ID = (	SELECT MAX(ECP2.ID) 
																					FROM SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTCOVERAGEPERIOD ECP2 
																					WHERE ECP2.ENROLLMENTID = E.ID
																					AND ECP2.COVERAGEPERIOD = ECP.COVERAGEPERIOD))
INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTTRANS ET ON				(	ET.ENROLLMENTCOVERAGEPERIODID = ECP.ID AND
																		ET.TRANSACTIONTYPEID = '1' AND
																		ET.ID = (	SELECT MAX(ET2.ID) 
																					FROM SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTTRANS ET2 
																					WHERE ET2.ENROLLMENTCOVERAGEPERIODID = ECP.ID))

INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTASSETLIST EAL ON			(	ET.ID = EAL.ENROLLMENTTRANSID)
INNER JOIN  SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTASSET EA ON				(	EA.ENROLLMENTASSETLISTID = EAL.ID AND
																		EA.ASSETNUMBER = JSON_VALUE(A.Message, '$.gaInsObj.assets[4].assetNumber'))

WHERE	A.CLIENTID = '2975'
AND		A.[FUNCTION] IN ('Lease_EnrSubmitPostRuleGroup','Lease_EnrReSubmitPostRuleGroup','Lease_ChangePostRuleGroup')
AND		JSON_VALUE(A.Message, '$.gaEnrollmentId') IS NOT NULL
AND		A.ID = (SELECT MAX(B.ID) FROM SESENROLLMENTAPIPRODCOPY.DBO.SERVICEREQUEST B 
				WHERE JSON_VALUE(B.Message, '$.gaInsObj.referenceId') = JSON_VALUE(A.Message, '$.gaInsObj.referenceId')
				AND B.ID = A.ID
				AND B.[FUNCTION] <> 'IC_PostErrRuleGroup')

UNION

SELECT	A.ID,
		EC.ID 'CONTRACT_ID',
		ET.ID 'ENROLL_TRAN',
		EA.ID 'ASSET_ID',
		CAST(JSON_VALUE(A.Message, '$.gaInsObj.coverageEndDate') AS DATE) 'Cov_End',
		JSON_VALUE(A.Message, '$.gaInsObj.contractNumber') 'Contract_Num',
		JSON_VALUE(A.Message, '$.gaInsObj.customer.customerNumber') 'Customer_Num',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[5].assetNumber') 'Bike_Num',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[5].acquisitionYear') 'Year',
		UPPER(JSON_VALUE(A.Message, '$.gaInsObj.assets[5].manufacturer')) 'Manufacturer',
		UPPER(JSON_VALUE(A.Message, '$.gaInsObj.assets[5].model')) 'Model',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[5].assetSerialNumber') 'Serial',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[5].reportedValue') 'Value',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[5].funder.funderName') 'LP_Name',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[5].usage') 'Usage',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[5].accessories') 'Accessories',
		JSON_VALUE(A.Message, '$.returnResponse.Assets[5].ProgramDescriptionExternal') 'Coverage',
		JSON_VALUE(A.Message, '$.returnResponse.Assets[5].ProgramCode') 'Program Code'

FROM	SESENROLLMENTAPIPRODCOPY.DBO.SERVICEREQUEST A
INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTCONTRACT EC ON			(	EC.CONTRACTNUMBER = JSON_VALUE(A.Message, '$.gaInsObj.contractNumber'))
INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENT E ON					(	EC.ID = E.ENROLLMENTCONTRACTID)

INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTCOVERAGEPERIOD ECP ON	(	E.ID = ECP.ENROLLMENTID AND
																		ECP.COVERAGEENDDATE > GETDATE() AND
																		ECP.ID = (	SELECT MAX(ECP2.ID) 
																					FROM SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTCOVERAGEPERIOD ECP2 
																					WHERE ECP2.ENROLLMENTID = E.ID
																					AND ECP2.COVERAGEPERIOD = ECP.COVERAGEPERIOD))
INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTTRANS ET ON				(	ET.ENROLLMENTCOVERAGEPERIODID = ECP.ID AND
																		ET.TRANSACTIONTYPEID = '1' AND
																		ET.ID = (	SELECT MAX(ET2.ID) 
																					FROM SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTTRANS ET2 
																					WHERE ET2.ENROLLMENTCOVERAGEPERIODID = ECP.ID))

INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTASSETLIST EAL ON			(	ET.ID = EAL.ENROLLMENTTRANSID)
INNER JOIN  SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTASSET EA ON				(	EA.ENROLLMENTASSETLISTID = EAL.ID AND
																		EA.ASSETNUMBER = JSON_VALUE(A.Message, '$.gaInsObj.assets[5].assetNumber'))

WHERE	A.CLIENTID = '2975'
AND		A.[FUNCTION] IN ('Lease_EnrSubmitPostRuleGroup','Lease_EnrReSubmitPostRuleGroup','Lease_ChangePostRuleGroup')
AND		JSON_VALUE(A.Message, '$.gaEnrollmentId') IS NOT NULL
AND		A.ID = (SELECT MAX(B.ID) FROM SESENROLLMENTAPIPRODCOPY.DBO.SERVICEREQUEST B 
				WHERE JSON_VALUE(B.Message, '$.gaInsObj.referenceId') = JSON_VALUE(A.Message, '$.gaInsObj.referenceId')
				AND B.ID = A.ID
				AND B.[FUNCTION] <> 'IC_PostErrRuleGroup')

UNION

SELECT	A.ID,
		EC.ID 'CONTRACT_ID',
		ET.ID 'ENROLL_TRAN',
		EA.ID 'ASSET_ID',
		CAST(JSON_VALUE(A.Message, '$.gaInsObj.coverageEndDate') AS DATE) 'Cov_End',
		JSON_VALUE(A.Message, '$.gaInsObj.contractNumber') 'Contract_Num',
		JSON_VALUE(A.Message, '$.gaInsObj.customer.customerNumber') 'Customer_Num',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[6].assetNumber') 'Bike_Num',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[6].acquisitionYear') 'Year',
		UPPER(JSON_VALUE(A.Message, '$.gaInsObj.assets[6].manufacturer')) 'Manufacturer',
		UPPER(JSON_VALUE(A.Message, '$.gaInsObj.assets[6].model')) 'Model',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[6].assetSerialNumber') 'Serial',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[6].reportedValue') 'Value',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[6].funder.funderName') 'LP_Name',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[6].usage') 'Usage',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[6].accessories') 'Accessories',
		JSON_VALUE(A.Message, '$.returnResponse.Assets[6].ProgramDescriptionExternal') 'Coverage',
		JSON_VALUE(A.Message, '$.returnResponse.Assets[6].ProgramCode') 'Program Code'

FROM	SESENROLLMENTAPIPRODCOPY.DBO.SERVICEREQUEST A
INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTCONTRACT EC ON			(	EC.CONTRACTNUMBER = JSON_VALUE(A.Message, '$.gaInsObj.contractNumber'))
INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENT E ON					(	EC.ID = E.ENROLLMENTCONTRACTID)

INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTCOVERAGEPERIOD ECP ON	(	E.ID = ECP.ENROLLMENTID AND
																		ECP.COVERAGEENDDATE > GETDATE() AND
																		ECP.ID = (	SELECT MAX(ECP2.ID) 
																					FROM SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTCOVERAGEPERIOD ECP2 
																					WHERE ECP2.ENROLLMENTID = E.ID
																					AND ECP2.COVERAGEPERIOD = ECP.COVERAGEPERIOD))
INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTTRANS ET ON				(	ET.ENROLLMENTCOVERAGEPERIODID = ECP.ID AND
																		ET.TRANSACTIONTYPEID = '1' AND
																		ET.ID = (	SELECT MAX(ET2.ID) 
																					FROM SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTTRANS ET2 
																					WHERE ET2.ENROLLMENTCOVERAGEPERIODID = ECP.ID))

INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTASSETLIST EAL ON			(	ET.ID = EAL.ENROLLMENTTRANSID)
INNER JOIN  SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTASSET EA ON				(	EA.ENROLLMENTASSETLISTID = EAL.ID AND
																		EA.ASSETNUMBER = JSON_VALUE(A.Message, '$.gaInsObj.assets[6].assetNumber'))

WHERE	A.CLIENTID = '2975'
AND		A.[FUNCTION] IN ('Lease_EnrSubmitPostRuleGroup','Lease_EnrReSubmitPostRuleGroup','Lease_ChangePostRuleGroup')
AND		JSON_VALUE(A.Message, '$.gaEnrollmentId') IS NOT NULL
AND		A.ID = (SELECT MAX(B.ID) FROM SESENROLLMENTAPIPRODCOPY.DBO.SERVICEREQUEST B 
				WHERE JSON_VALUE(B.Message, '$.gaInsObj.referenceId') = JSON_VALUE(A.Message, '$.gaInsObj.referenceId')
				AND B.ID = A.ID
				AND B.[FUNCTION] <> 'IC_PostErrRuleGroup')

UNION

SELECT	A.ID,
		EC.ID 'CONTRACT_ID',
		ET.ID 'ENROLL_TRAN',
		EA.ID 'ASSET_ID',
		CAST(JSON_VALUE(A.Message, '$.gaInsObj.coverageEndDate') AS DATE) 'Cov_End',
		JSON_VALUE(A.Message, '$.gaInsObj.contractNumber') 'Contract_Num',
		JSON_VALUE(A.Message, '$.gaInsObj.customer.customerNumber') 'Customer_Num',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[7].assetNumber') 'Bike_Num',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[7].acquisitionYear') 'Year',
		UPPER(JSON_VALUE(A.Message, '$.gaInsObj.assets[7].manufacturer')) 'Manufacturer',
		UPPER(JSON_VALUE(A.Message, '$.gaInsObj.assets[7].model')) 'Model',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[7].assetSerialNumber') 'Serial',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[7].reportedValue') 'Value',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[7].funder.funderName') 'LP_Name',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[7].usage') 'Usage',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[7].accessories') 'Accessories',
		JSON_VALUE(A.Message, '$.returnResponse.Assets[7].ProgramDescriptionExternal') 'Coverage',
		JSON_VALUE(A.Message, '$.returnResponse.Assets[7].ProgramCode') 'Program Code'

FROM	SESENROLLMENTAPIPRODCOPY.DBO.SERVICEREQUEST A
INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTCONTRACT EC ON			(	EC.CONTRACTNUMBER = JSON_VALUE(A.Message, '$.gaInsObj.contractNumber'))
INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENT E ON					(	EC.ID = E.ENROLLMENTCONTRACTID)

INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTCOVERAGEPERIOD ECP ON	(	E.ID = ECP.ENROLLMENTID AND
																		ECP.COVERAGEENDDATE > GETDATE() AND
																		ECP.ID = (	SELECT MAX(ECP2.ID) 
																					FROM SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTCOVERAGEPERIOD ECP2 
																					WHERE ECP2.ENROLLMENTID = E.ID
																					AND ECP2.COVERAGEPERIOD = ECP.COVERAGEPERIOD))
INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTTRANS ET ON				(	ET.ENROLLMENTCOVERAGEPERIODID = ECP.ID AND
																		ET.TRANSACTIONTYPEID = '1' AND
																		ET.ID = (	SELECT MAX(ET2.ID) 
																					FROM SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTTRANS ET2 
																					WHERE ET2.ENROLLMENTCOVERAGEPERIODID = ECP.ID))

INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTASSETLIST EAL ON			(	ET.ID = EAL.ENROLLMENTTRANSID)
INNER JOIN  SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTASSET EA ON				(	EA.ENROLLMENTASSETLISTID = EAL.ID AND
																		EA.ASSETNUMBER = JSON_VALUE(A.Message, '$.gaInsObj.assets[7].assetNumber'))

WHERE	A.CLIENTID = '2975'
AND		A.[FUNCTION] IN ('Lease_EnrSubmitPostRuleGroup','Lease_EnrReSubmitPostRuleGroup','Lease_ChangePostRuleGroup')
AND		JSON_VALUE(A.Message, '$.gaEnrollmentId') IS NOT NULL
AND		A.ID = (SELECT MAX(B.ID) FROM SESENROLLMENTAPIPRODCOPY.DBO.SERVICEREQUEST B 
				WHERE JSON_VALUE(B.Message, '$.gaInsObj.referenceId') = JSON_VALUE(A.Message, '$.gaInsObj.referenceId')
				AND B.ID = A.ID
				AND B.[FUNCTION] <> 'IC_PostErrRuleGroup')

UNION

SELECT	A.ID,
		EC.ID 'CONTRACT_ID',
		ET.ID 'ENROLL_TRAN',
		EA.ID 'ASSET_ID',
		CAST(JSON_VALUE(A.Message, '$.gaInsObj.coverageEndDate') AS DATE) 'Cov_End',
		JSON_VALUE(A.Message, '$.gaInsObj.contractNumber') 'Contract_Num',
		JSON_VALUE(A.Message, '$.gaInsObj.customer.customerNumber') 'Customer_Num',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[8].assetNumber') 'Bike_Num',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[8].acquisitionYear') 'Year',
		UPPER(JSON_VALUE(A.Message, '$.gaInsObj.assets[8].manufacturer')) 'Manufacturer',
		UPPER(JSON_VALUE(A.Message, '$.gaInsObj.assets[8].model')) 'Model',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[8].assetSerialNumber') 'Serial',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[8].reportedValue') 'Value',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[8].funder.funderName') 'LP_Name',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[8].usage') 'Usage',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[8].accessories') 'Accessories',
		JSON_VALUE(A.Message, '$.returnResponse.Assets[8].ProgramDescriptionExternal') 'Coverage',
		JSON_VALUE(A.Message, '$.returnResponse.Assets[8].ProgramCode') 'Program Code'

FROM	SESENROLLMENTAPIPRODCOPY.DBO.SERVICEREQUEST A
INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTCONTRACT EC ON			(	EC.CONTRACTNUMBER = JSON_VALUE(A.Message, '$.gaInsObj.contractNumber'))
INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENT E ON					(	EC.ID = E.ENROLLMENTCONTRACTID)

INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTCOVERAGEPERIOD ECP ON	(	E.ID = ECP.ENROLLMENTID AND
																		ECP.COVERAGEENDDATE > GETDATE() AND
																		ECP.ID = (	SELECT MAX(ECP2.ID) 
																					FROM SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTCOVERAGEPERIOD ECP2 
																					WHERE ECP2.ENROLLMENTID = E.ID
																					AND ECP2.COVERAGEPERIOD = ECP.COVERAGEPERIOD))
INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTTRANS ET ON				(	ET.ENROLLMENTCOVERAGEPERIODID = ECP.ID AND
																		ET.TRANSACTIONTYPEID = '1' AND
																		ET.ID = (	SELECT MAX(ET2.ID) 
																					FROM SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTTRANS ET2 
																					WHERE ET2.ENROLLMENTCOVERAGEPERIODID = ECP.ID))

INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTASSETLIST EAL ON			(	ET.ID = EAL.ENROLLMENTTRANSID)
INNER JOIN  SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTASSET EA ON				(	EA.ENROLLMENTASSETLISTID = EAL.ID AND
																		EA.ASSETNUMBER = JSON_VALUE(A.Message, '$.gaInsObj.assets[8].assetNumber'))

WHERE	A.CLIENTID = '2975'
AND		A.[FUNCTION] IN ('Lease_EnrSubmitPostRuleGroup','Lease_EnrReSubmitPostRuleGroup','Lease_ChangePostRuleGroup')
AND		JSON_VALUE(A.Message, '$.gaEnrollmentId') IS NOT NULL
AND		A.ID = (SELECT MAX(B.ID) FROM SESENROLLMENTAPIPRODCOPY.DBO.SERVICEREQUEST B 
				WHERE JSON_VALUE(B.Message, '$.gaInsObj.referenceId') = JSON_VALUE(A.Message, '$.gaInsObj.referenceId')
				AND B.ID = A.ID
				AND B.[FUNCTION] <> 'IC_PostErrRuleGroup')

UNION

SELECT	A.ID,
		EC.ID 'CONTRACT_ID',
		ET.ID 'ENROLL_TRAN',
		EA.ID 'ASSET_ID',
		CAST(JSON_VALUE(A.Message, '$.gaInsObj.coverageEndDate') AS DATE) 'Cov_End',
		JSON_VALUE(A.Message, '$.gaInsObj.contractNumber') 'Contract_Num',
		JSON_VALUE(A.Message, '$.gaInsObj.customer.customerNumber') 'Customer_Num',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[9].assetNumber') 'Bike_Num',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[9].acquisitionYear') 'Year',
		UPPER(JSON_VALUE(A.Message, '$.gaInsObj.assets[9].manufacturer')) 'Manufacturer',
		UPPER(JSON_VALUE(A.Message, '$.gaInsObj.assets[9].model')) 'Model',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[9].assetSerialNumber') 'Serial',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[9].reportedValue') 'Value',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[9].funder.funderName') 'LP_Name',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[9].usage') 'Usage',
		JSON_VALUE(A.Message, '$.gaInsObj.assets[9].accessories') 'Accessories',
		JSON_VALUE(A.Message, '$.returnResponse.Assets[9].ProgramDescriptionExternal') 'Coverage',
		JSON_VALUE(A.Message, '$.returnResponse.Assets[9].ProgramCode') 'Program Code'

FROM	SESENROLLMENTAPIPRODCOPY.DBO.SERVICEREQUEST A
INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTCONTRACT EC ON			(	EC.CONTRACTNUMBER = JSON_VALUE(A.Message, '$.gaInsObj.contractNumber'))
INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENT E ON					(	EC.ID = E.ENROLLMENTCONTRACTID)

INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTCOVERAGEPERIOD ECP ON	(	E.ID = ECP.ENROLLMENTID AND
																		ECP.COVERAGEENDDATE > GETDATE() AND
																		ECP.ID = (	SELECT MAX(ECP2.ID) 
																					FROM SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTCOVERAGEPERIOD ECP2 
																					WHERE ECP2.ENROLLMENTID = E.ID
																					AND ECP2.COVERAGEPERIOD = ECP.COVERAGEPERIOD))
INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTTRANS ET ON				(	ET.ENROLLMENTCOVERAGEPERIODID = ECP.ID AND
																		ET.TRANSACTIONTYPEID = '1' AND
																		ET.ID = (	SELECT MAX(ET2.ID) 
																					FROM SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTTRANS ET2 
																					WHERE ET2.ENROLLMENTCOVERAGEPERIODID = ECP.ID))

INNER JOIN	SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTASSETLIST EAL ON			(	ET.ID = EAL.ENROLLMENTTRANSID)
INNER JOIN  SESENROLLMENTAPIPRODCOPY.DBO.ENROLLMENTASSET EA ON				(	EA.ENROLLMENTASSETLISTID = EAL.ID AND
																		EA.ASSETNUMBER = JSON_VALUE(A.Message, '$.gaInsObj.assets[9].assetNumber'))

WHERE	A.CLIENTID = '2975'
AND		A.[FUNCTION] IN ('Lease_EnrSubmitPostRuleGroup','Lease_EnrReSubmitPostRuleGroup','Lease_ChangePostRuleGroup')
AND		JSON_VALUE(A.Message, '$.gaEnrollmentId') IS NOT NULL
AND		A.ID = (SELECT MAX(B.ID) FROM SESENROLLMENTAPIPRODCOPY.DBO.SERVICEREQUEST B 
				WHERE JSON_VALUE(B.Message, '$.gaInsObj.referenceId') = JSON_VALUE(A.Message, '$.gaInsObj.referenceId')
				AND B.ID = A.ID
				AND B.[FUNCTION] <> 'IC_PostErrRuleGroup')

ORDER BY CONTRACT_ID, BIKE_NUM