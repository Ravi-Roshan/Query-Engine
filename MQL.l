%{
#include <stdio.h>
#include "y.tab.h"
/* write lex and yacc program to check validity of an exp. which contains +,-,*,/ */	
%}

%%

GET {return GET;}
INSERT {return INSERT;}
UPDATE {return UPDATE;}
DELETE {return DELETE;}

RECORD {return RECORD;}
FROM {return FROM;}
WHERE {return WHERE;}
INTO {return INTO;}
SET {return SET;}
IN {return IN;}
TO {return TO;}

AND {return AND;}
OR {return OR;}

EMP|DEPT {yylval.str = strdup(yytext);return FILENAME;}
eid|ename|eage|eaddress|salary|deptno {yylval.str = strdup(yytext); return EFIELD;}
dnum|dname|dlocation {yylval.str = strdup(yytext); return DFIELD;}

(!=|<=|>=|<|>|=) {
					yylval.str = strdup(yytext);
					return COMP;
				}
[A-Za-z_][0-9A-Za-z_$]* {yylval.str = strdup(yytext); return STRING;}
-?[1-9]+[0-9]*"."[0-9]+ {yylval.str = strdup(yytext); return FLT;}
-?[1-9]+[0-9]* {yylval.str = strdup(yytext); return INT;}

[*(),;'"] {return yytext[0];}
[ ] {;}
\n	{return 0;}	

%%