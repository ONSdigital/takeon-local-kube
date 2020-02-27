SET search_path TO dev01,public;

drop function if exists dev01.deleteOutput;
drop function if exists dev01.InsertValidationOutputByArray;
drop function if exists dev01.SaveResponseArray;
drop function if exists dev01.update_validationoutput_multi;

drop type if exists dev01.override_validation_output;

drop table if exists dev01.ValidationOutput;
drop table if exists dev01.ValidationParameter;
drop table if exists dev01.ValidationAttribute;
drop table if exists dev01.ValidationForm;
drop table if exists dev01.ValidationPeriod;
drop table if exists dev01.ValidationRule;
drop table if exists dev01.Response;
drop table if exists dev01.Contributor;
drop table if exists dev01.FormDefinition;
drop table if exists dev01.Question;
drop table if exists dev01.Form;
drop table if exists dev01.Survey;

drop SCHEMA if exists dev01;

CREATE SCHEMA dev01;
SET search_path TO dev01;

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
    LastUpdatedDate timestamptz,
    ValidationMessage Varchar(256)
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
    overridden          Boolean Not Null DEFAULT false,
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

CREATE TYPE dev01.override_validation_output AS (validationoutputid integer,
                                                 overridden boolean,
                                                 lastupdatedby text,
	                                         lastupdateddate timestamptz);

CREATE OR REPLACE FUNCTION dev01.update_validationoutput_multi (dev01.override_validation_output[])
Returns void As $$
WITH valopinput (validationoutputid, overridden, lastupdatedby, lastupdateddate) AS (
    SELECT *
	FROM unnest($1)
)
UPDATE dev01.validationoutput
SET overridden = sr.overridden,
    lastupdatedby = sr.lastupdatedby,
    lastupdateddate = sr.lastupdateddate
FROM valopinput sr
WHERE dev01.validationoutput.validationoutputid = sr.validationoutputid;
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
    CreatedDate,
    ValidationMessage
)
Values
( 'VP','Value Present','"question" != ""',current_user,now(),'Respondent entered a value'),
( 'POPM','Period on Period Movement','abs(question - comparison_question) > threshold AND question > 0 AND comparison_question > 0',current_user,now(),'This has changed significantly since the last submission'),
( 'POPZC','Period on Period Zero Continuity','question != comparison_question AND ( question = 0 OR comparison_question = 0 ) AND abs(question - comparison_question) > threshold',current_user,now(),'This is different to the previous submission. If this is 0 or blank, the previous was greater. If this has a value, the previous was 0 or blank'),
( 'POPQVQ','Period on Period Q Vs Q','question != comparison_question',current_user,now(),'This has changed significantly since the last submission and this is greater than the question we compare it to'),
( 'QVDQ','Question vs Derived Question','question != comparison_question',current_user,now(),'This total is not equal to the derived total'),
( 'CPBMI', 'Comment Present (BMI)', 'question = 2', current_user,now(),'Respondent entered a comment');

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
    ('POPQVQ',0,current_user,now()),
    ('POPQVQ',1,current_user,now()),
    ('QVDQ',0,current_user,now()),
    ('CPBMI',0,current_user,now());


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
( 1, '0146', 'Q146', 'Comment on the figures included in your return', 10, 'NUMERIC', '', 'fisdba', now() ),
( 1, '9001', 'Q9001', 'Derived Total of all sand and gravel (Q601 + Q602 + Q603 + Q604 + Q605 + Q606 + Q607)', 11, 'NUMERIC', '0601 + 0602 + 0603 + 0604 + 0605 + 0606 + 0607', 'fisdba', now() );


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
    (6610,1,'POPM','0601','0','W',current_user,now()),
    (6611,1,'POPM','0602','0','W',current_user,now()),
    (6612,1,'POPM','0603','0','W',current_user,now()),
    (6613,1,'POPM','0604','0','W',current_user,now()),
    (6614,1,'POPM','0605','0','W',current_user,now()),
    (6615,1,'POPM','0606','0','W',current_user,now()),
    (6616,1,'POPM','0607','0','W',current_user,now()),

    (6620,1,'POPZC','0601','0','E',current_user,now()),
    (6621,1,'POPZC','0602','0','E',current_user,now()),
    (6622,1,'POPZC','0603','0','E',current_user,now()),
    (6623,1,'POPZC','0604','0','E',current_user,now()),
    (6624,1,'POPZC','0605','0','E',current_user,now()),
    (6625,1,'POPZC','0606','0','E',current_user,now()),
    (6626,1,'POPZC','0607','0','E',current_user,now()),

    (6630,1,'CPBMI','0146','1','E',current_user,now()),

    (6640,1,'CPBMI','0147','1','E',current_user,now()),

    (6650,1,'QVDQ','0608','0','W',current_user,now());


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
( 6610, 'Default', 'Default', 'question', '0601', 'response', 0, current_user, now() ),
( 6610, 'Default', 'Default', 'comparison_question', '0601', 'response', 1, current_user, now() ),
( 6610, 'Default', 'Default', 'threshold', '20000', '', 0, current_user, now() ),

( 6611, 'Default', 'Default', 'question', '0602', 'response', 0, current_user, now() ),
( 6611, 'Default', 'Default', 'comparison_question', '0602', 'response', 1, current_user, now() ),
( 6611, 'Default', 'Default', 'threshold', '20000', '', 0, current_user, now() ),

( 6612, 'Default', 'Default', 'question', '0603', 'response', 0, current_user, now() ),
( 6612, 'Default', 'Default', 'comparison_question', '0603', 'response', 1, current_user, now() ),
( 6612, 'Default', 'Default', 'threshold', '20000', '', 0, current_user, now() ),

( 6613, 'Default', 'Default', 'question', '0604', 'response', 0, current_user, now() ),
( 6613, 'Default', 'Default', 'comparison_question', '0604', 'response', 1, current_user, now() ),
( 6613, 'Default', 'Default', 'threshold', '20000', '', 0, current_user, now() ),

( 6614, 'Default', 'Default', 'question', '0605', 'response', 0, current_user, now() ),
( 6614, 'Default', 'Default', 'comparison_question', '0605', 'response', 1, current_user, now() ),
( 6614, 'Default', 'Default', 'threshold', '20000', '', 0, current_user, now() ),

( 6615, 'Default', 'Default', 'question', '0606', 'response', 0, current_user, now() ),
( 6615, 'Default', 'Default', 'comparison_question', '0606', 'response', 1, current_user, now() ),
( 6615, 'Default', 'Default', 'threshold', '20000', '', 0, current_user, now() ),

( 6616, 'Default', 'Default', 'question', '0607', 'response', 0, current_user, now() ),
( 6616, 'Default', 'Default', 'comparison_question', '0607', 'response', 1, current_user, now() ),
( 6616, 'Default', 'Default', 'threshold', '20000', '', 0, current_user, now() ),

( 6620, 'Default', 'Default', 'question', '0601', 'response', 0, current_user, now() ),
( 6620, 'Default', 'Default', 'comparison_question', '0601', 'response', 1, current_user, now() ),
( 6620, 'Default', 'Default', 'threshold', '0', '', 0, current_user, now() ),

( 6621, 'Default', 'Default', 'question', '0602', 'response', 0, current_user, now() ),
( 6621, 'Default', 'Default', 'comparison_question', '0602', 'response', 1, current_user, now() ),
( 6621, 'Default', 'Default', 'threshold', '0', '', 0, current_user, now() ),

( 6622, 'Default', 'Default', 'question', '0603', 'response', 0, current_user, now() ),
( 6622, 'Default', 'Default', 'comparison_question', '0603', 'response', 1, current_user, now() ),
( 6622, 'Default', 'Default', 'threshold', '0', '', 0, current_user, now() ),

( 6623, 'Default', 'Default', 'question', '0604', 'response', 0, current_user, now() ),
( 6623, 'Default', 'Default', 'comparison_question', '0604', 'response', 1, current_user, now() ),
( 6623, 'Default', 'Default', 'threshold', '0', '', 0, current_user, now() ),

( 6624, 'Default', 'Default', 'question', '0605', 'response', 0, current_user, now() ),
( 6624, 'Default', 'Default', 'comparison_question', '0605', 'response', 1, current_user, now() ),
( 6624, 'Default', 'Default', 'threshold', '0', '', 0, current_user, now() ),

( 6625, 'Default', 'Default', 'question', '0606', 'response', 0, current_user, now() ),
( 6625, 'Default', 'Default', 'comparison_question', '0606', 'response', 1, current_user, now() ),
( 6625, 'Default', 'Default', 'threshold', '0', '', 0, current_user, now() ),

( 6626, 'Default', 'Default', 'question', '0607', 'response', 0, current_user, now() ),
( 6626, 'Default', 'Default', 'comparison_question', '0607', 'response', 1, current_user, now() ),
( 6626, 'Default', 'Default', 'threshold', '0', '', 0, current_user, now() ),

( 6630, 'Default', 'Default', 'question', '0146', 'response', 0, current_user, now() ),

( 6640, 'Default', 'Default', 'question', '0147', 'response', 0, current_user, now() ),

( 6650, 'Default', 'Default', 'question', '0608', 'response', 0, current_user, now() ),
( 6650, 'Default', 'Default', 'comparison_question', '9001', 'response', 0, current_user, now() );






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
(   '49900002387', '201903', '0066', 1, 'Form Sent Out', now(), '0004', 'F', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900002387', '2931260132', 1, 'S', '979024265812', '3101057635557', '74239110', 2, 0, 0, '1', 'E', 'CF', '15/07/1983', 'Edwards-Savage and Sons', 'Long and Sons', '14 Page bypass, Watershaven, Scotland', 'L8 9QE', 'Franchise', 'Gillian Bailey', '029 20555123', '', 'P', '', 'fisdba', now() ),
(   '49900008900', '201903', '0066', 1, 'Form Sent Out', now(), '0004', 'S', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900008900', '2988769191', 1, 'S', '650195077639', '5864180611950', '94403544', 7, 1, 0, '1', 'E', 'CF', '01/04/2011', 'Barnes Inc', 'Jackson, Cooper and Palmer', '2 Bird island, Kellyhaven, England', 'CM4B 6UR', '', 'Ronald Field-Williams', '01633 5559912', '', 'P', '', 'fisdba', now() ),
(   '49900012765', '201903', '0066', 1, 'Form Sent Out', now(), '0004', 'M', '70110', '70110', '41100', '41100', 750, 748, 100, 100, 100, 100, 99999, 99999, '9900012765', '2922451920', 1, 'S', '898038558701', '2690058876978', '69059744', 6, 1, 0, '1', 'E', 'NP', '28/04/1977', '', 'Sandy Land Company Ltd.', 'Sandybank Estate, Newport, UK', 'NP10 1AA', '', 'Sandra Landy', '01633 5551234', '', 'P', '', 'fisdba', now() ),
(   '49900024849', '201903', '0066', 1, 'Form Sent Out', now(), '0004', 'G', '70110', '70110', '41100', '41100', 25, 25, 22, 22, 22, 22, 12345, 12345, '9900024849', '2934942130', 1, 'S', '149294328171', '3660987585937', '23670278', 0, 0, 0, '1', 'E', 'BS', '12/12/1970', '', 'James-Johnson', '8 Ali row, North Elaineton, England', 'FK31 7WJ', '', 'Rachael Farrell', '0117 9555123', '', 'P', '', 'fisdba', now() ),

(   '49900000796', '201906', '0066', 1, 'Form Sent Out', now(), '0004', 'T', '70110', '70110', '41100', '41100', 750, 748, 100, 100, 100, 100, 99999, 99999, '9900000796', '2906948169', 1, 'S', '326935020502', '2135632144542', '97395797', 178, 0, 0, '1', 'E', 'NP', '06/06/1975', 'Hayes, Fletcher and Shaw', 'Lawrence Group Ltd', '9 Brenda falls, East Harry, Wales', 'L2T 0PR', 'Sole Trader', 'Heather Griffiths', '01633 5551234', '', 'P', '', 'fisdba', now() ),
(   '49900002387', '201906', '0066', 1, 'Form Sent Out', now(), '0004', 'F', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900002387', '2931260132', 1, 'S', '979024265812', '3101057635557', '74239110', 2, 0, 0, '1', 'E', 'CF', '15/07/1983', 'Edwards-Savage and Sons', 'Long and Sons', '14 Page bypass, Watershaven, Scotland', 'L8 9QE', 'Franchise', 'Gillian Bailey', '029 20555123', '', 'P', '', 'fisdba', now() ),
(   '49900008900', '201906', '0066', 1, 'Form Sent Out', now(), '0004', 'S', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900008900', '2988769191', 1, 'S', '650195077639', '5864180611950', '94403544', 7, 1, 0, '1', 'E', 'CF', '01/04/2011', 'Barnes Inc', 'Jackson, Cooper and Palmer', '2 Bird island, Kellyhaven, England', 'CM4B 6UR', '', 'Ronald Field-Williams', '01633 5559912', '', 'P', '', 'fisdba', now() ),
(   '49900012765', '201906', '0066', 1, 'Form Sent Out', now(), '0004', 'M', '70110', '70110', '41100', '41100', 750, 748, 100, 100, 100, 100, 99999, 99999, '9900012765', '2922451920', 1, 'S', '898038558701', '2690058876978', '69059744', 6, 1, 0, '1', 'E', 'NP', '28/04/1977', '', 'Sandy Land Company Ltd.', 'Sandybank Estate, Newport, UK', 'NP10 1AA', '', 'Sandra Landy', '01633 5551234', '', 'P', '', 'fisdba', now() ),
(   '49900024849', '201906', '0066', 1, 'Form Sent Out', now(), '0004', 'G', '70110', '70110', '41100', '41100', 25, 25, 22, 22, 22, 22, 12345, 12345, '9900024849', '2934942130', 1, 'S', '149294328171', '3660987585937', '23670278', 0, 0, 0, '1', 'E', 'BS', '12/12/1970', '', 'James-Johnson', '8 Ali row, North Elaineton, England', 'FK31 7WJ', '', 'Rachael Farrell', '0117 9555123', '', 'P', '', 'fisdba', now() );



Insert Into dev01.Survey
(
    survey,
    description,
    periodicity,
    CreatedBy,
    CreatedDate
)
Values

( '0073','Monthly Survey of Concrete Blocks','Monthly','fisdba', now() );

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
( '0073', '0146', 'fisdba', now()),
( '0073', '9001', 'fisdba', now()),
( '0073', '9002', 'fisdba', now()),
( '0073', '9003', 'fisdba', now());


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
( 3, '0146', 'Q146', 'Comment on the figures included in your return', 14, 'NUMERIC', '', 'fisdba', now() ),
( 3, '9001', 'Q9001', 'Derived total of opening stock + production - deliveries (Q101 + Q102 - Q103)', 15, 'NUMERIC', '0101 + 0102 - 0103', 'fisdba', now() ),
( 3, '9002', 'Q9002', 'Derived total of opening stock + production - deliveries (Q111 + Q112 - Q113)', 16, 'NUMERIC', '0111 + 0112 - 0113', 'fisdba', now() ),
( 3, '9003', 'Q9003', 'Derived total of opening stock + production - deliveries (Q121 + Q122 - Q123)', 17, 'NUMERIC', '0121 + 0122 - 0123', 'fisdba', now() );


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
    (7310,3,'POPM','0102','0','W',current_user,now()),
    (7311,3,'POPM','0112','0','W',current_user,now()),
    (7312,3,'POPM','0103','0','W',current_user,now()),
    (7313,3,'POPM','0113','0','W',current_user,now()),
    (7314,3,'POPM','0122','0','W',current_user,now()),
    (7315,3,'POPM','0123','0','W',current_user,now()),

    (7320,3,'POPZC','0104','0','E',current_user,now()),
    (7321,3,'POPZC','0114','0','E',current_user,now()),
    (7322,3,'POPZC','0124','0','E',current_user,now()),

    (7330,3,'CPBMI','0145','1','E',current_user,now()),
    (7331,3,'CPBMI','0146','1','E',current_user,now()),

    (7340,3,'POPQVQ','0101','0','W',current_user,now()),
    (7341,3,'POPQVQ','0111','0','W',current_user,now()),
    (7342,3,'POPQVQ','0121','0','W',current_user,now()),

    (7350,3,'QVDQ','0104','0','W',current_user,now()),
    (7351,3,'QVDQ','0114','0','W',current_user,now()),
    (7352,3,'QVDQ','0124','0','W',current_user,now());


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

( 7340, 'Default', 'Default', 'question', '0101', 'response', 0, current_user, now() ),
( 7340, 'Default', 'Default', 'comparison_question', '0101', 'response', 1, current_user, now() ),

( 7341, 'Default', 'Default', 'question', '0111', 'response', 0, current_user, now() ),
( 7341, 'Default', 'Default', 'comparison_question', '0111', 'response', 1, current_user, now() ),

( 7342, 'Default', 'Default', 'question', '0121', 'response', 0, current_user, now() ),
( 7342, 'Default', 'Default', 'comparison_question', '0121', 'response', 1, current_user, now() ),

( 7310, 'Default', 'Default', 'question', '0102', 'response', 0, current_user, now() ),
( 7310, 'Default', 'Default', 'comparison_question', '0102', 'response', 1, current_user, now() ),
( 7310, 'Default', 'Default', 'threshold', '10000', '', 0, current_user, now() ),

( 7311, 'Default', 'Default', 'question', '0112', 'response', 0, current_user, now() ),
( 7311, 'Default', 'Default', 'comparison_question', '0112', 'response', 1, current_user, now() ),
( 7311, 'Default', 'Default', 'threshold', '10000', '', 0, current_user, now() ),

( 7312, 'Default', 'Default', 'question', '0103', 'response', 0, current_user, now() ),
( 7312, 'Default', 'Default', 'comparison_question', '0103', 'response', 1, current_user, now() ),
( 7312, 'Default', 'Default', 'threshold', '10000', '', 0, current_user, now() ),

( 7313, 'Default', 'Default', 'question', '0113', 'response', 0, current_user, now() ),
( 7313, 'Default', 'Default', 'comparison_question', '0113', 'response', 1, current_user, now() ),
( 7313, 'Default', 'Default', 'threshold', '10000', '', 0, current_user, now() ),

( 7350, 'Default', 'Default', 'question', '0104', 'response', 0, current_user, now() ),
( 7350, 'Default', 'Default', 'comparison_question', '9001', 'response', 0, current_user, now() ),
( 7320, 'Default', 'Default', 'question', '0104', 'response', 0, current_user, now() ),
( 7320, 'Default', 'Default', 'comparison_question', '0104', 'response', 1, current_user, now() ),
( 7320, 'Default', 'Default', 'threshold', '0', '', 0, current_user, now() ),

( 7351, 'Default', 'Default', 'question', '0114', 'response', 0, current_user, now() ),
( 7351, 'Default', 'Default', 'comparison_question', '9002', 'response', 0, current_user, now() ),
( 7321, 'Default', 'Default', 'question', '0114', 'response', 0, current_user, now() ),
( 7321, 'Default', 'Default', 'comparison_question', '0114', 'response', 1, current_user, now() ),
( 7321, 'Default', 'Default', 'threshold', '0', '', 0, current_user, now() ),

( 7314, 'Default', 'Default', 'question', '0122', 'response', 0, current_user, now() ),
( 7314, 'Default', 'Default', 'comparison_question', '0122', 'response', 1, current_user, now() ),
( 7314, 'Default', 'Default', 'threshold', '10000', '', 0, current_user, now() ),

( 7315, 'Default', 'Default', 'question', '0123', 'response', 0, current_user, now() ),
( 7315, 'Default', 'Default', 'comparison_question', '0123', 'response', 1, current_user, now() ),
( 7315, 'Default', 'Default', 'threshold', '10000', '', 0, current_user, now() ),

( 7352, 'Default', 'Default', 'question', '0124', 'response', 0, current_user, now() ),
( 7352, 'Default', 'Default', 'comparison_question', '9003', 'response', 0, current_user, now() ),
( 7322, 'Default', 'Default', 'question', '0114', 'response', 0, current_user, now() ),
( 7322, 'Default', 'Default', 'comparison_question', '0114', 'response', 1, current_user, now() ),
( 7322, 'Default', 'Default', 'threshold', '0', '', 0, current_user, now() ),

( 7330, 'Default', 'Default', 'question', '0145', 'response', 0, current_user, now() ),

( 7331, 'Default', 'Default', 'question', '0146', 'response', 0, current_user, now() );






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

(   '49900138556', '201905', '0073', 3, 'Form Sent Out', now(), '0004', 'T', '70110', '70110', '41100', '41100', 750, 748, 100, 100, 100, 100, 99999, 99999, '9900138556', '2967466849', 1, 'S', '326935020502', '2135632144542', '97395797', 178, 0, 0, '1', 'E', 'NP', '20/08/2001', 'Walker-Tucker', 'Jones, Gibbons and Hall', '536 Kaur plaza, East Harry, Wales', 'L2T 0PR', 'Sole Trader', 'Malcolm Bryant', '01633 5551234', '', 'P', '', 'fisdba', now() ),
(   '49900189484', '201905', '0073', 3, 'Form Sent Out', now(), '0004', 'T', '70110', '70110', '41100', '41100', 25, 25, 22, 22, 22, 22, 12345, 12345, '9900189484', '2905627610', 1, 'S', '423279595848', '9446786207965', '55841012', 71, 0, 0, '1', 'E', 'BS', '16/05/1993', 'Spencer Ltd', 'Quinn Group', '7 Marc shoal, Denisfort, Wales', 'N60 6TL', 'Sole Trader', 'Abdul Stevens', '0117 9555123', '', 'P', '', 'fisdba', now() ),
(   '49900190211', '201905', '0073', 3, 'Form Sent Out', now(), '0004', 'F', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900190211', '2981901571', 1, 'S', '979024265812', '3101057635557', '74239110', 2, 0, 0, '1', 'E', 'CF', '08/11/2018', 'Holloway and Sons', 'Hammond and Sons', '14 Ellis passage, Watershaven, Scotland', 'L8 9QE', 'Franchise', 'Sharon Hawkins', '029 20555123', '', 'P', '', 'fisdba', now() ),
(   '49900190505', '201905', '0073', 3, 'Form Sent Out', now(), '0004', 'S', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900190505', '2930251417', 1, 'S', '650195077639', '5864180611950', '94403544', 7, 1, 0, '1', 'E', 'CF', '29/06/2005', 'Harvey-Perkins', 'Moran, Wood and Arnold', '690 Ford keys, Kellyhaven, England', 'CM4B 6UR', '', 'Kate ODonnell', '01633 5559912', '', 'P', '', 'fisdba', now() ),
(   '49900228645', '201905', '0073', 3, 'Form Sent Out', now(), '0004', 'M', '70110', '70110', '41100', '41100', 750, 748, 100, 100, 100, 100, 99999, 99999, '9900228645', '2902674255', 1, 'S', '898038558701', '2690058876978', '69059744', 6, 1, 0, '1', 'E', 'NP', '08/08/2012', 'Khan-Jackson', 'Potter Group', '33 Roberts tunnel, Newport, UK', 'NP10 1AA', '', 'Josephine Reid', '01633 5551234', '', 'P', '', 'fisdba', now() ),

(   '49900138556', '201906', '0073', 3, 'Form Sent Out', now(), '0004', 'T', '70110', '70110', '41100', '41100', 750, 748, 100, 100, 100, 100, 99999, 99999, '9900138556', '2967466849', 1, 'S', '326935020502', '2135632144542', '97395797', 178, 0, 0, '1', 'E', 'NP', '20/08/2001', 'Walker-Tucker', 'Jones, Gibbons and Hall', '536 Kaur plaza, East Harry, Wales', 'L2T 0PR', 'Sole Trader', 'Malcolm Bryant', '01633 5551234', '', 'P', '', 'fisdba', now() ),
(   '49900189484', '201906', '0073', 3, 'Form Sent Out', now(), '0004', 'T', '70110', '70110', '41100', '41100', 25, 25, 22, 22, 22, 22, 12345, 12345, '9900189484', '2905627610', 1, 'S', '423279595848', '9446786207965', '55841012', 71, 0, 0, '1', 'E', 'BS', '16/05/1993', 'Spencer Ltd', 'Quinn Group', '7 Marc shoal, Denisfort, Wales', 'N60 6TL', 'Sole Trader', 'Abdul Stevens', '0117 9555123', '', 'P', '', 'fisdba', now() ),
(   '49900190211', '201906', '0073', 3, 'Form Sent Out', now(), '0004', 'F', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900190211', '2981901571', 1, 'S', '979024265812', '3101057635557', '74239110', 2, 0, 0, '1', 'E', 'CF', '08/11/2018', 'Holloway and Sons', 'Hammond and Sons', '14 Ellis passage, Watershaven, Scotland', 'L8 9QE', 'Franchise', 'Sharon Hawkins', '029 20555123', '', 'P', '', 'fisdba', now() ),
(   '49900190505', '201906', '0073', 3, 'Form Sent Out', now(), '0004', 'S', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900190505', '2930251417', 1, 'S', '650195077639', '5864180611950', '94403544', 7, 1, 0, '1', 'E', 'CF', '29/06/2005', 'Harvey-Perkins', 'Moran, Wood and Arnold', '690 Ford keys, Kellyhaven, England', 'CM4B 6UR', '', 'Kate ODonnell', '01633 5559912', '', 'P', '', 'fisdba', now() ),
(   '49900228645', '201906', '0073', 3, 'Form Sent Out', now(), '0004', 'M', '70110', '70110', '41100', '41100', 750, 748, 100, 100, 100, 100, 99999, 99999, '9900228645', '2902674255', 1, 'S', '898038558701', '2690058876978', '69059744', 6, 1, 0, '1', 'E', 'NP', '08/08/2012', 'Khan-Jackson', 'Potter Group', '33 Roberts tunnel, Newport, UK', 'NP10 1AA', '', 'Josephine Reid', '01633 5551234', '', 'P', '', 'fisdba', now() );






Insert Into dev01.Survey
(
    survey,
    description,
    periodicity,
    CreatedBy,
    CreatedDate
)
Values

( '0074','Monthly Survey of Building Materials: Bricks','Monthly','fisdba', now() );

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
( 4, '0074', 'Monthly Survey of Building Materials: Bricks', '201803', '999912','fisdba', now() );

Insert Into dev01.Question
(
    Survey,
    QuestionCode,
    CreatedBy,
    CreatedDate
)
Values

( '0074', '0001', 'fisdba', now()),
( '0074', '0011', 'fisdba', now()),
( '0074', '0021', 'fisdba', now()),
( '0074', '0501', 'fisdba', now()),
( '0074', '0002', 'fisdba', now()),
( '0074', '0012', 'fisdba', now()),
( '0074', '0022', 'fisdba', now()),
( '0074', '0502', 'fisdba', now()),
( '0074', '0003', 'fisdba', now()),
( '0074', '0013', 'fisdba', now()),
( '0074', '0023', 'fisdba', now()),
( '0074', '0503', 'fisdba', now()),
( '0074', '0004', 'fisdba', now()),
( '0074', '0014', 'fisdba', now()),
( '0074', '0024', 'fisdba', now()),
( '0074', '0504', 'fisdba', now()),
( '0074', '8000', 'fisdba', now()),
( '0074', '0145', 'fisdba', now()),
( '0074', '0146', 'fisdba', now()),
( '0074', '9004', 'fisdba', now()),
( '0074', '9014', 'fisdba', now()),
( '0074', '9024', 'fisdba', now()),
( '0074', '9501', 'fisdba', now()),
( '0074', '9502', 'fisdba', now()),
( '0074', '9503', 'fisdba', now());


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

( 4, '0001', 'Q001', 'Opening Stock Commons', 1, 'NUMERIC', '', 'fisdba', now() ),
( 4, '0011', 'Q011', 'Opening Stock Facings', 2, 'NUMERIC', '', 'fisdba', now() ),
( 4, '0021', 'Q021', 'Opening Stock Engineering', 3, 'NUMERIC', '', 'fisdba', now() ),
( 4, '0501', 'Q501', 'Total opening Stock', 4, 'NUMERIC', '', 'fisdba', now() ),
( 4, '0002', 'Q002', 'Drawn from kiln during month Commons', 5, 'NUMERIC', '', 'fisdba', now() ),
( 4, '0012', 'Q012', 'Drawn from kiln during month Facings', 6, 'NUMERIC', '', 'fisdba', now() ),
( 4, '0022', 'Q022', 'Drawn from kiln during month Engineering', 7, 'NUMERIC', '', 'fisdba', now() ),
( 4, '0502', 'Q502', 'Total drawn from kiln during month', 8, 'NUMERIC', '', 'fisdba', now() ),
( 4, '0003', 'Q003', 'Deliveries to customer during month Commons', 9, 'NUMERIC', '', 'fisdba', now() ),
( 4, '0013', 'Q013', 'Deliveries to customer during month Facings', 10, 'NUMERIC', '', 'fisdba', now() ),
( 4, '0023', 'Q023', 'Deliveries to customer during month Engineering', 11, 'NUMERIC', '', 'fisdba', now() ),
( 4, '0503', 'Q503', 'Total deliveries to customer during month', 12, 'NUMERIC', '', 'fisdba', now() ),
( 4, '0004', 'Q004', 'Closing Stock Commons', 13, 'NUMERIC', '', 'fisdba', now() ),
( 4, '0014', 'Q014', 'Closing Stock Facings', 14, 'NUMERIC', '', 'fisdba', now() ),
( 4, '0024', 'Q024', 'Closing Stock Engineering', 15, 'NUMERIC', '', 'fisdba', now() ),
( 4, '0504', 'Q504', 'Total Closing Stock', 16, 'NUMERIC', '', 'fisdba', now() ),
( 4, '8000', 'Q8000','Brick type (Clay - 2, Concrete - 3, Sandlyme - 4)', 17, 'NUMERIC', '', 'fisdba', now()),
( 4, '9004', 'Q9004', 'Derived Commons opening stock + production - deliveries (Q001 + Q002 - Q003)', 18, 'NUMERIC', '0001 + 0002 - 0003', 'fisdba', now() ),
( 4, '9014', 'Q9014', 'Derived Facings opening stock + production - deliveries (Q011 + Q012 - Q013)', 19, 'NUMERIC', '0011 + 0012 - 0013', 'fisdba', now() ),
( 4, '9024', 'Q9024', 'Derived sum of opening stocks (Q001 + Q011 + Q021)', 20, 'NUMERIC', '0001 + 0011 + 0021', 'fisdba', now() ),
( 4, '9501', 'Q9501', 'Derived sum of productions (Q002 + Q012 + Q022)', 21, 'NUMERIC', '0002 + 0012 + 0022', 'fisdba', now() ),
( 4, '9502', 'Q9502', 'Derived sum of deliveries (Q003 + Q013 + Q023)', 22, 'NUMERIC', '0003 + 0013 + 0023', 'fisdba', now() ),
( 4, '9503', 'Q9503', 'Derived sum of closing stocks (Q004 + Q014 + Q024)', 23, 'NUMERIC', '0004 + 0014 + 0024', 'fisdba', now() ),
( 4, '0145', 'Q145', 'New works brought into use since date of last return', 24, 'NUMERIC', '', 'fisdba', now() ),
( 4, '0146', 'Q146', 'Comment on the figures included in your return', 25, 'TICKBOX-Yes', '', 'fisdba', now() );


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
    (7410,4,'POPQVQ','0001','0','W',current_user,now()),
    (7411,4,'POPQVQ','0011','0','W',current_user,now()),
    (7412,4,'POPQVQ','0021','0','W',current_user,now()),

    (7420,4,'POPM','0002','0','W',current_user,now()),
    (7421,4,'POPM','0012','0','W',current_user,now()),
    (7422,4,'POPM','0022','0','W',current_user,now()),
    (7423,4,'POPM','0003','0','W',current_user,now()),
    (7424,4,'POPM','0013','0','W',current_user,now()),
    (7425,4,'POPM','0023','0','W',current_user,now()),
    (7426,4,'POPM','0004','0','W',current_user,now()),
    (7427,4,'POPM','0014','0','W',current_user,now()),
    (7428,4,'POPM','0024','0','W',current_user,now()),

    (7430,4,'QVDQ','0004','0','W',current_user,now()),
    (7431,4,'QVDQ','0014','0','W',current_user,now()),
    (7432,4,'QVDQ','0024','0','W',current_user,now()),
    (7433,4,'QVDQ','0501','0','W',current_user,now()),
    (7434,4,'QVDQ','0502','0','W',current_user,now()),
    (7435,4,'QVDQ','0503','0','W',current_user,now()),
    (7436,4,'QVDQ','0504','0','W',current_user,now()),

    (7440,4,'CPBMI','0145','1','E',current_user,now()),
    (7441,4,'CPBMI','0146','1','E',current_user,now() );


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

( 7410, 'Default', 'Default', 'question', '0001', 'response', 0, current_user, now() ),
( 7410, 'Default', 'Default', 'comparison_question', '0004', 'response', 1, current_user, now() ),

( 7411, 'Default', 'Default', 'question', '0011', 'response', 0, current_user, now() ),
( 7411, 'Default', 'Default', 'comparison_question', '0014', 'response', 1, current_user, now() ),

( 7412, 'Default', 'Default', 'question', '0021', 'response', 0, current_user, now() ),
( 7412, 'Default', 'Default', 'comparison_question', '0024', 'response', 1, current_user, now() ),

( 7420, 'Default', 'Default', 'question', '0002', 'response', 0, current_user, now() ),
( 7420, 'Default', 'Default', 'comparison_question', '0002', 'response', 1, current_user, now() ),
( 7420, 'Default', 'Default', 'threshold', '1000000', '', 0, current_user, now() ),

( 7421, 'Default', 'Default', 'question', '0012', 'response', 0, current_user, now() ),
( 7421, 'Default', 'Default', 'comparison_question', '0012', 'response', 1, current_user, now() ),
( 7421, 'Default', 'Default', 'threshold', '1000000', '', 0, current_user, now() ),

( 7422, 'Default', 'Default', 'question', '0022', 'response', 0, current_user, now() ),
( 7422, 'Default', 'Default', 'comparison_question', '0022', 'response', 1, current_user, now() ),
( 7422, 'Default', 'Default', 'threshold', '1000000', '', 0, current_user, now() ),

( 7423, 'Default', 'Default', 'question', '0003', 'response', 0, current_user, now() ),
( 7423, 'Default', 'Default', 'comparison_question', '0003', 'response', 1, current_user, now() ),
( 7423, 'Default', 'Default', 'threshold', '1000000', '', 0, current_user, now() ),

( 7424, 'Default', 'Default', 'question', '0013', 'response', 0, current_user, now() ),
( 7424, 'Default', 'Default', 'comparison_question', '0013', 'response', 1, current_user, now() ),
( 7424, 'Default', 'Default', 'threshold', '1000000', '', 0, current_user, now() ),

( 7425, 'Default', 'Default', 'question', '0023', 'response', 0, current_user, now() ),
( 7425, 'Default', 'Default', 'comparison_question', '0023', 'response', 1, current_user, now() ),
( 7425, 'Default', 'Default', 'threshold', '1000000', '', 0, current_user, now() ),

( 7426, 'Default', 'Default', 'question', '0004', 'response', 0, current_user, now() ),
( 7426, 'Default', 'Default', 'comparison_question', '0004', 'response', 1, current_user, now() ),
( 7426, 'Default', 'Default', 'threshold', '1000000', '', 0, current_user, now() ),

( 7427, 'Default', 'Default', 'question', '0014', 'response', 0, current_user, now() ),
( 7427, 'Default', 'Default', 'comparison_question', '0014', 'response', 1, current_user, now() ),
( 7427, 'Default', 'Default', 'threshold', '1000000', '', 0, current_user, now() ),

( 7428, 'Default', 'Default', 'question', '0024', 'response', 0, current_user, now() ),
( 7428, 'Default', 'Default', 'comparison_question', '0024', 'response', 1, current_user, now() ),
( 7428, 'Default', 'Default', 'threshold', '1000000', '', 0, current_user, now() ),

( 7430, 'Default', 'Default', 'question', '0004', 'response', 0, current_user, now() ),
( 7430, 'Default', 'Default', 'comparison_question', '9004', 'response', 0, current_user, now() ),

( 7431, 'Default', 'Default', 'question', '0014', 'response', 0, current_user, now() ),
( 7431, 'Default', 'Default', 'comparison_question', '9014', 'response', 0, current_user, now() ),

( 7432, 'Default', 'Default', 'question', '0024', 'response', 0, current_user, now() ),
( 7432, 'Default', 'Default', 'comparison_question', '9024', 'response', 0, current_user, now() ),

( 7433, 'Default', 'Default', 'question', '0501', 'response', 0, current_user, now() ),
( 7433, 'Default', 'Default', 'comparison_question', '9501', 'response', 0, current_user, now() ),

( 7434, 'Default', 'Default', 'question', '0502', 'response', 0, current_user, now() ),
( 7434, 'Default', 'Default', 'comparison_question', '9502', 'response', 0, current_user, now() ),

( 7435, 'Default', 'Default', 'question', '0503', 'response', 0, current_user, now() ),
( 7435, 'Default', 'Default', 'comparison_question', '9503', 'response', 0, current_user, now() ),

( 7436, 'Default', 'Default', 'question', '0504', 'response', 0, current_user, now() ),
( 7436, 'Default', 'Default', 'comparison_question', '9504', 'response', 0, current_user, now() ),

( 7440, 'Default', 'Default', 'question', '0145', 'response', 0, current_user, now() ),

( 7441, 'Default', 'Default', 'question', '0146', 'response', 0, current_user, now() );






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

(   '49900229065', '201905', '0074', 4, 'Form Sent Out', now(), '0004', 'T', '70110', '70110', '41100', '41100', 750, 748, 100, 100, 100, 100, 99999, 99999, '9900229065', '2993511516', 1, 'S', '326935020502', '2135632144542', '97395797', 178, 0, 0, '1', 'E', 'NP', '07/08/2019', 'Jones, Banks and Hall', 'Bell LLC', '9 Thompson drive, East Harry, Wales', 'L2T 0PR', 'Sole Trader', 'Dennis Edwards', '01633 5551234', '', 'P', '', 'fisdba', now() ),
(   '49900356828', '201905', '0074', 4, 'Form Sent Out', now(), '0004', 'T', '70110', '70110', '41100', '41100', 25, 25, 22, 22, 22, 22, 12345, 12345, '9900356828', '2921377360', 1, 'S', '423279595848', '9446786207965', '55841012', 71, 0, 0, '1', 'E', 'BS', '21/03/2019', 'Hunter, Coles and Turnbull', 'Savage, Parkinson and Wright', '526 Amber estates, Denisfort, Wales', 'N60 6TL', 'Sole Trader', 'Jacob Thorpe', '0117 9555123', '', 'P', '', 'fisdba', now() ),
(   '49900423293', '201905', '0074', 4, 'Form Sent Out', now(), '0004', 'F', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900423293', '2962684174', 1, 'S', '979024265812', '3101057635557', '74239110', 2, 0, 0, '1', 'E', 'CF', '06/09/1995', 'Curtis LLC', 'Ford PLC', '36 Giles corners, Watershaven, Scotland', 'L8 9QE', 'Franchise', 'Gillian Bailey', '029 20555123', '', 'P', '', 'fisdba', now() ),
(   '49900423920', '201905', '0074', 4, 'Form Sent Out', now(), '0004', 'S', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900423920', '2993702519', 1, 'S', '650195077639', '5864180611950', '94403544', 7, 1, 0, '1', 'E', 'CF', '19/03/1973', 'Wilson-Chapman', 'Jones LLC', '2 Brown keys, Kellyhaven, England', 'CM4B 6UR', '', 'Anthony Wilson', '01633 5559912', '', 'P', '', 'fisdba', now() ),
(   '49900449878', '201905', '0074', 4, 'Form Sent Out', now(), '0004', 'M', '70110', '70110', '41100', '41100', 750, 748, 100, 100, 100, 100, 99999, 99999, '9900449878', '2910550332', 1, 'S', '898038558701', '2690058876978', '69059744', 6, 1, 0, '1', 'E', 'NP', '31/01/1977', 'Barrett Group', 'Hutchinson, Daly and Pritchard', '17 Evans junction, Newport, UK', 'NP10 1AA', '', 'Arthur Knowles-Gallagher', '01633 5551234', '', 'P', '', 'fisdba', now() ),

(   '49900229065', '201906', '0074', 4, 'Form Sent Out', now(), '0004', 'T', '70110', '70110', '41100', '41100', 750, 748, 100, 100, 100, 100, 99999, 99999, '9900229065', '2993511516', 1, 'S', '326935020502', '2135632144542', '97395797', 178, 0, 0, '1', 'E', 'NP', '07/08/2019', 'Jones, Banks and Hall', 'Bell LLC', '9 Thompson drive, East Harry, Wales', 'L2T 0PR', 'Sole Trader', 'Dennis Edwards', '01633 5551234', '', 'P', '', 'fisdba', now() ),
(   '49900356828', '201906', '0074', 4, 'Form Sent Out', now(), '0004', 'T', '70110', '70110', '41100', '41100', 25, 25, 22, 22, 22, 22, 12345, 12345, '9900356828', '2921377360', 1, 'S', '423279595848', '9446786207965', '55841012', 71, 0, 0, '1', 'E', 'BS', '21/03/2019', 'Hunter, Coles and Turnbull', 'Savage, Parkinson and Wright', '526 Amber estates, Denisfort, Wales', 'N60 6TL', 'Sole Trader', 'Jacob Thorpe', '0117 9555123', '', 'P', '', 'fisdba', now() ),
(   '49900423293', '201906', '0074', 4, 'Form Sent Out', now(), '0004', 'F', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900423293', '2962684174', 1, 'S', '979024265812', '3101057635557', '74239110', 2, 0, 0, '1', 'E', 'CF', '06/09/1995', 'Curtis LLC', 'Ford PLC', '36 Giles corners, Watershaven, Scotland', 'L8 9QE', 'Franchise', 'Gillian Bailey', '029 20555123', '', 'P', '', 'fisdba', now() ),
(   '49900423920', '201906', '0074', 4, 'Form Sent Out', now(), '0004', 'S', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900423920', '2993702519', 1, 'S', '650195077639', '5864180611950', '94403544', 7, 1, 0, '1', 'E', 'CF', '19/03/1973', 'Wilson-Chapman', 'Jones LLC', '2 Brown keys, Kellyhaven, England', 'CM4B 6UR', '', 'Anthony Wilson', '01633 5559912', '', 'P', '', 'fisdba', now() ),
(   '49900449878', '201906', '0074', 4, 'Form Sent Out', now(), '0004', 'M', '70110', '70110', '41100', '41100', 750, 748, 100, 100, 100, 100, 99999, 99999, '9900449878', '2910550332', 1, 'S', '898038558701', '2690058876978', '69059744', 6, 1, 0, '1', 'E', 'NP', '31/01/1977', 'Barrett Group', 'Hutchinson, Daly and Pritchard', '17 Evans junction, Newport, UK', 'NP10 1AA', '', 'Arthur Knowles-Gallagher', '01633 5551234', '', 'P', '', 'fisdba', now() );






Insert Into dev01.Survey
(
    survey,
    description,
    periodicity,
    CreatedBy,
    CreatedDate
)
Values

( '0076','Quarterly Survey of Building Materials Sand and Gravel Marine','Quarterly','fisdba', now() );

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
( 2, '0076', 'Quarterly Survey of Building Materials Sand and Gravel Marine', '201803', '999912','fisdba', now() );

Insert Into dev01.Question
(
    Survey,
    QuestionCode,
    CreatedBy,
    CreatedDate
)
Values

( '0076', '0601', 'fisdba', now()),
( '0076', '0602', 'fisdba', now()),
( '0076', '0603', 'fisdba', now()),
( '0076', '0604', 'fisdba', now()),
( '0076', '0605', 'fisdba', now()),
( '0076', '0606', 'fisdba', now()),
( '0076', '0607', 'fisdba', now()),
( '0076', '0608', 'fisdba', now()),
( '0076', '0148', 'fisdba', now()),
( '0076', '0146', 'fisdba', now()),
( '0076', '9001', 'fisdba', now());


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
( 2, '0148', 'Q148', 'New ports of landing brought into use since date of last return', 9, 'NUMERIC', '', 'fisdba', now() ),
( 2, '0146', 'Q146', 'Comment on the figures included in your return', 10, 'NUMERIC', '', 'fisdba', now() ),
( 2, '9001', 'Q9001', 'Derived Total of all sand and gravel (Q601 + Q602 + Q603 + Q604 + Q605 + Q606 + Q607)', 11, 'NUMERIC', '0601 + 0602 + 0603 + 0604 + 0605 + 0606 + 0607', 'fisdba', now() );


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
    (7610,2,'POPM','0601','0','W',current_user,now()),
    (7611,2,'POPM','0602','0','W',current_user,now()),
    (7612,2,'POPM','0603','0','W',current_user,now()),
    (7613,2,'POPM','0604','0','W',current_user,now()),
    (7614,2,'POPM','0605','0','W',current_user,now()),
    (7615,2,'POPM','0606','0','W',current_user,now()),
    (7616,2,'POPM','0607','0','W',current_user,now()),

    (7620,2,'POPZC','0601','0','E',current_user,now()),
    (7621,2,'POPZC','0602','0','E',current_user,now()),
    (7622,2,'POPZC','0603','0','E',current_user,now()),
    (7623,2,'POPZC','0604','0','E',current_user,now()),
    (7624,2,'POPZC','0605','0','E',current_user,now()),
    (7625,2,'POPZC','0606','0','E',current_user,now()),
    (7626,2,'POPZC','0607','0','E',current_user,now()),

    (7630,2,'CPBMI','0146','1','E',current_user,now()),

    (7640,2,'CPBMI','0148','1','E',current_user,now()),

    (7650,2,'QVDQ','0608','0','W',current_user,now());


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
( 7610, 'Default', 'Default', 'question', '0601', 'response', 0, current_user, now() ),
( 7610, 'Default', 'Default', 'comparison_question', '0601', 'response', 1, current_user, now() ),
( 7610, 'Default', 'Default', 'threshold', '20000', '', 0, current_user, now() ),

( 7611, 'Default', 'Default', 'question', '0602', 'response', 0, current_user, now() ),
( 7611, 'Default', 'Default', 'comparison_question', '0602', 'response', 1, current_user, now() ),
( 7611, 'Default', 'Default', 'threshold', '20000', '', 0, current_user, now() ),

( 7612, 'Default', 'Default', 'question', '0603', 'response', 0, current_user, now() ),
( 7612, 'Default', 'Default', 'comparison_question', '0603', 'response', 1, current_user, now() ),
( 7612, 'Default', 'Default', 'threshold', '20000', '', 0, current_user, now() ),

( 7613, 'Default', 'Default', 'question', '0604', 'response', 0, current_user, now() ),
( 7613, 'Default', 'Default', 'comparison_question', '0604', 'response', 1, current_user, now() ),
( 7613, 'Default', 'Default', 'threshold', '20000', '', 0, current_user, now() ),

( 7614, 'Default', 'Default', 'question', '0605', 'response', 0, current_user, now() ),
( 7614, 'Default', 'Default', 'comparison_question', '0605', 'response', 1, current_user, now() ),
( 7614, 'Default', 'Default', 'threshold', '20000', '', 0, current_user, now() ),

( 7615, 'Default', 'Default', 'question', '0606', 'response', 0, current_user, now() ),
( 7615, 'Default', 'Default', 'comparison_question', '0606', 'response', 1, current_user, now() ),
( 7615, 'Default', 'Default', 'threshold', '20000', '', 0, current_user, now() ),

( 7616, 'Default', 'Default', 'question', '0607', 'response', 0, current_user, now() ),
( 7616, 'Default', 'Default', 'comparison_question', '0607', 'response', 1, current_user, now() ),
( 7616, 'Default', 'Default', 'threshold', '20000', '', 0, current_user, now() ),

( 7620, 'Default', 'Default', 'question', '0601', 'response', 0, current_user, now() ),
( 7620, 'Default', 'Default', 'comparison_question', '0601', 'response', 1, current_user, now() ),
( 7620, 'Default', 'Default', 'threshold', '0', '', 0, current_user, now() ),

( 7621, 'Default', 'Default', 'question', '0602', 'response', 0, current_user, now() ),
( 7621, 'Default', 'Default', 'comparison_question', '0602', 'response', 1, current_user, now() ),
( 7621, 'Default', 'Default', 'threshold', '0', '', 0, current_user, now() ),

( 7622, 'Default', 'Default', 'question', '0603', 'response', 0, current_user, now() ),
( 7622, 'Default', 'Default', 'comparison_question', '0603', 'response', 1, current_user, now() ),
( 7622, 'Default', 'Default', 'threshold', '0', '', 0, current_user, now() ),

( 7623, 'Default', 'Default', 'question', '0604', 'response', 0, current_user, now() ),
( 7623, 'Default', 'Default', 'comparison_question', '0604', 'response', 1, current_user, now() ),
( 7623, 'Default', 'Default', 'threshold', '0', '', 0, current_user, now() ),

( 7624, 'Default', 'Default', 'question', '0605', 'response', 0, current_user, now() ),
( 7624, 'Default', 'Default', 'comparison_question', '0605', 'response', 1, current_user, now() ),
( 7624, 'Default', 'Default', 'threshold', '0', '', 0, current_user, now() ),

( 7625, 'Default', 'Default', 'question', '0606', 'response', 0, current_user, now() ),
( 7625, 'Default', 'Default', 'comparison_question', '0606', 'response', 1, current_user, now() ),
( 7625, 'Default', 'Default', 'threshold', '0', '', 0, current_user, now() ),

( 7626, 'Default', 'Default', 'question', '0607', 'response', 0, current_user, now() ),
( 7626, 'Default', 'Default', 'comparison_question', '0607', 'response', 1, current_user, now() ),
( 7626, 'Default', 'Default', 'threshold', '0', '', 0, current_user, now() ),

( 7630, 'Default', 'Default', 'question', '0146', 'response', 0, current_user, now() ),

( 7640, 'Default', 'Default', 'question', '0148', 'response', 0, current_user, now() ),

( 7650, 'Default', 'Default', 'question', '0608', 'response', 0, current_user, now() ),
( 7650, 'Default', 'Default', 'comparison_question', '9001', 'response', 0, current_user, now() );






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

(   '49900004791', '201903', '0076', 2, 'Form Sent Out', now(), '0004', 'T', '70110', '70110', '41100', '41100', 750, 748, 100, 100, 100, 100, 99999, 99999, '9900049237', '2993498317', 1, 'S', '326935020502', '2135632144542', '97395797', 178, 0, 0, '1', 'E', 'NP', '29/10/1986', 'Tucker, Byrne and Johnson', 'O Connor LLC', '4 Powell ridges, East Harry, Wales', 'E2A 0LF', 'Sole Trader', 'Stanley Patel', '01633 5551234', '', 'P', '', 'fisdba', now() ),
(   '49900049245', '201903', '0076', 2, 'Form Sent Out', now(), '0004', 'F', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900049245', '2927338249', 1, 'S', '979024265812', '3101057635557', '74239110', 2, 0, 0, '1', 'E', 'CF', '02/01/2003', 'Evans and Sons', 'Thompson, Herbert and Gordon', '403 Robinson glens, Watershaven, Scotland', 'L8 9QE', 'Franchise', 'Jayne Bailey', '029 20555123', '', 'P', '', 'fisdba', now() ),
(   '49900064408', '201903', '0076', 2, 'Form Sent Out', now(), '0004', 'S', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900064408', '2928418033', 1, 'S', '650195077639', '5864180611950', '94403544', 7, 1, 0, '1', 'E', 'CF', '04/02/1995', 'Akhtar Inc', 'Thomas Ltd', '1 Jonathan oval, Kellyhaven, England', 'CM4B 6UR', '', 'Rosemary Campbell', '01633 5559912', '', 'P', '', 'fisdba', now() ),
(   '49900112631', '201903', '0076', 2, 'Form Sent Out', now(), '0004', 'M', '70110', '70110', '41100', '41100', 750, 748, 100, 100, 100, 100, 99999, 99999, '9900112631', '2914590325', 1, 'S', '898038558701', '2690058876978', '69059744', 6, 1, 0, '1', 'E', 'NP', '21/02/1980', 'Lord PLC', 'McDonald LLC', '9 Douglas shores, Newport, UK', 'NP10 1AA', '', 'Bethany Williams', '01633 5551234', '', 'P', '', 'fisdba', now() ),
(   '49900113580', '201903', '0076', 2, 'Form Sent Out', now(), '0004', 'G', '70110', '70110', '41100', '41100', 25, 25, 22, 22, 22, 22, 12345, 12345, '9900113580', '2995323877', 1, 'S', '149294328171', '3660987585937', '23670278', 0, 0, 0, '1', 'E', 'BS', '12/08/1995', 'Stevens-Talbot', 'Johnson, Nicholson and Thompson', '8 Evans knoll, North Elaineton, England', 'FK31 7WJ', '', 'Tony Cook', '0117 9555123', '', 'P', '', 'fisdba', now() ),


(   '49900004791', '201906', '0076', 2, 'Form Sent Out', now(), '0004', 'T', '70110', '70110', '41100', '41100', 750, 748, 100, 100, 100, 100, 99999, 99999, '9900049237', '2993498317', 1, 'S', '326935020502', '2135632144542', '97395797', 178, 0, 0, '1', 'E', 'NP', '29/10/1986', 'Tucker, Byrne and Johnson', 'O Connor LLC', '4 Powell ridges, East Harry, Wales', 'E2A 0LF', 'Sole Trader', 'Stanley Patel', '01633 5551234', '', 'P', '', 'fisdba', now() ),
(   '49900049245', '201906', '0076', 2, 'Form Sent Out', now(), '0004', 'F', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900049245', '2927338249', 1, 'S', '979024265812', '3101057635557', '74239110', 2, 0, 0, '1', 'E', 'CF', '02/01/2003', 'Evans and Sons', 'Thompson, Herbert and Gordon', '403 Robinson glens, Watershaven, Scotland', 'L8 9QE', 'Franchise', 'Jayne Bailey', '029 20555123', '', 'P', '', 'fisdba', now() ),
(   '49900064408', '201906', '0076', 2, 'Form Sent Out', now(), '0004', 'S', '70110', '70110', '41100', '41100', 111, 1112, 100, 100, 100, 100, 99999, 99999, '9900064408', '2928418033', 1, 'S', '650195077639', '5864180611950', '94403544', 7, 1, 0, '1', 'E', 'CF', '04/02/1995', 'Akhtar Inc', 'Thomas Ltd', '1 Jonathan oval, Kellyhaven, England', 'CM4B 6UR', '', 'Rosemary Campbell', '01633 5559912', '', 'P', '', 'fisdba', now() ),
(   '49900112631', '201906', '0076', 2, 'Form Sent Out', now(), '0004', 'M', '70110', '70110', '41100', '41100', 750, 748, 100, 100, 100, 100, 99999, 99999, '9900112631', '2914590325', 1, 'S', '898038558701', '2690058876978', '69059744', 6, 1, 0, '1', 'E', 'NP', '21/02/1980', 'Lord PLC', 'McDonald LLC', '9 Douglas shores, Newport, UK', 'NP10 1AA', '', 'Bethany Williams', '01633 5551234', '', 'P', '', 'fisdba', now() ),
(   '49900113580', '201906', '0076', 2, 'Form Sent Out', now(), '0004', 'G', '70110', '70110', '41100', '41100', 25, 25, 22, 22, 22, 22, 12345, 12345, '9900113580', '2995323877', 1, 'S', '149294328171', '3660987585937', '23670278', 0, 0, 0, '1', 'E', 'BS', '12/08/1995', 'Stevens-Talbot', 'Johnson, Nicholson and Thompson', '8 Evans knoll, North Elaineton, England', 'FK31 7WJ', '', 'Tony Cook', '0117 9555123', '', 'P', '', 'fisdba', now() );
