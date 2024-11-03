grammar cal;

program
    : decl_list function_list main
;

decl_list
    : (decl SEMI decl_list) |
;

decl
    : var_decl | const_decl
;

var_decl
    : VARIABLE IDENTIFIER COLON type
;

const_decl
    : CONSTANT IDENTIFIER COLON type ASSIGN expression
;

function_list
    : (function function_list | )
;

function
    : type IDENTIFIER LBR parameter_list RBR IS decl_list BEGIN
      statement_block RETURN LBR (expression | )RBR SEMI END
;

type
    : INT | BOOL | VOID
;

parameter_list
    : nemp_parameter_list |
;

nemp_parameter_list
    : IDENTIFIER COLON type | IDENTIFIER COLON type COMMA
      nemp_parameter_list
;

main
    : MAIN BEGIN decl_list statement_block END
;

statement_block
    : (statement statement_block) |
;

statement
    : IDENTIFIER ASSIGN expression SEMI
      | IDENTIFIER LBR arg_list RBR SEMI
      | BEGIN statement_block END
      | IF condition BEGIN statement_block END
      ELSE BEGIN statement_block END
      | WHILE condition BEGIN statement_block END
      | SKIPPY SEMI
;

expression
    : NEGATE expression
    | MINUS expression
    | expression binary_arith_op expression
    | expression comp_op expression
    | expression AND expression
    | expression OR expression
    | IDENTIFIER ASSIGN expression
    | LBR expression RBR
    | IDENTIFIER LBR arg_list RBR
    | IDENTIFIER
    | MINUS IDENTIFIER
    | INTEGER
    | TRUE
    | FALSE
;

binary_arith_op
    : PLUS | MINUS
;

condition
    : NEGATE condition
    | LBR condition RBR
    | expression comp_op expression
    | condition (OR | AND) condition
;

comp_op
    : EQUALS
    | NOTEQUALS
    | LESSTHAN
    | LESSTHANOREQUALTO
    | GREATERTHAN
    | GREATERTHANOREQUALTO
;

arg_list
    : (nemp_arg_list) |
;

nemp_arg_list
    : IDENTIFIER
    | IDENTIFIER COMMA nemp_arg_list
;

// Case insensitivity
fragment A : [aA];
fragment B : [bB];
fragment C : [cC];
fragment D : [dD];
fragment E : [eE];
fragment F : [fF];
fragment G : [gG];
fragment H : [hH];
fragment I : [iI];
fragment J : [jJ];
fragment K : [kK];
fragment L : [lL];
fragment M : [mM];
fragment N : [nN];
fragment O : [oO];
fragment P : [pP];
fragment Q : [qQ];
fragment R : [rR];
fragment S : [sS];
fragment T : [tT];
fragment U : [uU];
fragment V : [vV];
fragment W : [wW];
fragment X : [xX];
fragment Y : [yY];
fragment Z : [zZ];

// Reserved words
VARIABLE : V A R I A B L E;
CONSTANT : C O N S T A N T;
RETURN   : R E T U R N;
INT      : I N T;
BOOL     : B O O L;
VOID     : V O I D;
MAIN     : M A I N;
IF       : I F;
ELSE     : E L S E;
TRUE     : T R U E;
FALSE    : F A L S E;
WHILE    : W H I L E;
BEGIN    : B E G I N;
END      : E N D;
IS       : I S;
SKIPPY   : S K I P;

// Operators
COMMA: ',';
SEMI: ';';
COLON: ':';
ASSIGN: ':=';
LBR: '(';
RBR: ')';
PLUS: '+';
MINUS: '-';
NEGATE: '~';
OR: '|';
AND: '&';
EQUALS: '=';
NOTEQUALS: '!=';
LESSTHAN: '<';
LESSTHANOREQUALTO: '<=';
GREATERTHAN: '>';
GREATERTHANOREQUALTO: '>=';

// Comments
BLOCKCOMMENT : '/*' (BLOCKCOMMENT | .)*? '*/' -> skip;
LINECOMMENT  : '//' ~[\r\n]* -> skip;

INTEGER : '-'? ( '0' | [1-9] [0-9]*);

IDENTIFIER  : [a-zA-Z] ([a-zA-Z] | [0-9] | '_')*;

WS          : [ \t\n\r]+ -> skip;

