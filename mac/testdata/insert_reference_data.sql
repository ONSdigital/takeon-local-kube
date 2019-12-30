
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
( 'POPQVQ','Period on Period Q Vs Q','question != comparison_question',current_user,now()),
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
    ('POPQVQ',0,current_user,now()),
    ('POPQVQ',1,current_user,now()),
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
