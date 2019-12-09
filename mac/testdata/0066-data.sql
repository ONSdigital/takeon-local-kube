Insert Into dev01.ValidationRule
(
    Rule,
    Name,
    BaseFormula,
    CreatedBy,
    CreatedDate
)
Values
( 'VP','Value Present','"question" != ""',current_user,now()),
( 'POPM','Period on Period Movement','abs(question - comparison_question) > threshold AND question > 0 AND comparison_question > 0',current_user,now()),
( 'POPZC','Period on Period Zero Continuity','question != comparison_question AND ( question = 0 OR comparison_question = 0 ) AND abs(question - comparison_question) > threshold',current_user,now()),
( 'QVDQ','Question vs Derived Question','question != comparison_question',current_user,now());


Insert Into dev01.ValidationPeriod
(
    Rule,
    PeriodOffset,
    CreatedBy,
    CreatedDate
)
Values
    ('VP',0,current_user,now()),
    ('POPM',0,current_user,now()),
    ('POPM',1,current_user,now()),
    ('POPZC',0,current_user,now()),
    ('POPZC',1,current_user,now()),
    ('QVDQ',0,current_user,now());


Insert Into dev01.ValidationAttribute
(
    AttributeName,
    Source,
    CreatedBy,
    CreatedDate
)
Values
('Default', 'Default', 'fisdba', now());


Insert Into dev01.Survey
(
    survey,
    description,
    periodicity,
    CreatedBy,
    CreatedDate
)
Values

( '0066','Quarterly Survey of Building Materials Sand and Gravel (land-won)','Quarterly','fisdba', now() );

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
( 1, '0066', 'Quarterly Survey of Building Materials - Sand and Gravel (land-won)', '201803', '999912','fisdba', now() );

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
( '0066', '9001', 'fisdba', now());



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

( 1, '0601', 'Q601', 'Sand produced for asphalt (asphalting sand)', 1, 'NUMERIC', '', 'fisdba', now() ),
( 1, '0602', 'Q602', 'Sand produced for use in mortar (building or soft sand)', 2, 'NUMERIC', '', 'fisdba', now() ),
( 1, '0603', 'Q603', 'Sand produced for concreting (sharp sand)', 3, 'NUMERIC', '', 'fisdba', now() ),
( 1, '0604', 'Q604', 'Gravel coated with bituminous binder (on or off site)', 4, 'NUMERIC', '', 'fisdba', now() ),
( 1, '0605', 'Q605', 'Gravel produced for concrete aggregate (including sand/gravel mixes)', 5, 'NUMERIC', '', 'fisdba', now() ),
( 1, '0606', 'Q606', 'Other screened and graded gravels', 6, 'NUMERIC', '', 'fisdba', now() ),
( 1, '0607', 'Q607', 'Sand and gravel used for constructional fill', 7, 'NUMERIC', '', 'fisdba', now() ),
( 1, '0608', 'Q608', 'TOTALS', 8, 'NUMERIC', '', 'fisdba', now() ),
( 1, '0147', 'Q147', 'New pits or quarries brought into use since date of last return', 9, 'NUMERIC', '', 'fisdba', now() ),
( 1, '0146', 'Q146', 'Comment on the figures included in your return', 10, 'TICKBOX-Yes', '', 'fisdba', now() ),
( 1, '9001', 'Q9001', 'Derived Total of all sand and gravel (Q601 + Q602 + Q603 + Q604 + Q605 + Q606 + Q607)', 11, 'TICKBOX-Yes', '0601 + 0602 + 0603 + 0604 + 0605 + 0606 + 0607', 'fisdba', now() );

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
(   '49900000796', '201903', '0066', 1, 'Dispatched', now(), '0004', 'T', '70110', '70110', '41100', '41100', 750, 748, 100, 100, 100, 100, 99999, 99999, '9900000796', '2906948169', 1, 'S', '326935020502', '2135632144542', '97395797', 178, 0, 0, '1', 'E', 'NP', '06/06/1975', 'Hayes, Fletcher and Shaw', 'Lawrence Group Ltd', '9 Brenda falls, East Harry, Wales', 'L2T 0PR', 'Sole Trader', 'Heather Griffiths', '01633 5551234', '', 'P', '', 'fisdba', now() ),
(   '49900002189', '201903', '0066', 1, 'Dispatched', now(), '0004', 'T', '70110', '70110', '41100', '41100', 25, 25, 22, 22, 22, 22, 12345, 12345, '9900002189', '2928514836', 1, 'S', '423279595848', '9446786207965', '55841012', 71, 0, 0, '1', 'E', 'BS', '18/12/1978', 'Grant-Wright', 'Williams PLC', '8 Alexandra ports, Denisfort, Wales', 'N60 6TL', 'Sole Trader', 'Jacob Thorpe', '0117 9555123', '', 'P', '', 'fisdba', now() ),
(   '49900002387', '201903', '0066', 1, 'Dispatched', now(), '0004', 'F', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900002387', '2931260132', 1, 'S', '979024265812', '3101057635557', '74239110', 2, 0, 0, '1', 'E', 'CF', '15/07/1983', 'Edwards-Savage and Sons', 'Long and Sons', '14 Page bypass, Watershaven, Scotland', 'L8 9QE', 'Franchise', 'Gillian Bailey', '029 20555123', '', 'P', '', 'fisdba', now() ),
(   '49900008900', '201903', '0066', 1, 'Dispatched', now(), '0004', 'S', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900008900', '2988769191', 1, 'S', '650195077639', '5864180611950', '94403544', 7, 1, 0, '1', 'E', 'CF', '01/04/2011', 'Barnes Inc', 'Jackson, Cooper and Palmer', '2 Bird island, Kellyhaven, England', 'CM4B 6UR', '', 'Ronald Field-Williams', '01633 5559912', '', 'P', '', 'fisdba', now() ),
(   '49900012765', '201906', '0066', 1, 'Dispatched', now(), '0004', 'M', '70110', '70110', '41100', '41100', 750, 748, 100, 100, 100, 100, 99999, 99999, '9900012765', '2922451920', 1, 'S', '898038558701', '2690058876978', '69059744', 6, 1, 0, '1', 'E', 'NP', '28/04/1977', '', 'Sandy Land Company Ltd.', 'Sandybank Estate, Newport, UK', 'NP10 1AA', '', 'Sandra Landy', '01633 5551234', '', 'P', '', 'fisdba', now() ),
(   '49900024849', '201906', '0066', 1, 'Dispatched', now(), '0004', 'G', '70110', '70110', '41100', '41100', 25, 25, 22, 22, 22, 22, 12345, 12345, '9900024849', '2934942130', 1, 'S', '149294328171', '3660987585937', '23670278', 0, 0, 0, '1', 'E', 'BS', '12/12/1970', '', 'James-Johnson', '8 Ali row, North Elaineton, England', 'FK31 7WJ', '', 'Rachael Farrell', '0117 9555123', '', 'P', '', 'fisdba', now() ),
(   '49900025178', '201906', '0066', 1, 'Dispatched', now(), '0004', 'K', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900025178', '2961727813', 1, 'S', '644055013735', '1567986355199', '70046170', 12, 0, 0, '1', 'E', 'CF', '09/01/1982', '', 'Davidson LLC', '53 Evans club, Walshburgh, Northern Ireland', 'WR69 8TP', '', 'Gemma Houghton-Howard', '029 20555123', '', 'P', '', 'fisdba', now() ),
(   '49900864204', '201906', '0066', 1, 'Dispatched', now(), '0004', 'A', '60241', '60241', '49420', '49420', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900864204', '2968297628', 1, 'S', '373831465848', '4030190271735', '46993901', 100, 0, 0, '1', 'E', 'CF', '02/12/2001', '', 'Macdonald, Evans and ONeill', '1 Davey passage, Lake Joanneborough, Northern Ireland', 'BT2 8TH', '', 'Kennedy-Doyle', '01633 5559912', '', 'P', '', 'fisdba', now() ),


(   '49900000796', '201906', '0066', 1, 'Dispatched', now(), '0004', 'T', '70110', '70110', '41100', '41100', 750, 748, 100, 100, 100, 100, 99999, 99999, '9900000796', '2906948169', 1, 'S', '326935020502', '2135632144542', '97395797', 178, 0, 0, '1', 'E', 'NP', '06/06/1975', 'Hayes, Fletcher and Shaw', 'Lawrence Group Ltd', '9 Brenda falls, East Harry, Wales', 'L2T 0PR', 'Sole Trader', 'Heather Griffiths', '01633 5551234', '', 'P', '', 'fisdba', now() ),
(   '49900002387', '201906', '0066', 1, 'Dispatched', now(), '0004', 'F', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900002387', '2931260132', 1, 'S', '979024265812', '3101057635557', '74239110', 2, 0, 0, '1', 'E', 'CF', '15/07/1983', 'Edwards-Savage and Sons', 'Long and Sons', '14 Page bypass, Watershaven, Scotland', 'L8 9QE', 'Franchise', 'Gillian Bailey', '029 20555123', '', 'P', '', 'fisdba', now() ),
(   '49900008900', '201906', '0066', 1, 'Dispatched', now(), '0004', 'S', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900008900', '2988769191', 1, 'S', '650195077639', '5864180611950', '94403544', 7, 1, 0, '1', 'E', 'CF', '01/04/2011', 'Barnes Inc', 'Jackson, Cooper and Palmer', '2 Bird island, Kellyhaven, England', 'CM4B 6UR', '', 'Ronald Field-Williams', '01633 5559912', '', 'P', '', 'fisdba', now() ),
(   '49900012765', '201903', '0066', 1, 'Dispatched', now(), '0004', 'M', '70110', '70110', '41100', '41100', 750, 748, 100, 100, 100, 100, 99999, 99999, '9900012765', '2922451920', 1, 'S', '898038558701', '2690058876978', '69059744', 6, 1, 0, '1', 'E', 'NP', '28/04/1977', '', 'Sandy Land Company Ltd.', 'Sandybank Estate, Newport, UK', 'NP10 1AA', '', 'Sandra Landy', '01633 5551234', '', 'P', '', 'fisdba', now() ),
(   '49900024849', '201903', '0066', 1, 'Dispatched', now(), '0004', 'G', '70110', '70110', '41100', '41100', 25, 25, 22, 22, 22, 22, 12345, 12345, '9900024849', '2934942130', 1, 'S', '149294328171', '3660987585937', '23670278', 0, 0, 0, '1', 'E', 'BS', '12/12/1970', '', 'James-Johnson', '8 Ali row, North Elaineton, England', 'FK31 7WJ', '', 'Rachael Farrell', '0117 9555123', '', 'P', '', 'fisdba', now() ),
(   '49900025178', '201903', '0066', 1, 'Dispatched', now(), '0004', 'K', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900025178', '2961727813', 1, 'S', '644055013735', '1567986355199', '70046170', 12, 0, 0, '1', 'E', 'CF', '09/01/1982', '', 'Davidson LLC', '53 Evans club, Walshburgh, Northern Ireland', 'WR69 8TP', '', 'Gemma Houghton-Howard', '029 20555123', '', 'P', '', 'fisdba', now() ),
(   '49900864204', '201903', '0066', 1, 'Dispatched', now(), '0004', 'A', '60241', '60241', '49420', '49420', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900864204', '2968297628', 1, 'S', '373831465848', '4030190271735', '46993901', 100, 0, 0, '1', 'E', 'CF', '02/12/2001', '', 'Macdonald, Evans and ONeill', '1 Davey passage, Lake Joanneborough, Northern Ireland', 'BT2 8TH', '', 'Kennedy-Doyle', '01633 5559912', '', 'P', '', 'fisdba', now() );


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
    (10,1,'POPM','0601','0','W',current_user,now()),
    (11,1,'POPM','0602','0','W',current_user,now()),
    (12,1,'POPM','0603','0','W',current_user,now()),
    (13,1,'POPM','0604','0','W',current_user,now()),
    (14,1,'POPM','0605','0','W',current_user,now()),
    (15,1,'POPM','0606','0','W',current_user,now()),
    (16,1,'POPM','0607','0','W',current_user,now()),

    (20,1,'POPZC','0602','0','E',current_user,now()),
    (30,1,'VP','0147','0','E',current_user,now()),
    (40,1,'QVDQ','0608','0','W',current_user,now());


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
( 10, 'Default', 'Default', 'question', '0601', 'response', 0, current_user, now() ),
( 10, 'Default', 'Default', 'comparison_question', '0601', 'response', 1, current_user, now() ),
( 10, 'Default', 'Default', 'threshold', '20000', '', 0, current_user, now() ),
( 11, 'Default', 'Default', 'question', '0602', 'response', 0, current_user, now() ),
( 11, 'Default', 'Default', 'comparison_question', '0602', 'response', 1, current_user, now() ),
( 11, 'Default', 'Default', 'threshold', '20000', '', 0, current_user, now() ),

( 12, 'Default', 'Default', 'question', '0603', 'response', 0, current_user, now() ),
( 12, 'Default', 'Default', 'comparison_question', '0603', 'response', 1, current_user, now() ),
( 12, 'Default', 'Default', 'threshold', '20000', '', 0, current_user, now() ),

( 13, 'Default', 'Default', 'question', '0604', 'response', 0, current_user, now() ),
( 13, 'Default', 'Default', 'comparison_question', '0604', 'response', 1, current_user, now() ),
( 13, 'Default', 'Default', 'threshold', '20000', '', 0, current_user, now() ),

( 14, 'Default', 'Default', 'question', '0605', 'response', 0, current_user, now() ),
( 14, 'Default', 'Default', 'comparison_question', '0605', 'response', 1, current_user, now() ),
( 14, 'Default', 'Default', 'threshold', '20000', '', 0, current_user, now() ),

( 15, 'Default', 'Default', 'question', '0606', 'response', 0, current_user, now() ),
( 15, 'Default', 'Default', 'comparison_question', '0606', 'response', 1, current_user, now() ),
( 15, 'Default', 'Default', 'threshold', '20000', '', 0, current_user, now() ),

( 16, 'Default', 'Default', 'question', '0607', 'response', 0, current_user, now() ),
( 16, 'Default', 'Default', 'comparison_question', '0607', 'response', 1, current_user, now() ),
( 16, 'Default', 'Default', 'threshold', '20000', '', 0, current_user, now() ),

( 20, 'Default', 'Default', 'question', '0602', 'response', 0, current_user, now() ),
( 20, 'Default', 'Default', 'comparison_question', '0602', 'response', 1, current_user, now() ),
( 20, 'Default', 'Default', 'threshold', '0', '', 0, current_user, now() ),

( 30, 'Default', 'Default', 'question', '0147', 'response', 0, current_user, now() ),

( 40, 'Default', 'Default', 'question', '0608', 'response', 0, current_user, now() ),
( 40, 'Default', 'Default', 'comparison_question', '9001', 'response', 0, current_user, now() );
