SET search_path TO dev01,public;

drop function dev01.deleteOutput;
drop function dev01.InsertValidationOutputByArray;
drop function dev01.SaveResponseArray;

drop table dev01.ValidationOutput;
drop table dev01.ValidationParameter;
drop table dev01.ValidationAttribute;
drop table dev01.ValidationForm;
drop table dev01.ValidationPeriod;
drop table dev01.ValidationRule;
drop table dev01.Response;
drop table dev01.Contributor;
drop table dev01.FormDefinition;
drop table dev01.Question;
drop table dev01.Form;
drop table dev01.Survey;


Create Table dev01.Survey
(
    survey              varchar(4) Primary Key,
    description         varchar(128) Not Null,
    periodicity         varchar(32) Not Null,
    CreatedBy           Varchar(16) Not Null,
    CreatedDate         timestamptz Not Null,
    LastUpdatedBy       Varchar(16),
    LastUpdatedDate     timestamptz
);


Create Table dev01.Form
(
    FormID              Serial Primary Key,
    Survey              Varchar(4) References Survey(Survey),
    Description         Varchar(128) Not Null,
    PeriodStart         Varchar(6) Not Null,
    PeriodEnd           Varchar(6) Not Null,
    CreatedBy           Varchar(16) Not Null,
    CreatedDate         timestamptz Not Null,
    LastUpdatedBy       Varchar(16),
    LastUpdatedDate     timestamptz
);


Create Table dev01.Question
(
    Survey              Varchar(4) References Survey(Survey),
    QuestionCode        Varchar(8) Not Null,
    CreatedBy           Varchar(16) Not Null,
    CreatedDate         timestamptz Not Null,
    LastUpdatedBy       Varchar(16),
    LastUpdatedDate     timestamptz,

    Primary Key (Survey, QuestionCode)
);


Create Table dev01.FormDefinition
(
    FormID                  serial References Form(FormID),
    QuestionCode            Varchar(8) Not Null,
    DisplayQuestionNumber   Varchar(16) Not Null,
    DisplayText             Varchar(128) Not Null,
    DisplayOrder            Integer Not Null,
    Type                    Varchar(16) Not Null,
    DerivedFormula          Varchar(128) Not Null,
    CreatedBy               Varchar(16) Not Null,
    CreatedDate             timestamptz Not Null,
    LastUpdatedBy           Varchar(16),
    LastUpdatedDate         timestamptz,

    Primary Key (FormID, QuestionCode)
);
Create Index idx_formdefinition_question On FormDefinition(QuestionCode);


Create Table dev01.Contributor
(
    Reference                   Varchar(11) Not Null,
    Period                      Char(6) Not Null,
    Survey                      Char(4) References Survey(Survey),
    FormID                      Integer References Form(FormID),
    Status                      Varchar(32) Not Null,
    ReceiptDate                 timestamptz,
    LockedBy                    Varchar(16),
    LockedDate                  timestamptz,
    FormType                    Char(4) Not Null,
    Checkletter                 Char(1) Not Null,
    FrozenSicOutdated           Char(5) Not Null,
    RuSicOutdated               Char(5) Not Null,
    FrozenSic                   Char(5) Not Null,
    RuSic                       Char(5) Not Null,
    FrozenEmployees             Decimal(13,0) Not Null,
    Employees                   Decimal(13,0) Not Null,
    FrozenEmployment            Decimal(13,0) Not Null,
    Employment                  Decimal(13,0) Not Null,
    FrozenFteEmployment         Decimal(10,3) Not Null,
    FteEmployment               Decimal(10,3) Not Null,
    FrozenTurnover              Decimal(13,0) Not Null,
    Turnover                    Decimal(13,0) Not Null,
    EnterpriseReference         Char(10) Not Null,
    WowEnterpriseReference      Varchar(10) Not Null,
    CellNumber                  SmallInt Not Null,
    Currency                    Char(1) Not Null,
    VatReference                Varchar(12) Not Null,
    PayeReference               Varchar(13) Not Null,
    CompanyRegistrationNumber   Varchar(8) Not Null,
    NumberLiveLocalUnits        Decimal(6,0) Not Null,
    NumberLiveVat               Decimal(6,0) Not Null,
    NumberLivePaye              Decimal(6,0) Not Null,
    LegalStatus                 Char(1) Not Null,
    ReportingUnitMarker         Char(1) Not Null,
    Region                      Char(2) Not Null,
    BirthDate                   Varchar(16) NULL,
    EnterpriseName              Varchar(107) Not Null,
    ReferenceName               Varchar(107) Not Null,
    ReferenceAddress            Varchar(154) Not Null,
    ReferencePostcode           Varchar(8) Not Null,
    TradingStyle                Varchar(107) Not Null,
    Contact                     Varchar(30) Not Null,
    Telephone                   Varchar(20) Not Null,
    Fax                         Varchar(20) Not Null,
    SelectionType               Char(1) Not Null,
    InclusionExclusion          Char(1) Not Null,
    CreatedBy                   Varchar(16) Not Null,
    CreatedDate                 timestamptz Not Null,
    LastUpdatedBy               Varchar(16),
    LastUpdatedDate             timestamptz,

    Primary Key (reference, period, survey)
);
Create Index idx_contributor_periodsurvey On Contributor(period, survey);
Create Index idx_contributor_surveyreference On Contributor(survey, reference);


Create Table dev01.Response
(
    Reference              Char(11) Not Null,
    Period                 Char(6) Not Null,
    Survey                 Char(4) References Survey(Survey),
    QuestionCode           Char(4) Not Null,
    Instance               Int Not Null,
    Response               Varchar(256) Not Null,
    CreatedBy              Varchar(16) Not Null,
    CreatedDate            timestamptz Not Null,
    LastUpdatedBy          Varchar(16),
    LastUpdatedDate        timestamptz,
    Primary Key (Reference, Period, Survey, QuestionCode, Instance),
    Foreign Key (Reference, Period, Survey) References Contributor (Reference, Period, Survey),
    Foreign Key (Survey, QuestionCode) References Question (Survey, QuestionCode)
);


Create Table dev01.ValidationRule
(
    Rule            Varchar(16) Primary Key,
    Name            Varchar(32) Not Null,
    BaseFormula     Varchar(1024) Not Null,
    CreatedBy       Varchar(16) Not Null,
    CreatedDate     timestamptz Not Null,
    LastUpdatedBy   Varchar(16),
    LastUpdatedDate timestamptz
);


Create Table dev01.ValidationPeriod
(
    Rule            Varchar(16) References ValidationRule(Rule),
    PeriodOffset    Integer Not Null,
    CreatedBy       Varchar(16) Not Null,
    CreatedDate     timestamptz Not Null,
    LastUpdatedBy   Varchar(16),
    LastUpdatedDate timestamptz,
    Primary Key (Rule,PeriodOffset)
);


Create table dev01.ValidationForm
(
    ValidationID            serial Primary Key,
    FormID                  Int References dev01.Form(FormID),
    Rule                    Varchar(16) References dev01.ValidationRule(Rule),
    PrimaryQuestion         Varchar(4) Not Null,
    DefaultValue            Varchar(8) Not Null,
    Severity                Varchar(16) Not Null,
    CreatedBy               Varchar(16) Not Null,
    CreatedDate             timestamptz Not Null,
    LastUpdatedBy           Varchar(16),
    LastUpdatedDate         timestamptz
);
Create Index idx_validationform_formrule On dev01.ValidationForm(FormID,Rule);
Create Index idx_validationform_question On dev01.ValidationForm(PrimaryQuestion);


Create Table dev01.ValidationAttribute
(
    AttributeName   Varchar(32) Primary Key,
    Source          Varchar(32) Not Null,
    CreatedBy       Varchar(16) Not Null,
    CreatedDate     timestamptz Not Null,
    LastUpdatedBy   Varchar(16),
    LastUpdatedDate timestamptz
);


Create Table dev01.ValidationParameter
(
    ValidationID    Int References ValidationForm(ValidationID),
    AttributeName   Varchar(32) References ValidationAttribute(AttributeName),
    AttributeValue  Varchar(32) Not Null,
    Parameter       Varchar(32) Not Null,
    Value           Varchar(32) Not Null,
	Source			Varchar(32) Not Null,
	PeriodOffset	Int Not Null,
    CreatedBy       Varchar(16) Not Null,
    CreatedDate     timestamptz Not Null,
    LastUpdatedBy   Varchar(16),
    LastUpdatedDate timestamptz,
    Primary Key (ValidationID, AttributeName, AttributeValue, Parameter)
);


Create Table dev01.ValidationOutput
(
    ValidationOutputID  serial Primary Key,
    Reference           Varchar(11) Not Null,
    Period              Char(6) Not Null,
    Survey              Char(6) References Survey(Survey),
    ValidationID        BigInt References ValidationForm(ValidationID),
    Instance            BigInt Not Null,
    Formula             Varchar(128) Not Null,
    Triggered           Boolean Not Null,
    CreatedBy           Varchar(16) Not Null,
    CreatedDate         timestamptz Not Null,
    LastUpdatedBy       Varchar(16),
    LastUpdatedDate     timestamptz,
    Foreign Key (Reference, Period, Survey) References Contributor (Reference, Period, Survey)
);
Create Index idx_validationoutput_referenceperiodsurvey On ValidationOutput(Reference, Period, Survey);

Create Or Replace Function dev01.deleteOutput(reference text, period text, survey text)
Returns void As $$

    Delete
    From    dev01.validationoutput
    Where   reference = $1
    And     period = $2
    And     survey = $3

$$ language sql VOLATILE;


Create Function dev01.InsertValidationOutputByArray(dev01.validationoutput[])
Returns dev01.validationoutput as $$

    Insert Into dev01.validationoutput
    (
        reference,
        period,
        survey,
        validationid,
        instance,
        triggered,
        formula,
        createdBy,
        createdDate
    )
    Select  reference,
            period,
            survey,
            validationid,
            instance,
            triggered,
            formula,
            createdBy,
            createdDate
    From    unnest($1)
    Returning *;

$$ LANGUAGE sql VOLATILE STRICT SECURITY DEFINER;

Create Or Replace Function dev01.SaveResponseArray(dev01.response[])
Returns dev01.response as $$
    Insert into dev01.response
    (
        reference,
        period,
        survey,
        questionCode,
        instance,
        response,
        createdBy,
        createdDate,
        lastUpdatedBy,
        lastUpdatedDate
    )
    Select  reference,
            period,
            survey,
            questionCode,
            instance,
            response,
            createdBy,
            createdDate,
            lastUpdatedBy,
            lastUpdatedDate
    From    UnNest($1)
    On Conflict On Constraint response_pkey Do
    Update Set
        response = EXCLUDED.response,
        lastUpdatedBy = EXCLUDED.lastUpdatedBy,
        lastUpdatedDate = EXCLUDED.lastUpdatedDate
    Returning *;

$$ LANGUAGE sql VOLATILE STRICT SECURITY DEFINER;



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
(   '49900000796', '201903', '0066', 1, 'Form Sent Out', now(), '0004', 'T', '70110', '70110', '41100', '41100', 750, 748, 100, 100, 100, 100, 99999, 99999, '9900000796', '2906948169', 1, 'S', '326935020502', '2135632144542', '97395797', 178, 0, 0, '1', 'E', 'NP', '06/06/1975', 'Hayes, Fletcher and Shaw', 'Lawrence Group Ltd', '9 Brenda falls, East Harry, Wales', 'L2T 0PR', 'Sole Trader', 'Heather Griffiths', '01633 5551234', '', 'P', '', 'fisdba', now() ),
(   '49900002189', '201903', '0066', 1, 'Form Sent Out', now(), '0004', 'T', '70110', '70110', '41100', '41100', 25, 25, 22, 22, 22, 22, 12345, 12345, '9900002189', '2928514836', 1, 'S', '423279595848', '9446786207965', '55841012', 71, 0, 0, '1', 'E', 'BS', '18/12/1978', 'Grant-Wright', 'Williams PLC', '8 Alexandra ports, Denisfort, Wales', 'N60 6TL', 'Sole Trader', 'Jacob Thorpe', '0117 9555123', '', 'P', '', 'fisdba', now() ),
(   '49900002387', '201903', '0066', 1, 'Form Sent Out', now(), '0004', 'F', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900002387', '2931260132', 1, 'S', '979024265812', '3101057635557', '74239110', 2, 0, 0, '1', 'E', 'CF', '15/07/1983', 'Edwards-Savage and Sons', 'Long and Sons', '14 Page bypass, Watershaven, Scotland', 'L8 9QE', 'Franchise', 'Gillian Bailey', '029 20555123', '', 'P', '', 'fisdba', now() ),
(   '49900008900', '201903', '0066', 1, 'Form Sent Out', now(), '0004', 'S', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900008900', '2988769191', 1, 'S', '650195077639', '5864180611950', '94403544', 7, 1, 0, '1', 'E', 'CF', '01/04/2011', 'Barnes Inc', 'Jackson, Cooper and Palmer', '2 Bird island, Kellyhaven, England', 'CM4B 6UR', '', 'Ronald Field-Williams', '01633 5559912', '', 'P', '', 'fisdba', now() ),
(   '49900012765', '201906', '0066', 1, 'Form Sent Out', now(), '0004', 'M', '70110', '70110', '41100', '41100', 750, 748, 100, 100, 100, 100, 99999, 99999, '9900012765', '2922451920', 1, 'S', '898038558701', '2690058876978', '69059744', 6, 1, 0, '1', 'E', 'NP', '28/04/1977', '', 'Sandy Land Company Ltd.', 'Sandybank Estate, Newport, UK', 'NP10 1AA', '', 'Sandra Landy', '01633 5551234', '', 'P', '', 'fisdba', now() ),
(   '49900024849', '201906', '0066', 1, 'Form Sent Out', now(), '0004', 'G', '70110', '70110', '41100', '41100', 25, 25, 22, 22, 22, 22, 12345, 12345, '9900024849', '2934942130', 1, 'S', '149294328171', '3660987585937', '23670278', 0, 0, 0, '1', 'E', 'BS', '12/12/1970', '', 'James-Johnson', '8 Ali row, North Elaineton, England', 'FK31 7WJ', '', 'Rachael Farrell', '0117 9555123', '', 'P', '', 'fisdba', now() ),
(   '49900025178', '201906', '0066', 1, 'Form Sent Out', now(), '0004', 'K', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900025178', '2961727813', 1, 'S', '644055013735', '1567986355199', '70046170', 12, 0, 0, '1', 'E', 'CF', '09/01/1982', '', 'Davidson LLC', '53 Evans club, Walshburgh, Northern Ireland', 'WR69 8TP', '', 'Gemma Houghton-Howard', '029 20555123', '', 'P', '', 'fisdba', now() ),
(   '49900864204', '201906', '0066', 1, 'Form Sent Out', now(), '0004', 'A', '60241', '60241', '49420', '49420', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900864204', '2968297628', 1, 'S', '373831465848', '4030190271735', '46993901', 100, 0, 0, '1', 'E', 'CF', '02/12/2001', '', 'Macdonald, Evans and ONeill', '1 Davey passage, Lake Joanneborough, Northern Ireland', 'BT2 8TH', '', 'Kennedy-Doyle', '01633 5559912', '', 'P', '', 'fisdba', now() ),


(   '49900000796', '201906', '0066', 1, 'Form Sent Out', now(), '0004', 'T', '70110', '70110', '41100', '41100', 750, 748, 100, 100, 100, 100, 99999, 99999, '9900000796', '2906948169', 1, 'S', '326935020502', '2135632144542', '97395797', 178, 0, 0, '1', 'E', 'NP', '06/06/1975', 'Hayes, Fletcher and Shaw', 'Lawrence Group Ltd', '9 Brenda falls, East Harry, Wales', 'L2T 0PR', 'Sole Trader', 'Heather Griffiths', '01633 5551234', '', 'P', '', 'fisdba', now() ),
(   '49900002387', '201906', '0066', 1, 'Form Sent Out', now(), '0004', 'F', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900002387', '2931260132', 1, 'S', '979024265812', '3101057635557', '74239110', 2, 0, 0, '1', 'E', 'CF', '15/07/1983', 'Edwards-Savage and Sons', 'Long and Sons', '14 Page bypass, Watershaven, Scotland', 'L8 9QE', 'Franchise', 'Gillian Bailey', '029 20555123', '', 'P', '', 'fisdba', now() ),
(   '49900008900', '201906', '0066', 1, 'Form Sent Out', now(), '0004', 'S', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900008900', '2988769191', 1, 'S', '650195077639', '5864180611950', '94403544', 7, 1, 0, '1', 'E', 'CF', '01/04/2011', 'Barnes Inc', 'Jackson, Cooper and Palmer', '2 Bird island, Kellyhaven, England', 'CM4B 6UR', '', 'Ronald Field-Williams', '01633 5559912', '', 'P', '', 'fisdba', now() ),
(   '49900012765', '201903', '0066', 1, 'Form Sent Out', now(), '0004', 'M', '70110', '70110', '41100', '41100', 750, 748, 100, 100, 100, 100, 99999, 99999, '9900012765', '2922451920', 1, 'S', '898038558701', '2690058876978', '69059744', 6, 1, 0, '1', 'E', 'NP', '28/04/1977', '', 'Sandy Land Company Ltd.', 'Sandybank Estate, Newport, UK', 'NP10 1AA', '', 'Sandra Landy', '01633 5551234', '', 'P', '', 'fisdba', now() ),
(   '49900024849', '201903', '0066', 1, 'Form Sent Out', now(), '0004', 'G', '70110', '70110', '41100', '41100', 25, 25, 22, 22, 22, 22, 12345, 12345, '9900024849', '2934942130', 1, 'S', '149294328171', '3660987585937', '23670278', 0, 0, 0, '1', 'E', 'BS', '12/12/1970', '', 'James-Johnson', '8 Ali row, North Elaineton, England', 'FK31 7WJ', '', 'Rachael Farrell', '0117 9555123', '', 'P', '', 'fisdba', now() ),
(   '49900025178', '201903', '0066', 1, 'Form Sent Out', now(), '0004', 'K', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900025178', '2961727813', 1, 'S', '644055013735', '1567986355199', '70046170', 12, 0, 0, '1', 'E', 'CF', '09/01/1982', '', 'Davidson LLC', '53 Evans club, Walshburgh, Northern Ireland', 'WR69 8TP', '', 'Gemma Houghton-Howard', '029 20555123', '', 'P', '', 'fisdba', now() ),
(   '49900864204', '201903', '0066', 1, 'Form Sent Out', now(), '0004', 'A', '60241', '60241', '49420', '49420', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900864204', '2968297628', 1, 'S', '373831465848', '4030190271735', '46993901', 100, 0, 0, '1', 'E', 'CF', '02/12/2001', '', 'Macdonald, Evans and ONeill', '1 Davey passage, Lake Joanneborough, Northern Ireland', 'BT2 8TH', '', 'Kennedy-Doyle', '01633 5559912', '', 'P', '', 'fisdba', now() );


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
( 20, 'Default', 'Default', 'question', '0602', 'response', 0, current_user, now() ),
( 20, 'Default', 'Default', 'comparison_question', '0602', 'response', 1, current_user, now() ),
( 20, 'Default', 'Default', 'threshold', '0', '', 0, current_user, now() ),
( 30, 'Default', 'Default', 'question', '0147', 'response', 0, current_user, now() ),
( 40, 'Default', 'Default', 'question', '0608', 'response', 0, current_user, now() ),
( 40, 'Default', 'Default', 'comparison_question', '9001', 'response', 0, current_user, now() );
