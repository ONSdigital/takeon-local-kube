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
