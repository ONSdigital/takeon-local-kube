Insert Into dev01.Survey
(
    survey,
    description,
    periodicity,
    CreatedBy,
    CreatedDate
)
Values

( '0074','Monthly Survey of Bricks','Quarterly','fisdba', now() );

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
( 4, '0074', 'Monthly Survey of Bricks', '201803', '999912','fisdba', now() );

Insert Into dev01.Question
(
    Survey,
    QuestionCode,
    CreatedBy,
    CreatedDate
)
Values

( '0074', '0301', 'fisdba', now()),
( '0074', '0311', 'fisdba', now()),
( '0074', '0321', 'fisdba', now()),
( '0074', '0501', 'fisdba', now()),
( '0074', '0302', 'fisdba', now()),
( '0074', '0312', 'fisdba', now()),
( '0074', '0322', 'fisdba', now()),
( '0074', '0502', 'fisdba', now()),
( '0074', '0303', 'fisdba', now()),
( '0074', '0313', 'fisdba', now()),
( '0074', '0323', 'fisdba', now()),
( '0074', '0503', 'fisdba', now()),
( '0074', '0304', 'fisdba', now()),
( '0074', '0314', 'fisdba', now()),
( '0074', '0324', 'fisdba', now()),
( '0074', '0504', 'fisdba', now()),
( '0074', '0145', 'fisdba', now()),
( '0074', '0146', 'fisdba', now());


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

( 4, '0301', 'Q301', 'Opening Stock Commons', 1, 'NUMERIC', '', 'fisdba', now() ),
( 4, '0311', 'Q311', 'Opening Stock Facings', 2, 'NUMERIC', '', 'fisdba', now() ),
( 4, '0321', 'Q321', 'Opening Stock Engineering', 3, 'NUMERIC', '', 'fisdba', now() ),
( 4, '0501', 'Q501', 'Total opening Stock', 4, 'NUMERIC', '', 'fisdba', now() ),
( 4, '0302', 'Q302', 'Drawn from kiln during month Commons', 5, 'NUMERIC', '', 'fisdba', now() ),
( 4, '0312', 'Q312', 'Drawn from kiln during month Facings', 6, 'NUMERIC', '', 'fisdba', now() ),
( 4, '0322', 'Q322', 'Drawn from kiln during month Engineering', 7, 'NUMERIC', '', 'fisdba', now() ),
( 4, '0502', 'Q502', 'Total drawn from kiln during month', 8, 'NUMERIC', '', 'fisdba', now() ),
( 4, '0303', 'Q303', 'Deliveries to customer during month Commons', 9, 'NUMERIC', '', 'fisdba', now() ),
( 4, '0313', 'Q313', 'Deliveries to customer during month Facings', 10, 'NUMERIC', '', 'fisdba', now() ),
( 4, '0323', 'Q323', 'Deliveries to customer during month Engineering', 11, 'NUMERIC', '', 'fisdba', now() ),
( 4, '0503', 'Q503', 'Total deliveries to customer during month', 12, 'NUMERIC', '', 'fisdba', now() ),
( 4, '0304', 'Q304', 'Closing Stock Commons', 13, 'NUMERIC', '', 'fisdba', now() ),
( 4, '0314', 'Q314', 'Closing Stock Facings', 14, 'NUMERIC', '', 'fisdba', now() ),
( 4, '0324', 'Q324', 'Closing Stock Engineering', 15, 'NUMERIC', '', 'fisdba', now() ),
( 4, '0504', 'Q504', 'Total Closing Stock', 16, 'NUMERIC', '', 'fisdba', now() ),
( 4, '0145', 'Q145', 'New works brought into use since date of last return', 17, 'NUMERIC', '', 'fisdba', now() ),
( 4, '0146', 'Q146', 'Comment on the figures included in your return', 18, 'TICKBOX-Yes', '', 'fisdba', now() );

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

(   '49900229065', '201903', '0074', 4, 'Dispatched', now(), '0004', 'T', '70110', '70110', '41100', '41100', 750, 748, 100, 100, 100, 100, 99999, 99999, '9900229065', '2993511516', 1, 'S', '326935020502', '2135632144542', '97395797', 178, 0, 0, '1', 'E', 'NP', '07/08/2019', 'Jones, Banks and Hall', 'Bell LLC', '9 Thompson drive, East Harry, Wales', 'L2T 0PR', 'Sole Trader', 'Dennis Edwards', '01633 5551234', '', 'P', '', 'fisdba', now() ),
(   '49900356828', '201903', '0074', 4, 'Dispatched', now(), '0004', 'T', '70110', '70110', '41100', '41100', 25, 25, 22, 22, 22, 22, 12345, 12345, '9900356828', '2921377360', 1, 'S', '423279595848', '9446786207965', '55841012', 71, 0, 0, '1', 'E', 'BS', '21/03/2019', 'Hunter, Coles and Turnbull', 'Savage, Parkinson and Wright', '526 Amber estates, Denisfort, Wales', 'N60 6TL', 'Sole Trader', 'Jacob Thorpe', '0117 9555123', '', 'P', '', 'fisdba', now() ),
(   '49900423293', '201903', '0074', 4, 'Dispatched', now(), '0004', 'F', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900423293', '2962684174', 1, 'S', '979024265812', '3101057635557', '74239110', 2, 0, 0, '1', 'E', 'CF', '06/09/1995', 'Curtis LLC', 'Ford PLC', '36 Giles corners, Watershaven, Scotland', 'L8 9QE', 'Franchise', 'Gillian Bailey', '029 20555123', '', 'P', '', 'fisdba', now() ),
(   '49900423920', '201903', '0074', 4, 'Dispatched', now(), '0004', 'S', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900423920', '2993702519', 1, 'S', '650195077639', '5864180611950', '94403544', 7, 1, 0, '1', 'E', 'CF', '19/03/1973', 'Wilson-Chapman', 'Jones LLC', '2 Brown keys, Kellyhaven, England', 'CM4B 6UR', '', 'Anthony Wilson', '01633 5559912', '', 'P', '', 'fisdba', now() ),
(   '49900449878', '201903', '0074', 4, 'Dispatched', now(), '0004', 'M', '70110', '70110', '41100', '41100', 750, 748, 100, 100, 100, 100, 99999, 99999, '9900449878', '2910550332', 1, 'S', '898038558701', '2690058876978', '69059744', 6, 1, 0, '1', 'E', 'NP', '31/01/1977', 'Barrett Group', 'Hutchinson, Daly and Pritchard', '17 Evans junction, Newport, UK', 'NP10 1AA', '', 'Arthur Knowles-Gallagher', '01633 5551234', '', 'P', '', 'fisdba', now() ),

(   '49900229065', '201906', '0074', 4, 'Dispatched', now(), '0004', 'T', '70110', '70110', '41100', '41100', 750, 748, 100, 100, 100, 100, 99999, 99999, '9900229065', '2993511516', 1, 'S', '326935020502', '2135632144542', '97395797', 178, 0, 0, '1', 'E', 'NP', '07/08/2019', 'Jones, Banks and Hall', 'Bell LLC', '9 Thompson drive, East Harry, Wales', 'L2T 0PR', 'Sole Trader', 'Dennis Edwards', '01633 5551234', '', 'P', '', 'fisdba', now() ),
(   '49900356828', '201906', '0074', 4, 'Dispatched', now(), '0004', 'T', '70110', '70110', '41100', '41100', 25, 25, 22, 22, 22, 22, 12345, 12345, '9900356828', '2921377360', 1, 'S', '423279595848', '9446786207965', '55841012', 71, 0, 0, '1', 'E', 'BS', '21/03/2019', 'Hunter, Coles and Turnbull', 'Savage, Parkinson and Wright', '526 Amber estates, Denisfort, Wales', 'N60 6TL', 'Sole Trader', 'Jacob Thorpe', '0117 9555123', '', 'P', '', 'fisdba', now() ),
(   '49900423293', '201906', '0074', 4, 'Dispatched', now(), '0004', 'F', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900423293', '2962684174', 1, 'S', '979024265812', '3101057635557', '74239110', 2, 0, 0, '1', 'E', 'CF', '06/09/1995', 'Curtis LLC', 'Ford PLC', '36 Giles corners, Watershaven, Scotland', 'L8 9QE', 'Franchise', 'Gillian Bailey', '029 20555123', '', 'P', '', 'fisdba', now() ),
(   '49900423920', '201906', '0074', 4, 'Dispatched', now(), '0004', 'S', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900423920', '2993702519', 1, 'S', '650195077639', '5864180611950', '94403544', 7, 1, 0, '1', 'E', 'CF', '19/03/1973', 'Wilson-Chapman', 'Jones LLC', '2 Brown keys, Kellyhaven, England', 'CM4B 6UR', '', 'Anthony Wilson', '01633 5559912', '', 'P', '', 'fisdba', now() ),
(   '49900449878', '201906', '0074', 4, 'Dispatched', now(), '0004', 'M', '70110', '70110', '41100', '41100', 750, 748, 100, 100, 100, 100, 99999, 99999, '9900449878', '2910550332', 1, 'S', '898038558701', '2690058876978', '69059744', 6, 1, 0, '1', 'E', 'NP', '31/01/1977', 'Barrett Group', 'Hutchinson, Daly and Pritchard', '17 Evans junction, Newport, UK', 'NP10 1AA', '', 'Arthur Knowles-Gallagher', '01633 5551234', '', 'P', '', 'fisdba', now() );


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
    (7410,4,'POPM','0601','0','W',current_user,now()),
    (7420,4,'POPZC','0602','0','E',current_user,now()),
    (7430,4,'VP','0147','0','E',current_user,now()),
    (7440,4,'QVDQ','0608','0','W',current_user,now());


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
( 7410, 'Default', 'Default', 'question', '0601', 'response', 0, current_user, now() ),
( 7410, 'Default', 'Default', 'comparison_question', '0601', 'response', 1, current_user, now() ),
( 7410, 'Default', 'Default', 'threshold', '20000', '', 0, current_user, now() ),

( 7420, 'Default', 'Default', 'question', '0602', 'response', 0, current_user, now() ),
( 7420, 'Default', 'Default', 'comparison_question', '0602', 'response', 1, current_user, now() ),
( 7420, 'Default', 'Default', 'threshold', '0', '', 0, current_user, now() ),

( 7430, 'Default', 'Default', 'question', '0147', 'response', 0, current_user, now() ),

( 7440, 'Default', 'Default', 'question', '0608', 'response', 0, current_user, now() ),
( 7440, 'Default', 'Default', 'comparison_question', '9001', 'response', 0, current_user, now() );
