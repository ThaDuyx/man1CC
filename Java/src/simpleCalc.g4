grammar simpleCalc;

simpleCalcLanguage  : (cm+=commands)* (wl+=while_loop)* (is+=if_state)* e=expr EOF
                    ;

commands            : x=ID EQ e=expr SC
                    ;

function            : com=commands                                                      # Command
                    | exp=expr                                                          # Express
                    ;

functions           : (funs+=function)+
                    ;

while_loop          : WHILE PAR1 (cond=conditions) PAR2 fun=functions                   # While
                    ;

if_state            : IF PAR1 (cond=conditions) PAR2 fun=functions                      # If
                    | IF PAR1 (cond=conditions) PAR2 fun1=functions ELSE fun2=functions # Ifelse
                    ;

conditions          : e1=expr LESS e2=expr                                              # Less
                    | e1=expr GREAT e2=expr                                             # Great
                    | e1=expr GREATEQ e2=expr                                           # GreatEQ
                    | e1=expr LESSEQ e2=expr                                            # LessEQ
                    | e1=expr EQEQ e2=expr                                              # EQ2x
                    | e1=expr NOTEQ e2=expr                                             # NotEQ
                    | cond1=conditions AND cond2=conditions                             # And
                    | cond1=conditions OR cond2=conditions                              # Or
                    | EXMARK PAR1 cond=conditions PAR2                                  # Not
                    ;

expr	            : x=ID		                                                        # Variable
                    | c=FLOAT     	                                                    # Constant
                    | e1=expr op=OPTWO e2=expr                                          # Multiplication
                    | e1=expr op=OPONE e2=expr                                          # Addition
                    | PAR1 e=expr PAR2                                                  # Parenthesis
                    | op=OPONE f=FLOAT                                                  # SignedConstant
                    ;

ID                  : ALPHA (ALPHA|NUM)*                        ;
FLOAT               : NUM+ ('.' NUM+)?                          ;
ALPHA               : [a-zA-Z_ÆØÅæøå]                           ;
NUM                 : [0-9]                                     ;
WHITESPACE          : [ \n\t\r]+ -> skip                        ;
COMMENT             : '//'~[\n]*  -> skip                       ;
COMMENT2            : '/*' (~[*] | '*'~[/]  )*   '*/'  -> skip  ;
WHILE               : 'while'                                   ;
IF                  : 'if'                                      ;
ELSEIF              : 'else if'                                 ;
ELSE                : 'else'                                    ;
EQ                  : '='                                       ;
PAR1                : '('                                       ;
PAR2                : ')'                                       ;
LESS                : '>'                                       ;
LESSEQ              : '>='                                      ;
GREAT               : '<'                                       ;
GREATEQ             : '<='                                      ;
EQEQ                : '=='                                      ;
NOTEQ               : '!='                                      ;
AND                 : '&&'                                      ;
OR                  : '||'                                      ;
SC                  : ';'                                       ;
EXMARK              : '!'                                       ;
OPONE               : '+' | '-'                                 ;
OPTWO               : '*' | '/'                                 ;
