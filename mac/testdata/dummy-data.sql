Insert Into dev01.Survey
(
    survey,
    description,
    periodicity,
    CreatedBy,
    CreatedDate
)
Values

( '0066','Quarterly Survey of Building Materials Sand and Gravel (land-won)','Quarterly','fisdba', now() ),
( '0076','Quarterly Survey of Building Materials Sand and Gravel (Marine)','Quarterly','fisdba', now() ),
( '0073','Monthly Survey of Building Materials - Concrete Building Blocks', 'Monthly','fisdba', now() ),
( '0074','Monthly Survey of Building Materials - Bricks', 'Monthly','fisdba', now() );

Insert Into dev01.Form
(
    FormID,
    Survey,
    Description,
    PeriodStart,
    PeriodEnd,
    CreatedBy,
    CreatedDate
)
Values
( 2, '0066', 'Quarterly Survey of Building Materials - Sand and Gravel (land-won)', '201803', '999912','fisdba', now() ),
( 3, '0076', 'Quarterly Survey of Building Materials - Sand and Gravel (marine dredged)', '201803', '999912','fisdba', now() ),
( 4, '0073', 'Monthly Survey of Building Materials - Concrete Building Blocks', '201801', '999912', 'fisdba', now() ),
( 5, '0074', 'Monthly Survey of Building Materials - Bricks', '201801', '999912', 'fisdba', now() );

Insert Into dev01.Question
(
    Survey,
    QuestionCode,
    CreatedBy,
    CreatedDate
)
Values

( '0066', '0601', 'fisdba', now()),
( '0066', '0602', 'fisdba', now()),
( '0066', '0603', 'fisdba', now()),
( '0066', '0604', 'fisdba', now()),
( '0066', '0605', 'fisdba', now()),
( '0066', '0606', 'fisdba', now()),
( '0066', '0607', 'fisdba', now()),
( '0066', '0608', 'fisdba', now()),
( '0066', '0147', 'fisdba', now()),
( '0066', '0146', 'fisdba', now()),
( '0066', '9001', 'fisdba', now()),

( '0076', '0601', 'fisdba', now()),
( '0076', '0602', 'fisdba', now()),
( '0076', '0603', 'fisdba', now()),
( '0076', '0604', 'fisdba', now()),
( '0076', '0605', 'fisdba', now()),
( '0076', '0606', 'fisdba', now()),
( '0076', '0607', 'fisdba', now()),
( '0076', '0608', 'fisdba', now()),
( '0076', '0147', 'fisdba', now()),
( '0076', '0146', 'fisdba', now()),
( '0076', '9001', 'fisdba', now()),

( '0073', '0101', 'fisdba', now()),
( '0073', '0102', 'fisdba', now()),
( '0073', '0103', 'fisdba', now()),
( '0073', '0104', 'fisdba', now()),
( '0073', '0111', 'fisdba', now()),
( '0073', '0112', 'fisdba', now()),
( '0073', '0113', 'fisdba', now()),
( '0073', '0114', 'fisdba', now()),
( '0073', '0121', 'fisdba', now()),
( '0073', '0122', 'fisdba', now()),
( '0073', '0123', 'fisdba', now()),
( '0073', '0124', 'fisdba', now()),
( '0073', '0145', 'fisdba', now()),
( '0073', '0146', 'fisdba', now());



Insert Into dev01.FormDefinition
(
    FormID,
    QuestionCode,
    DisplayQuestionNumber,
    DisplayText,
    DisplayOrder,
    Type,
    DerivedFormula,
    CreatedBy,
    CreatedDate
)
Values

( 2, '0601', 'Q601', 'Sand produced for asphalt (asphalting sand)', 1, 'NUMERIC', '', 'fisdba', now() ),
( 2, '0602', 'Q602', 'Sand produced for use in mortar (building or soft sand)', 2, 'NUMERIC', '', 'fisdba', now() ),
( 2, '0603', 'Q603', 'Sand produced for concreting (sharp sand)', 3, 'NUMERIC', '', 'fisdba', now() ),
( 2, '0604', 'Q604', 'Gravel coated with bituminous binder (on or off site)', 4, 'NUMERIC', '', 'fisdba', now() ),
( 2, '0605', 'Q605', 'Gravel produced for concrete aggregate (including sand/gravel mixes)', 5, 'NUMERIC', '', 'fisdba', now() ),
( 2, '0606', 'Q606', 'Other screened and graded gravels', 6, 'NUMERIC', '', 'fisdba', now() ),
( 2, '0607', 'Q607', 'Sand and gravel used for constructional fill', 7, 'NUMERIC', '', 'fisdba', now() ),
( 2, '0608', 'Q608', 'TOTALS', 8, 'NUMERIC', '', 'fisdba', now() ),
( 2, '0147', 'Q147', 'New pits or quarries brought into use since date of last return', 9, 'NUMERIC', '', 'fisdba', now() ),
( 2, '0146', 'Q146', 'Comment on the figures included in your return', 10, 'TICKBOX-Yes', '', 'fisdba', now() ),
( 2, '9001', 'Q9001', 'Derived Total of all sand and gravel (Q601 + Q602 + Q603 + Q604 + Q605 + Q606 + Q607)', 11, 'TICKBOX-Yes', '0601 + 0602 + 0603 + 0604 + 0605 + 0606 + 0607', 'fisdba', now() ),

( 3, '0601', 'Q601', 'Sand produced for asphalt (asphalting sand)', 1, 'NUMERIC', '', 'fisdba', now() ),
( 3, '0602', 'Q602', 'Sand produced for use in mortar (building or soft sand)', 2, 'NUMERIC', '', 'fisdba', now() ),
( 3, '0603', 'Q603', 'Sand produced for concreting (sharp sand)', 3, 'NUMERIC', '', 'fisdba', now() ),
( 3, '0604', 'Q604', 'Gravel coated with bituminous binder (on or off site)', 4, 'NUMERIC', '', 'fisdba', now() ),
( 3, '0605', 'Q605', 'Gravel produced for concrete aggregate (including sand/gravel mixes)', 5, 'NUMERIC', '', 'fisdba', now() ),
( 3, '0606', 'Q606', 'Other screened and graded gravels', 6, 'NUMERIC', '', 'fisdba', now() ),
( 3, '0607', 'Q607', 'Sand and gravel used for constructional fill', 7, 'NUMERIC', '', 'fisdba', now() ),
( 3, '0608', 'Q608', 'TOTALS', 8, 'NUMERIC', '', 'fisdba', now() ),
( 3, '0147', 'Q147', 'New ports of landing brought into use since date of last return (please state details)', 9, 'NUMERIC', '', 'fisdba', now() ),
( 3, '0146', 'Q146', 'Comment on the figures included in your return', 10, 'TICKBOX-Yes', '', 'fisdba', now() ),
( 3, '9001', 'Q9001', 'Derived Total of all sand and gravel (Q601 + Q602 + Q603 + Q604 + Q605 + Q606 + Q607)', 11, 'NUMERIC', '0601 + 0602 + 0603 + 0604 + 0605 + 0606 + 0607', 'fisdba', now() );


Insert Into dev01.Contributor
(
    Reference                  ,
    Period                     ,
    Survey                     ,
    FormID                     ,
    Status                     ,
    ReceiptDate                ,
    FormType                   ,
    Checkletter                ,
    FrozenSicOutdated          ,
    RuSicOutdated              ,
    FrozenSic                  ,
    RuSic                      ,
    FrozenEmployees            ,
    Employees                  ,
    FrozenEmployment           ,
    Employment                 ,
    FrozenFteEmployment        ,
    FteEmployment              ,
    FrozenTurnover             ,
    Turnover                   ,
    EnterpriseReference        ,
    WowEnterpriseReference     ,
    CellNumber                 ,
    Currency                   ,
    VatReference               ,
    PayeReference              ,
    CompanyRegistrationNumber  ,
    NumberLiveLocalUnits       ,
    NumberLiveVat              ,
    NumberLivePaye             ,
    LegalStatus                ,
    ReportingUnitMarker        ,
    Region                     ,
    BirthDate                  ,
    EnterpriseName             ,
    ReferenceName              ,
    ReferenceAddress           ,
    ReferencePostcode          ,
    TradingStyle               ,
    Contact                    ,
    Telephone                  ,
    Fax                        ,
    SelectionType              ,
    InclusionExclusion         ,
    CreatedBy                  ,
    CreatedDate
)
Values
(   '49900000796', '201903', '0066', 2, 'Dispatched', now(), '0004', 'T', '70110', '70110', '41100', '41100', 750, 748, 100, 100, 100, 100, 99999, 99999, '9900000796', '2906948169', 1, 'S', '326935020502', '2135632144542', '97395797', 178, 0, 0, '1', 'E', 'NP', '06/06/1975', 'Hayes, Fletcher and Shaw', 'Lawrence Group Ltd', '9 Brenda falls, East Harry, Wales', 'L2T 0PR', 'Sole Trader', 'Heather Griffiths', '01633 5551234', '', 'P', '', 'fisdba', now() ),
(   '49900002189', '201903', '0066', 2, 'Dispatched', now(), '0004', 'T', '70110', '70110', '41100', '41100', 25, 25, 22, 22, 22, 22, 12345, 12345, '9900002189', '2928514836', 1, 'S', '423279595848', '9446786207965', '55841012', 71, 0, 0, '1', 'E', 'BS', '18/12/1978', 'Grant-Wright', 'Williams PLC', '8 Alexandra ports, Denisfort, Wales', 'N60 6TL', 'Sole Trader', 'Jacob Thorpe', '0117 9555123', '', 'P', '', 'fisdba', now() ),
(   '49900002387', '201903', '0066', 2, 'Dispatched', now(), '0004', 'F', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900002387', '2931260132', 1, 'S', '979024265812', '3101057635557', '74239110', 2, 0, 0, '1', 'E', 'CF', '15/07/1983', 'Edwards-Savage and Sons', 'Long and Sons', '14 Page bypass, Watershaven, Scotland', 'L8 9QE', 'Franchise', 'Gillian Bailey', '029 20555123', '', 'P', '', 'fisdba', now() ),
(   '49900008900', '201903', '0066', 2, 'Dispatched', now(), '0004', 'S', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900008900', '2988769191', 1, 'S', '650195077639', '5864180611950', '94403544', 7, 1, 0, '1', 'E', 'CF', '01/04/2011', 'Barnes Inc', 'Jackson, Cooper and Palmer', '2 Bird island, Kellyhaven, England', 'CM4B 6UR', '', 'Ronald Field-Williams', '01633 5559912', '', 'P', '', 'fisdba', now() ),
(   '49900012765', '201906', '0066', 2, 'Dispatched', now(), '0004', 'M', '70110', '70110', '41100', '41100', 750, 748, 100, 100, 100, 100, 99999, 99999, '9900012765', '2922451920', 1, 'S', '898038558701', '2690058876978', '69059744', 6, 1, 0, '1', 'E', 'NP', '28/04/1977', '', 'Sandy Land Company Ltd.', 'Sandybank Estate, Newport, UK', 'NP10 1AA', '', 'Sandra Landy', '01633 5551234', '', 'P', '', 'fisdba', now() ),
(   '49900024849', '201906', '0066', 2, 'Dispatched', now(), '0004', 'G', '70110', '70110', '41100', '41100', 25, 25, 22, 22, 22, 22, 12345, 12345, '9900024849', '2934942130', 1, 'S', '149294328171', '3660987585937', '23670278', 0, 0, 0, '1', 'E', 'BS', '12/12/1970', '', 'James-Johnson', '8 Ali row, North Elaineton, England', 'FK31 7WJ', '', 'Rachael Farrell', '0117 9555123', '', 'P', '', 'fisdba', now() ),
(   '49900025178', '201906', '0066', 2, 'Dispatched', now(), '0004', 'K', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900025178', '2961727813', 1, 'S', '644055013735', '1567986355199', '70046170', 12, 0, 0, '1', 'E', 'CF', '09/01/1982', '', 'Davidson LLC', '53 Evans club, Walshburgh, Northern Ireland', 'WR69 8TP', '', 'Gemma Houghton-Howard', '029 20555123', '', 'P', '', 'fisdba', now() ),
(   '49900864204', '201906', '0066', 2, 'Dispatched', now(), '0004', 'A', '60241', '60241', '49420', '49420', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900864204', '2968297628', 1, 'S', '373831465848', '4030190271735', '46993901', 100, 0, 0, '1', 'E', 'CF', '02/12/2001', '', 'Macdonald, Evans and ONeill', '1 Davey passage, Lake Joanneborough, Northern Ireland', 'BT2 8TH', '', 'Kennedy-Doyle', '01633 5559912', '', 'P', '', 'fisdba', now() ),


(   '49900000796', '201906', '0066', 2, 'Dispatched', now(), '0004', 'T', '70110', '70110', '41100', '41100', 750, 748, 100, 100, 100, 100, 99999, 99999, '9900000796', '2906948169', 1, 'S', '326935020502', '2135632144542', '97395797', 178, 0, 0, '1', 'E', 'NP', '06/06/1975', 'Hayes, Fletcher and Shaw', 'Lawrence Group Ltd', '9 Brenda falls, East Harry, Wales', 'L2T 0PR', 'Sole Trader', 'Heather Griffiths', '01633 5551234', '', 'P', '', 'fisdba', now() ),
(   '49900002387', '201906', '0066', 2, 'Dispatched', now(), '0004', 'F', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900002387', '2931260132', 1, 'S', '979024265812', '3101057635557', '74239110', 2, 0, 0, '1', 'E', 'CF', '15/07/1983', 'Edwards-Savage and Sons', 'Long and Sons', '14 Page bypass, Watershaven, Scotland', 'L8 9QE', 'Franchise', 'Gillian Bailey', '029 20555123', '', 'P', '', 'fisdba', now() ),
(   '49900008900', '201906', '0066', 2, 'Dispatched', now(), '0004', 'S', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900008900', '2988769191', 1, 'S', '650195077639', '5864180611950', '94403544', 7, 1, 0, '1', 'E', 'CF', '01/04/2011', 'Barnes Inc', 'Jackson, Cooper and Palmer', '2 Bird island, Kellyhaven, England', 'CM4B 6UR', '', 'Ronald Field-Williams', '01633 5559912', '', 'P', '', 'fisdba', now() ),
(   '49900012765', '201903', '0066', 2, 'Dispatched', now(), '0004', 'M', '70110', '70110', '41100', '41100', 750, 748, 100, 100, 100, 100, 99999, 99999, '9900012765', '2922451920', 1, 'S', '898038558701', '2690058876978', '69059744', 6, 1, 0, '1', 'E', 'NP', '28/04/1977', '', 'Sandy Land Company Ltd.', 'Sandybank Estate, Newport, UK', 'NP10 1AA', '', 'Sandra Landy', '01633 5551234', '', 'P', '', 'fisdba', now() ),
(   '49900024849', '201903', '0066', 2, 'Dispatched', now(), '0004', 'G', '70110', '70110', '41100', '41100', 25, 25, 22, 22, 22, 22, 12345, 12345, '9900024849', '2934942130', 1, 'S', '149294328171', '3660987585937', '23670278', 0, 0, 0, '1', 'E', 'BS', '12/12/1970', '', 'James-Johnson', '8 Ali row, North Elaineton, England', 'FK31 7WJ', '', 'Rachael Farrell', '0117 9555123', '', 'P', '', 'fisdba', now() ),
(   '49900025178', '201903', '0066', 2, 'Dispatched', now(), '0004', 'K', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900025178', '2961727813', 1, 'S', '644055013735', '1567986355199', '70046170', 12, 0, 0, '1', 'E', 'CF', '09/01/1982', '', 'Davidson LLC', '53 Evans club, Walshburgh, Northern Ireland', 'WR69 8TP', '', 'Gemma Houghton-Howard', '029 20555123', '', 'P', '', 'fisdba', now() ),
(   '49900864204', '201903', '0066', 2, 'Dispatched', now(), '0004', 'A', '60241', '60241', '49420', '49420', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900864204', '2968297628', 1, 'S', '373831465848', '4030190271735', '46993901', 100, 0, 0, '1', 'E', 'CF', '02/12/2001', '', 'Macdonald, Evans and ONeill', '1 Davey passage, Lake Joanneborough, Northern Ireland', 'BT2 8TH', '', 'Kennedy-Doyle', '01633 5559912', '', 'P', '', 'fisdba', now() );


Insert Into dev01.ValidationForm
(
    ValidationID,
    FormID,
    Rule,
    PrimaryQuestion,
    DefaultValue,
    Severity,
    CreatedBy,
    CreatedDate
)
Values
    (50,2,'POPM','0601','0','W',current_user,now());


Insert Into dev01.ValidationParameter
(
    ValidationID,
    AttributeName,
    AttributeValue,
    Parameter,
    Value,
    Source,
    PeriodOffset,
    CreatedBy,
    CreatedDate
)
Values
( 50, 'Default', 'Default', 'question', '0601', 'response', 0, current_user, now() ),
( 50, 'Default', 'Default', 'comparison_question', '0601', 'response', 1, current_user, now() ),
( 50, 'Default', 'Default', 'threshold', '20000', '', 0, current_user, now() );

