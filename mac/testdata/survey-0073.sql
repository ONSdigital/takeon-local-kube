Insert Into dev01.Survey
(
    survey,
    description,
    periodicity,
    CreatedBy,
    CreatedDate
)
Values

( '0073','Monthly Survey of Concrete Blocks','Quarterly','fisdba', now() );

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
( 3, '0073', 'Monthly Survey of Concrete Blocks', '201803', '999912','fisdba', now() );

Insert Into dev01.Question
(
    Survey,
    QuestionCode,
    CreatedBy,
    CreatedDate
)
Values

( '0073', '0101', 'fisdba', now()),
( '0073', '0111', 'fisdba', now()),
( '0073', '0102', 'fisdba', now()),
( '0073', '0112', 'fisdba', now()),
( '0073', '0103', 'fisdba', now()),
( '0073', '0113', 'fisdba', now()),
( '0073', '0104', 'fisdba', now()),
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

( 3, '0101', 'Q101', 'Aggregate blocks Opening Stock (Dense Aggregate)', 1, 'NUMERIC', '', 'fisdba', now() ),
( 3, '0111', 'Q111', 'Aggregate blocks Opening Stock (Lightweight Aggregate)', 2, 'NUMERIC', '', 'fisdba', now() ),
( 3, '0102', 'Q102', 'Aggregate blocks Total Production during month (Dense Aggregate)', 3, 'NUMERIC', '', 'fisdba', now() ),
( 3, '0112', 'Q112', 'Aggregate blocks Total Production during month (Lightweight Aggregate)', 4, 'NUMERIC', '', 'fisdba', now() ),
( 3, '0103', 'Q103', 'Aggregate blocks Total deliveries during month (Dense Aggregate)', 5, 'NUMERIC', '', 'fisdba', now() ),
( 3, '0113', 'Q113', 'Aggregate blocks Total deliveries during month (Lightweight Aggregate)', 6, 'NUMERIC', '', 'fisdba', now() ),
( 3, '0104', 'Q104', 'Aggregate blocks Closing Stock (Dense Aggregate)', 7, 'NUMERIC', '', 'fisdba', now() ),
( 3, '0114', 'Q114', 'Aggregate blocks Closing Stock (Lightweight Aggregate)', 8, 'NUMERIC', '', 'fisdba', now() ),
( 3, '0121', 'Q121', 'Aerated blocks Opening Stock', 9, 'NUMERIC', '', 'fisdba', now() ),
( 3, '0122', 'Q122', 'Aerated blocks Total production during month', 10, 'NUMERIC', '', 'fisdba', now() ),
( 3, '0123', 'Q123', 'Aerated blocks Total deliveries during month', 11, 'NUMERIC', '', 'fisdba', now() ),
( 3, '0124', 'Q124', 'Aerated blocks Closing Stock', 12, 'NUMERIC', '', 'fisdba', now() ),
( 3, '0145', 'Q145', 'New works brought into use since date of last return', 13, 'NUMERIC', '', 'fisdba', now() ),
( 3, '0146', 'Q146', 'Comment on the figures included in your return', 14, 'TICKBOX-Yes', '', 'fisdba', now() );

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

(   '49900138556', '201903', '0073', 3, 'Dispatched', now(), '0004', 'T', '70110', '70110', '41100', '41100', 750, 748, 100, 100, 100, 100, 99999, 99999, '9900138556', '2967466849', 1, 'S', '326935020502', '2135632144542', '97395797', 178, 0, 0, '1', 'E', 'NP', '20/08/2001', 'Walker-Tucker', 'Jones, Gibbons and Hall', '536 Kaur plaza, East Harry, Wales', 'L2T 0PR', 'Sole Trader', 'Malcolm Bryant', '01633 5551234', '', 'P', '', 'fisdba', now() ),
(   '49900189484', '201903', '0073', 3, 'Dispatched', now(), '0004', 'T', '70110', '70110', '41100', '41100', 25, 25, 22, 22, 22, 22, 12345, 12345, '9900189484', '2905627610', 1, 'S', '423279595848', '9446786207965', '55841012', 71, 0, 0, '1', 'E', 'BS', '16/05/1993', 'Spencer Ltd', 'Quinn Group', '7 Marc shoal, Denisfort, Wales', 'N60 6TL', 'Sole Trader', 'Abdul Stevens', '0117 9555123', '', 'P', '', 'fisdba', now() ),
(   '49900190211', '201903', '0073', 3, 'Dispatched', now(), '0004', 'F', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900190211', '2981901571', 1, 'S', '979024265812', '3101057635557', '74239110', 2, 0, 0, '1', 'E', 'CF', '08/11/2018', 'Holloway and Sons', 'Hammond and Sons', '14 Ellis passage, Watershaven, Scotland', 'L8 9QE', 'Franchise', 'Sharon Hawkins', '029 20555123', '', 'P', '', 'fisdba', now() ),
(   '49900190505', '201903', '0073', 3, 'Dispatched', now(), '0004', 'S', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900190505', '2930251417', 1, 'S', '650195077639', '5864180611950', '94403544', 7, 1, 0, '1', 'E', 'CF', '29/06/2005', 'Harvey-Perkins', 'Moran, Wood and Arnold', '690 Ford keys, Kellyhaven, England', 'CM4B 6UR', '', 'Kate ODonnell', '01633 5559912', '', 'P', '', 'fisdba', now() ),
(   '49900228645', '201903', '0073', 3, 'Dispatched', now(), '0004', 'M', '70110', '70110', '41100', '41100', 750, 748, 100, 100, 100, 100, 99999, 99999, '9900228645', '2902674255', 1, 'S', '898038558701', '2690058876978', '69059744', 6, 1, 0, '1', 'E', 'NP', '08/08/2012', 'Khan-Jackson', 'Potter Group', '33 Roberts tunnel, Newport, UK', 'NP10 1AA', '', 'Josephine Reid', '01633 5551234', '', 'P', '', 'fisdba', now() ),

(   '49900138556', '201906', '0073', 3, 'Dispatched', now(), '0004', 'T', '70110', '70110', '41100', '41100', 750, 748, 100, 100, 100, 100, 99999, 99999, '9900138556', '2967466849', 1, 'S', '326935020502', '2135632144542', '97395797', 178, 0, 0, '1', 'E', 'NP', '20/08/2001', 'Walker-Tucker', 'Jones, Gibbons and Hall', '536 Kaur plaza, East Harry, Wales', 'L2T 0PR', 'Sole Trader', 'Malcolm Bryant', '01633 5551234', '', 'P', '', 'fisdba', now() ),
(   '49900189484', '201906', '0073', 3, 'Dispatched', now(), '0004', 'T', '70110', '70110', '41100', '41100', 25, 25, 22, 22, 22, 22, 12345, 12345, '9900189484', '2905627610', 1, 'S', '423279595848', '9446786207965', '55841012', 71, 0, 0, '1', 'E', 'BS', '16/05/1993', 'Spencer Ltd', 'Quinn Group', '7 Marc shoal, Denisfort, Wales', 'N60 6TL', 'Sole Trader', 'Abdul Stevens', '0117 9555123', '', 'P', '', 'fisdba', now() ),
(   '49900190211', '201906', '0073', 3, 'Dispatched', now(), '0004', 'F', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900190211', '2981901571', 1, 'S', '979024265812', '3101057635557', '74239110', 2, 0, 0, '1', 'E', 'CF', '08/11/2018', 'Holloway and Sons', 'Hammond and Sons', '14 Ellis passage, Watershaven, Scotland', 'L8 9QE', 'Franchise', 'Sharon Hawkins', '029 20555123', '', 'P', '', 'fisdba', now() ),
(   '49900190505', '201906', '0073', 3, 'Dispatched', now(), '0004', 'S', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900190505', '2930251417', 1, 'S', '650195077639', '5864180611950', '94403544', 7, 1, 0, '1', 'E', 'CF', '29/06/2005', 'Harvey-Perkins', 'Moran, Wood and Arnold', '690 Ford keys, Kellyhaven, England', 'CM4B 6UR', '', 'Kate ODonnell', '01633 5559912', '', 'P', '', 'fisdba', now() ),
(   '49900228645', '201906', '0073', 3, 'Dispatched', now(), '0004', 'M', '70110', '70110', '41100', '41100', 750, 748, 100, 100, 100, 100, 99999, 99999, '9900228645', '2902674255', 1, 'S', '898038558701', '2690058876978', '69059744', 6, 1, 0, '1', 'E', 'NP', '08/08/2012', 'Khan-Jackson', 'Potter Group', '33 Roberts tunnel, Newport, UK', 'NP10 1AA', '', 'Josephine Reid', '01633 5551234', '', 'P', '', 'fisdba', now() );


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
    (7310,3,'POPM','0601','0','W',current_user,now()),
    (7320,3,'POPZC','0602','0','E',current_user,now()),
    (7330,3,'VP','0147','0','E',current_user,now()),
    (7340,3,'POPQVQ','0101','0','W',current_user,now()),
    (7350,3,'QVDQ','0608','0','W',current_user,now());


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
( 7310, 'Default', 'Default', 'question', '0601', 'response', 0, current_user, now() ),
( 7310, 'Default', 'Default', 'comparison_question', '0601', 'response', 1, current_user, now() ),
( 7310, 'Default', 'Default', 'threshold', '20000', '', 0, current_user, now() ),

( 7320, 'Default', 'Default', 'question', '0602', 'response', 0, current_user, now() ),
( 7320, 'Default', 'Default', 'comparison_question', '0602', 'response', 1, current_user, now() ),
( 7320, 'Default', 'Default', 'threshold', '0', '', 0, current_user, now() ),

( 7330, 'Default', 'Default', 'question', '0147', 'response', 0, current_user, now() ),

( 7340, 'Default', 'Default', 'question', '0608', 'response', 0, current_user, now() ),
( 7340, 'Default', 'Default', 'comparison_question', '9001', 'response', 0, current_user, now() );

( 7350, 'Default', 'Default', 'question', '0101', 'response', 0, current_user, now() ),
( 7350, 'Default', 'Default', 'comparison_question', '0101', 'response', 1, current_user, now() );
