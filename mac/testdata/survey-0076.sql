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
( 2, '0146', 'Q146', 'Comment on the figures included in your return', 10, 'TICKBOX-Yes', '', 'fisdba', now() ),
( 2, '9001', 'Q9001', 'Derived Total of all sand and gravel (Q601 + Q602 + Q603 + Q604 + Q605 + Q606 + Q607)', 11, 'TICKBOX-Yes', '0601 + 0602 + 0603 + 0604 + 0605 + 0606 + 0607', 'fisdba', now() );


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

    (7630,2,'VP','0147','0','E',current_user,now()),

    (7640,2,'VP','0147','0','E',current_user,now()),

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

( 7640, 'Default', 'Default', 'question', '0147', 'response', 0, current_user, now() ),

( 7650, 'Default', 'Default', 'question', '0608', 'response', 0, current_user, now() ),
( 7650, 'Default', 'Default', 'comparison_question', '9001', 'response', 0, current_user, now() );
