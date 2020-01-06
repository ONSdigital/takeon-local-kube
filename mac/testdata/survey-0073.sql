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
    (7321,3,'POPZC','0104','0','E',current_user,now()),
    (7322,3,'POPZC','0114','0','E',current_user,now()),
    (7323,3,'POPZC','0114','0','E',current_user,now()),
    (7324,3,'POPZC','0124','0','E',current_user,now()),
    (7325,3,'POPZC','0124','0','E',current_user,now()),

    (7330,3,'VP','0145','0','E',current_user,now()),
    (7331,3,'VP','0146','0','E',current_user,now()),

    (7340,3,'POPQVQ','0101','0','W',current_user,now()),
    (7341,3,'POPQVQ','0101','0','W',current_user,now()),

    (7350,3,'QVDQ','0104','0','W',current_user,now()),
    (7351,3,'QVDQ','0114','0','W',current_user,now())
    (7352,3,'QVDQ','0608','0','W',current_user,now());


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
( 7350, 'Default', 'Default', 'comparison_question', '0104', 'response', 1, current_user, now() ),
( 7320, 'Default', 'Default', 'question', '0104', 'response', 0, current_user, now() ),
( 7320, 'Default', 'Default', 'comparison_question', '0104', 'response', 1, current_user, now() ),
( 7320, 'Default', 'Default', 'threshold', '0', '', 0, current_user, now() ),
( 7321, 'Default', 'Default', 'question', '0104', 'response', 0, current_user, now() ),
( 7321, 'Default', 'Default', 'comparison_question', '0104', 'response', 1, current_user, now() ),
( 7321, 'Default', 'Default', 'threshold', '0', '', 0, current_user, now() ),

( 7351, 'Default', 'Default', 'question', '0114', 'response', 0, current_user, now() ),
( 7351, 'Default', 'Default', 'comparison_question', '0114', 'response', 1, current_user, now() ),
( 7322, 'Default', 'Default', 'question', '0114', 'response', 0, current_user, now() ),
( 7322, 'Default', 'Default', 'comparison_question', '0114', 'response', 1, current_user, now() ),
( 7322, 'Default', 'Default', 'threshold', '0', '', 0, current_user, now() ),
( 7323, 'Default', 'Default', 'question', '0114', 'response', 0, current_user, now() ),
( 7323, 'Default', 'Default', 'comparison_question', '0114', 'response', 1, current_user, now() ),
( 7323, 'Default', 'Default', 'threshold', '0', '', 0, current_user, now() ),

( 7342, 'Default', 'Default', 'question', '0121', 'response', 0, current_user, now() ),
( 7342, 'Default', 'Default', 'comparison_question', '0121', 'response', 1, current_user, now() ),

( 7314, 'Default', 'Default', 'question', '0122', 'response', 0, current_user, now() ),
( 7314, 'Default', 'Default', 'comparison_question', '0122', 'response', 1, current_user, now() ),
( 7314, 'Default', 'Default', 'threshold', '10000', '', 0, current_user, now() ),

( 7315, 'Default', 'Default', 'question', '0123', 'response', 0, current_user, now() ),
( 7315, 'Default', 'Default', 'comparison_question', '0123', 'response', 1, current_user, now() ),
( 7315, 'Default', 'Default', 'threshold', '10000', '', 0, current_user, now() ),

( 7352, 'Default', 'Default', 'question', '0114', 'response', 0, current_user, now() ),
( 7352, 'Default', 'Default', 'comparison_question', '0114', 'response', 1, current_user, now() ),
( 7324, 'Default', 'Default', 'question', '0114', 'response', 0, current_user, now() ),
( 7324, 'Default', 'Default', 'comparison_question', '0114', 'response', 1, current_user, now() ),
( 7324, 'Default', 'Default', 'threshold', '0', '', 0, current_user, now() ),
( 7325, 'Default', 'Default', 'question', '0114', 'response', 0, current_user, now() ),
( 7325, 'Default', 'Default', 'comparison_question', '0114', 'response', 1, current_user, now() ),
( 7325, 'Default', 'Default', 'threshold', '0', '', 0, current_user, now() ),

( 7330, 'Default', 'Default', 'question', '0145', 'response', 0, current_user, now() ),

( 7331, 'Default', 'Default', 'question', '0146', 'response', 0, current_user, now() );
