grammar simpleCalc;

simpleCalcLanguage  : (as+=assignments)* (wl+=while_loop)* (ie+=if_statements)* (e=expr)* EOF
                    ;

while_loop          : WHILE PAR1 (c=conditions) PAR2 assignments #While
                    ;

if_statements       : IF PAR1 (c=conditions) PAR2 as=assignments
                    | IF PAR1 (c=conditions) PAR2 as=assignments (ELSEIF PAR1 (c=conditions) PAR2 as=assignments)* (ELSE as=assignments)
                    ;

assignments         : x=ID '=' e=expr
                    ;

conditions          : e1=expr '<' e2=expr  # Bigger
                    | e1=expr '<=' e2=expr # BiggerOrEqual
                    | e1=expr '>' e2=expr  # Less
                    | e1=expr '>=' e2=expr # LessOrEqual
                    | e1=expr '==' e2=expr # Equals
                    | e1=expr '!=' e2=expr # NotEqual
                    | e1=expr '<=' e2=expr # BiggerOrEqual
                    | '!' '(' c1=conditions ')'   # Not
                    | e1=conditions '&&' e2=conditions # And
                    | e1=conditions '||' e2=conditions # Or
                    ;

expr	            : c = FLOAT x=ID        #NMA
                    | c=FLOAT     	     # Constant
                    | x=ID		         # Variable
                    | e1=expr opmulti=OPTWO e2=expr # Multiplication
                    | e1=expr op=OPONE e2=expr # Addition
                    | '(' e=expr ')'     # Parenthesis
                    | op=OPONE f=FLOAT      # SignedConstant
                    ;

WHILE       : 'while'   ;
IF          : 'if'      ;
ELSEIF      : 'else if' ;
ELSE        : 'else'    ;
EQUALS      : '='       ;

ID          : ALPHA (ALPHA|NUM)* ;
FLOAT       : NUM+ ('.' NUM+)? ;

ALPHA       : [a-zA-Z_ÆØÅæøå] ;
NUM         : [0-9] ;

PAR1        : '('   ;
PAR2        : ')'   ;

GREATER     : '<'   ;
SEMICOLON   : ';'   ;

OPONE         : '+' | '-';
OPTWO         : '*' | '/';

WHITESPACE  : [ \n\t\r]+ -> skip;
COMMENT     : '//'~[\n]*  -> skip;
COMMENT2    : '/*' (~[*] | '*'~[/]  )*   '*/'  -> skip;

/*start   : (as+=assign)* e=expr EOF ;

assign  : x=ID '=' e=expr        ;




ALPHA : [a-zA-Z_ÆØÅæøå] ;
NUM   : [0-9] ;
*/

/*parse
 : block EOF
 ;

block
 : stat*
 ;

stat
 : assignment
 | if_stat
 | while_stat
 | log
 | OTHER {System.err.println("unknown char: " + $OTHER.text);}
 ;

assignment
 : ID ASSIGN expr SCOL
 ;

if_stat
 : IF condition_block (ELSE IF condition_block)* (ELSE stat_block)?
 ;

condition_block
 : expr stat_block
 ;

stat_block
 : OBRACE block CBRACE
 | stat
 ;

while_stat
 : WHILE expr stat_block
 ;

log
 : LOG expr SCOL
 ;

expr
 : expr POW<assoc=right> expr           #powExpr
 | MINUS expr                           #unaryMinusExpr
 | NOT expr                             #notExpr
 | expr op=(MULT | DIV | MOD) expr      #multiplicationExpr
 | expr op=(PLUS | MINUS) expr          #additiveExpr
 | expr op=(LTEQ | GTEQ | LT | GT) expr #relationalExpr
 | expr op=(EQ | NEQ) expr              #equalityExpr
 | expr AND expr                        #andExpr
 | expr OR expr                         #orExpr
 | atom                                 #atomExpr
 ;

atom
 : OPAR expr CPAR #parExpr
 | (INT | FLOAT)  #numberAtom
 | (TRUE | FALSE) #booleanAtom
 | ID             #idAtom
 | STRING         #stringAtom
 | NIL            #nilAtom
 ;

OR : '||';
AND : '&&';
EQ : '==';
NEQ : '!=';
GT : '>';
LT : '<';
GTEQ : '>=';
LTEQ : '<=';
PLUS : '+';
MINUS : '-';
MULT : '*';
DIV : '/';
MOD : '%';
POW : '^';
NOT : '!';

SCOL : ';';
ASSIGN : '=';
OPAR : '(';
CPAR : ')';
OBRACE : '{';
CBRACE : '}';

TRUE : 'true';
FALSE : 'false';
NIL : 'nil';
IF : 'if';
ELSE : 'else';
WHILE : 'while';
LOG : 'log';

ID
 : [a-zA-Z_] [a-zA-Z_0-9]*
 ;

INT
 : [0-9]+
 ;

FLOAT
 : [0-9]+ '.' [0-9]*
 | '.' [0-9]+
 ;

STRING
 : '"' (~["\r\n] | '""')* '"'
 ;

COMMENT
 : '#' ~[\r\n]* -> skip
 ;

SPACE
 : [ \t\r\n] -> skip
 ;

OTHER
 : .
 ;*/