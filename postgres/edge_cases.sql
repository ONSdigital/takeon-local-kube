/*
Nature of the test data.

3 generic surveys
999A - Monthly
999B - Quarterly
999C - Annual

1 Form definition (Linked to the monthly survey)
This for has multiple questions defined:
    2 numeric
    2 derived
    1 tickbox/checkbox
    1 text
*/


\c validationdb;

Insert Into dev01.Survey
(
    survey,
    description,
    periodicity,
    CreatedBy,
    CreatedDate
)
Values

( '999A','Generic Monthly Testing Survey','Monthly','fisdba', now() ),
( '999B','Generic Quarterly Testing Survey','Quarterly','fisdba', now() ),
( '999C','Generic Annual Testing Survey','Annual','fisdba', now() );



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
( 1, '999A', 'Monthly Test Form', '199901', '999912','fisdba', now() );


Insert Into dev01.Question
(
    Survey,
    QuestionCode,
    CreatedBy,
    CreatedDate
)
Values
( '999A', '1000', 'fisdba', 'now'),
( '999A', '1001', 'fisdba', 'now'),
( '999A', '2000', 'fisdba', 'now'),
( '999A', '3000', 'fisdba', 'now'),
( '999A', '4000', 'fisdba', 'now'),
( '999A', '4001', 'fisdba', 'now');


-- Insert Into dev01.FormDefinition
-- (
--     FormID                  serial References dev01.Form(FormID),
--     QuestionCode            Varchar(8) Not Null,
--     DisplayQuestionNumber   Varchar(16) Not Null,
--     DisplayText             Varchar(128) Not Null,
--     DisplayOrder            Integer Not Null,
--     Type                    Varchar(16) Not Null,
--     DerivedFormula          Varchar(128) Not Null,
--     CreatedBy               Varchar(16) Not Null,
--     CreatedDate             timestamptz Not Null,
--     LastUpdatedBy           Varchar(16),
--     LastUpdatedDate         timestamptz,


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
( 1, '1000', 'Q1', 'This is a numeric question', 1, 'NUMERIC', '', 'fisdba', now() ),
( 1, '1001', 'Q2', 'This is another numeric question', 1, 'NUMERIC', '', 'fisdba', now() ),
( 1, '2000', 'Q3', 'This is a checkbox question', 1, 'TICKBOX-Yes', '', 'fisdba', now() ),
( 1, '3000', 'Q4', 'This is a text question', 1, 'Text', '', 'fisdba', now() ),
( 1, '4000', 'Q5', 'This is a postive derived question', 1, 'NUMERIC', '1000 + 1001', 'fisdba', now() ),
( 1, '4001', 'Q6', 'This is a subtracted derived question', 1, 'NUMERIC', '1000 - 1001', 'fisdba', now() );


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
    NumberLivePaye              ,
    LegalStatus                ,
    ReportingUnitMarker        ,
    Region                     ,
    BirthDate                  ,
    EnterpriseName              ,
    ReferenceName               ,
    ReferenceAddress            ,
    ReferencePostcode          ,
    TradingStyle                ,
    Contact                     ,
    Telephone                   ,
    Fax                         ,
    SelectionType              ,
    InclusionExclusion          ,
    CreatedBy                   ,
    CreatedDate                ,
    LockedBy
)
Values
(   '12345678000', '201801', '999A', 1, 'Status', 'now', '', '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 'S', '', '', '', 0, 0, 0, '', '', '', '', '', 'Empty Form', '', '', '', '', '', '', '', '', 'fisdba', now(), '' ),
(   '12345678001', '201801', '999A', 1, 'Status', 'now', '', '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 'S', '', '', '', 0, 0, 0, '', '', '', '', '', 'Value Present (values exist) - 4 Triggered', '', '', '', '', '', '', '', '', 'fisdba', now(), '' ),
(   '12345678002', '201801', '999A', 1, 'Status', 'now', '', '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 'S', '', '', '', 0, 0, 0, '', '', '', '', '', 'Value Present (values all blank) - 0 Triggered', '', '', '', '', '', '', '', '', 'fisdba', now(), '' ),
(   '12345678003', '201801', '999A', 1, 'Status', 'now', '', '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 'S', '', '', '', 0, 0, 0, '', '', '', '', '', 'Value Present (values missing) - 0 Triggered', '', '', '', '', '', '', '', '', 'fisdba', now(), '' ),
(   '12345678010', '201801', '999A', 1, 'Status', 'now', '', '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 'S', '', '', '', 0, 0, 0, '', '', '', '', '', 'PoPM (pervious period is missing) - Not Triggered', '', '', '', '', '', '', '', '', 'fisdba', now(), '' ),
(   '12345678011', '201801', '999A', 1, 'Status', 'now', '', '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 'S', '', '', '', 0, 0, 0, '', '', '', '', '', 'PoPM (Current period is blank) - Not Triggered', '', '', '', '', '', '', '', '', 'fisdba', now(), '' ),
(   '12345678011', '201712', '999A', 1, 'Status', 'now', '', '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 'S', '', '', '', 0, 0, 0, '', '', '', '', '', 'PoPM (Current period is blank) - Not Triggered', '', '', '', '', '', '', '', '', 'fisdba', now(), '' ),
(   '12345678012', '201801', '999A', 1, 'Status', 'now', '', '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 'S', '', '', '', 0, 0, 0, '', '', '', '', '', 'PoPM (Current period larger than previous) - Not Triggered', '', '', '', '', '', '', '', '', 'fisdba', now(), '' ),
(   '12345678012', '201712', '999A', 1, 'Status', 'now', '', '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 'S', '', '', '', 0, 0, 0, '', '', '', '', '', 'PoPM (Current period is blank) - Not Triggered', '', '', '', '', '', '', '', '', 'fisdba', now(), '' ),
(   '12345678013', '201801', '999A', 1, 'Status', 'now', '', '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 'S', '', '', '', 0, 0, 0, '', '', '', '', '', 'PoPM (Current period larger than previous) - Not Triggered', '', '', '', '', '', '', '', '', 'fisdba', now(), '' ),
(   '12345678013', '201712', '999A', 1, 'Status', 'now', '', '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 'S', '', '', '', 0, 0, 0, '', '', '', '', '', 'PoPM (Current period is blank) - Not Triggered', '', '', '', '', '', '', '', '', 'fisdba', now(), '' ),
(   '12345678020', '201801', '999A', 1, 'Status', 'now', '', '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 'S', '', '', '', 0, 0, 0, '', '', '', '', '', 'PoPZC (Current period, previous period, and threshold are all zero)', '', '', '', '', '', '', '', '', 'fisdba', now(), '' ),
(   '12345678020', '201712', '999A', 1, 'Status', 'now', '', '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 'S', '', '', '', 0, 0, 0, '', '', '', '', '', 'PoPZC (Current period, previous period, and threshold are all zero) - Not Triggered', '', '', '', '', '', '', '', '', 'fisdba', now(), '' ),
(   '12345678021', '201801', '999A', 1, 'Status', 'now', '', '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 'S', '', '', '', 0, 0, 0, '', '', '', '', '', 'PoZC (Current period is 0 and previous period > 0 but less than threshold) - Not Triggered', '', '', '', '', '', '', '', '', 'fisdba', now(), '' ),
(   '12345678021', '201712', '999A', 1, 'Status', 'now', '', '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 'S', '', '', '', 0, 0, 0, '', '', '', '', '', 'PoZC (Current period is 0 and previous period > 0 but less than threshold) - Not Triggered', '', '', '', '', '', '', '', '', 'fisdba', now(), '' ),
(   '12345678022', '201801', '999A', 1, 'Status', 'now', '', '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 'S', '', '', '', 0, 0, 0, '', '', '', '', '', 'PoZC (Current period is > 0 but less than threshold and previous period = 0 ) - Not Triggered', '', '', '', '', '', '', '', '', 'fisdba', now(), '' ),
(   '12345678022', '201712', '999A', 1, 'Status', 'now', '', '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 'S', '', '', '', 0, 0, 0, '', '', '', '', '', 'PoZC (Current period is > 0 but less than threshold and previous period = 0 ) - Not Triggered', '', '', '', '', '', '', '', '', 'fisdba', now(), '' ),
(   '12345678023', '201801', '999A', 1, 'Status', 'now', '', '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 'S', '', '', '', 0, 0, 0, '', '', '', '', '', 'PoZC (Current period is blank and previous period > 0 and greater than threshold ) -  Triggered', '', '', '', '', '', '', '', '', 'fisdba', now(), '' ),
(   '12345678023', '201712', '999A', 1, 'Status', 'now', '', '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 'S', '', '', '', 0, 0, 0, '', '', '', '', '', 'PoZC (Current period is blank and previous period > 0 and greater than threshold ) -  Triggered', '', '', '', '', '', '', '', '', 'fisdba', now(), '' ),
(   '12345678024', '201801', '999A', 1, 'Status', 'now', '', '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 'S', '', '', '', 0, 0, 0, '', '', '', '', '', 'PoZC (Current period is > 0 and greater than threshold and previous period is blank ) -  Triggered', '', '', '', '', '', '', '', '', 'fisdba', now(), '' ),
(   '12345678024', '201712', '999A', 1, 'Status', 'now', '', '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 'S', '', '', '', 0, 0, 0, '', '', '', '', '', 'PoZC (Current period is > 0 and greater than threshold and previous period is blank ) -  Triggered', '', '', '', '', '', '', '', '', 'fisdba', now(), '' ),
(   '12345678025', '201801', '999A', 1, 'Status', 'now', '', '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 'S', '', '', '', 0, 0, 0, '', '', '', '', '', 'PoZC (Current and previous periods > 0 and diff is > threshold) -  Not Triggered', '', '', '', '', '', '', '', '', 'fisdba', now(), '' ),
(   '12345678026', '201801', '999A', 1, 'Status', 'now', '', '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 'S', '', '', '', 0, 0, 0, '', '', '', '', '', 'PoZC (Current and previous periods > 0 and diff is > threshold) -  Not Triggered', '', '', '', '', '', '', '', '', 'fisdba', now(), '' ),
(   '12345678026', '201712', '999A', 1, 'Status', 'now', '', '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 'S', '', '', '', 0, 0, 0, '', '', '', '', '', 'PoZC (Current and previous periods > 0 and diff is > threshold) -  Not Triggered', '', '', '', '', '', '', '', '', 'fisdba', now(), '' ),
(   '12345678030', '201801', '999A', 1, 'Status', 'now', '', '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 'S', '', '', '', 0, 0, 0, '', '', '', '', '', 'QVDQ (both q and dq are 0) - Not Triggered', '', '', '', '', '', '', '', '', 'fisdba', now(), '' ),
(   '12345678031', '201801', '999A', 1, 'Status', 'now', '', '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 'S', '', '', '', 0, 0, 0, '', '', '', '', '', 'QVDQ (both q and dq > 0 and Question != derived question) - Triggered', '', '', '', '', '', '', '', '', 'fisdba', now(), '' ),
(   '12345678032', '201801', '999A', 1, 'Status', 'now', '', '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 'S', '', '', '', 0, 0, 0, '', '', '', '', '', 'QVDQ (QVDQ q is blank and dq is > 0) - Triggered', '', '', '', '', '', '', '', '', 'fisdba', now(), '' ),
(   '12345678033', '201801', '999A', 1, 'Status', 'now', '', '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 'S', '', '', '', 0, 0, 0, '', '', '', '', '', 'QVDQ (q doesnt exist while dq > 0) - Triggered', '', '', '', '', '', '', '', '', 'fisdba', now(), '' ),
(   '12345678034', '201801', '999A', 1, 'Status', 'now', '', '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 'S', '', '', '', 0, 0, 0, '', '', '', '', '', 'QVDQ (both q and dq are blank) - Not Triggered', '', '', '', '', '', '', '', '', 'fisdba', now(), '' ),
(   '12345678035', '201801', '999A', 1, 'Status', 'now', '', '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 'S', '', '', '', 0, 0, 0, '', '', '', '', '', 'QVDQ (both q and dq dont exist) - Not Triggered', '', '', '', '', '', '', '', '', 'fisdba', now(), '' );





Insert Into dev01.response
(
    Reference,
    Period,
    Survey,
    QuestionCode,
    Instance,
    Response,
    CreatedBy,
    CreatedDate
)
Values
    ( '12345678001','201801','999A','4001',0,'19',current_user,now()),
    ( '12345678001','201801','999A','4000',0,'21',current_user,now()),
    ( '12345678001','201801','999A','3000',0,'Rhubarb',current_user,now()),
    ( '12345678001','201801','999A','2000',0,'1',current_user,now()),
    ( '12345678001','201801','999A','1000',0,'20',current_user,now()),
    ( '12345678001','201801','999A','1001',0,'1',current_user,now()),

    ( '12345678002','201801','999A','4001',0,'',current_user,now()),
    ( '12345678002','201801','999A','4000',0,'',current_user,now()),
    ( '12345678002','201801','999A','3000',0,'',current_user,now()),
    ( '12345678002','201801','999A','2000',0,'',current_user,now()),
    ( '12345678002','201801','999A','1000',0,'',current_user,now()),
    ( '12345678002','201801','999A','1001',0,'',current_user,now()),
    
    ( '12345678003','201801','999A','4001',0,'0',current_user,now()),
    ( '12345678003','201801','999A','1001',0,'',current_user,now()),


    -- POPM: Missing previous period
    ( '12345678010','201801','999A','1000',0,'20',current_user,now()),
    ( '12345678010','201801','999A','1001',0,'1',current_user,now()),
    
    --( '12345678010','201712','999B','1000',0,'20',current_user,now()),
    --( '12345678010','201712','999B','1001',0,'1',current_user,now()),

    -- POPM: Blank current period
    ( '12345678011','201801','999A','1000',0,'',current_user,now()),
    ( '12345678011','201801','999A','1001',0,'',current_user,now()),

    ( '12345678011','201712','999A','1000',0,'20',current_user,now()),
    ( '12345678011','201712','999A','1001',0,'1',current_user,now()),

    -- POPM: Current period larger than current
    ( '12345678012','201801','999A','1000',0,'30',current_user,now()),
    ( '12345678012','201801','999A','1001',0,'1',current_user,now()),

    ( '12345678012','201712','999A','1000',0,'20',current_user,now()),
    ( '12345678012','201712','999A','1001',0,'1',current_user,now()),

    -- POPM: Previous  period larger than current
    ( '12345678013','201801','999A','1000',0,'10',current_user,now()),
    ( '12345678013','201801','999A','1001',0,'1',current_user,now()),

    ( '12345678013','201712','999A','1000',0,'20',current_user,now()),
    ( '12345678013','201712','999A','1001',0,'1',current_user,now()),

    --PoPZC: Everything is zero
    ( '12345678020','201801','999A','1001',0,'0',current_user,now()),
    ( '12345678020','201712','999A','1001',0,'0',current_user,now()),

    --PoPZC Current period is 0, previous period > 0 and diff is less than threshold
    ( '12345678021','201801','999A','1000',0,'0',current_user,now()),
    ( '12345678021','201712','999A','1001',0,'29000',current_user,now()),  

    --PoPZC Current period is > 0, previous period is 0 and diff is less than threshold
    ( '12345678022','201801','999A','1000',0,'29000',current_user,now()),
    ( '12345678022','201712','999A','1001',0,'0',current_user,now()),

    --PoPZC Current period is blank, previous period is > 0 and greater than threshold
    ( '12345678023','201801','999A','1000',0,'',current_user,now()),
    ( '12345678023','201712','999A','1001',0,'31000',current_user,now()),

   --PoPZC Current period is > 0  and greater than threshold, previous period is blank 
    ( '12345678024','201801','999A','1000',0,'31000',current_user,now()),
    ( '12345678024','201712','999A','1001',0,'',current_user,now()),

    --PoPZC Current period is > 0 and greater than threshold, pervious period doesn't exist
    ( '12345678025','201801','999A','1000',0,'31000',current_user,now()),

    --PoPZC Current and previous period > 0 and diff > threshold
    ( '12345678026','201801','999A','1000',0,'31000',current_user,now()),
    ( '12345678026','201712','999A','1001',0,'100',current_user,now()),

    --QVDQ Question and derived Question = 0
    ( '12345678030','201801','999A','1000',0,'0',current_user,now()),
    ( '12345678030','201801','999A','1001',0,'0',current_user,now()),

    --QVDQ both q and dq > 0 and Question != derived question
    ( '12345678031','201801','999A','1000',0,'20',current_user,now()),
    ( '12345678031','201801','999A','1001',0,'10',current_user,now()),

    --QVDQ q is blank and dq is > 0
    ( '12345678032','201801','999A','1000',0,'',current_user,now()),
    ( '12345678032','201801','999A','1001',0,'10',current_user,now()),

    --QVDQ q doesn't exist while dq > 0
    ( '12345678033','201801','999A','1001',0,'10',current_user,now()),  

    --QVDQ q and dq are blank
    ( '12345678034','201801','999A','1000',0,'',current_user,now()),
    ( '12345678034','201801','999A','1001',0,'',current_user,now());


-- Create table dev01.ValidationRule
-- (
--     Rule            Varchar(16) Primary Key,
--     Name            Varchar(32) Not Null,
--     BaseFormula     Varchar(1024) Not Null,
--     CreatedBy       Varchar(16) Not Null,
--     CreatedDate     timestamptz Not Null,
--     LastUpdatedBy   Varchar(16),
--     LastUpdatedDate timestamptz
-- );

Insert Into dev01.ValidationRule
(
    Rule,
    Name,
    BaseFormula,
    CreatedBy,
    CreatedDate
)
Values
( 'VP','Value Present','question != ""',current_user,now()),
( 'POPM','Period on Period Movement','abs(question - comparison_question) > threshold AND question > 0 AND comparison_question > 0',current_user,now()),
( 'POPZC','Period on Period Zero Continuity','question != comparison_question AND ( question = 0 OR comparison_question = 0 ) AND abs(question - comparison_question) > Threshold',current_user,now()),
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


-- Create table dev01.ValidationForm
-- (
--     ValidationID            serial Primary Key,
--     FormID                  Int References dev01.Form(FormID),
--     Rule                    Varchar(16) References dev01.ValidationRule(Rule),
--     PrimaryQuestion         Varchar(4) Not Null,
--     DefaultValue            Varchar(8) Not Null,
--     Severity                Varchar(16) Not Null,
--     CreatedBy               Varchar(16) Not Null,
--     CreatedDate             timestamptz Not Null,
--     LastUpdatedBy           Varchar(16),
--     LastUpdatedDate         timestamptz
-- );
-- Create Index idx_validationform_formrule On dev01.ValidationForm(FormID,Rule);
-- Create Index idx_validationform_question On dev01.ValidationForm(PrimaryQuestion);

Insert Into dev01.ValidationAttribute
(
    AttributeName,
    Source,
    CreatedBy,
    CreatedDate
)
Values
('Default', 'Default', 'fisdba', now());


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
    (10,1,'VP','3000','','W',current_user,now()),       
    (11,1,'VP','2000','','E',current_user,now()),       
    (12,1,'VP','1000','','W',current_user,now()),       
    (13,1,'VP','4000','','W',current_user,now()),       

    (20,1,'POPM','1000','0','W',current_user,now()),    
    (21,1,'POPM','1001','0','E',current_user,now()),    

    (30,1,'QVDQ','1000','0','W',current_user,now()),    
    (31,1,'QVDQ','1001','0','E',current_user,now()),    

    (40,1,'POPZC','1000','0','W',current_user,now()),   
    (41,1,'POPZC','1001','0','E',current_user,now());


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
( 10, 'Default', 'Default', 'question', '3000', 'response', 0, current_user, now() ),
( 11, 'Default', 'Default', 'question', '2000', 'response', 0, current_user, now() ),
( 12, 'Default', 'Default', 'question', '1000', 'response', 0, current_user, now() ),
( 13, 'Default', 'Default', 'question', '4000', 'response', 0, current_user, now() ),

-- Q1000 (cp) vs Q1000 (pp) with threshold of 20000
( 20, 'Default', 'Default', 'question', '1000', 'response', 0, current_user, now() ),
( 20, 'Default', 'Default', 'comparison_question', '1000', 'response', 1, current_user, now() ),
( 20, 'Default', 'Default', 'threshold', '20000', '', 0, current_user, now() ),

-- Q1001 (cp) vs Q1001 (pp) with threshold of 0
( 21, 'Default', 'Default', 'question', '1001', 'response', 0, current_user, now() ),
( 21, 'Default', 'Default', 'comparison_question', '1001', 'response', 1, current_user, now() ),
( 21, 'Default', 'Default', 'threshold', '0', '', 0, current_user, now() ),

-- Q1000 vs DQ4000
( 30, 'Default', 'Default', 'question', '1000', 'response', 0, current_user, now() ),
( 30, 'Default', 'Default', 'comparison_question', '4000', 'response', 0, current_user, now() ),

-- Q1001 vs DQ4001
( 31, 'Default', 'Default', 'question', '1001', 'response', 0, current_user, now() ),                
( 31, 'Default', 'Default', 'comparison_question', '4001', 'response', 0, current_user, now() ),

( 40, 'Default', 'Default', 'question', '1000', 'response', 0, current_user, now() ),                --# Q1000 (cp) vs Q1000 (pp) with threshold of 30000
( 40, 'Default', 'Default', 'comparison_question', '1000', 'response', 1, current_user, now() ),
( 40, 'Default', 'Default', 'threshold', '30000', '', 0, current_user, now() ),
( 41, 'Default', 'Default', 'question', '1000', 'response', 0, current_user, now() ),                --# Q1001 (cp) vs Q1001 (pp) with threshold of 0
( 41, 'Default', 'Default', 'comparison_question', '1000', 'response', 1, current_user, now() ),
( 41, 'Default', 'Default', 'threshold', '0', '', 0, current_user, now() );

