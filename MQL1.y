%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>


int yylex(void);


int noOfLines(char* filename){

    const char ext[] = ".txt";
	char *fname = malloc(strlen(filename) + strlen(ext) + 1);
	strcpy(fname, filename);
	strcat(fname, ext);
    FILE *fp;
    fp = fopen(fname, "r");

    char* line = NULL;
    size_t len = 0;
    ssize_t read;
    int no=0;   
     while ((read = getline(&line, &len, fp)) != -1) {
        no++;
    }

    fclose(fp);
    return no;
}


char *multi_tok(char input[], char *delimiter) {
    static char *string;
    if (input != NULL)
        string = input;

    if (string == NULL)
        return string;

    char *end = strstr(string, delimiter);
    if (end == NULL) {
        char *temp = string;
        string = NULL;
        return temp;
    }

    char *temp = string;

    *end = '\0';
    string = end + strlen(delimiter);
    // printf("%s\n", temp);
    return temp;
}


char *mult1_tok(char input[], char *delimiter) {
    static char *string;
    if (input != NULL)
        string = input;

    if (string == NULL)
        return string;

    char *end = strstr(string, delimiter);
    if (end == NULL) {
        char *temp = string;
        string = NULL;
        return temp;
    }

    char *temp = string;

    *end = '\0';
    string = end + strlen(delimiter);
    // printf("%s\n", temp);
    return temp;
}


char *mult2_tok(char input[], char *delimiter) {
    static char *string;
    if (input != NULL)
        string = input;

    if (string == NULL)
        return string;

    char *end = strstr(string, delimiter);
    if (end == NULL) {
        char *temp = string;
        string = NULL;
        return temp;
    }

    char *temp = string;

    *end = '\0';
    string = end + strlen(delimiter);
    // printf("%s\n", temp);
    return temp;
}

int* getRowID(const char* filename, char* fieldname, char* op, char* val){

	const char ext[] = ".txt";
	char *fname = malloc(strlen(filename) + strlen(ext) + 1);
	strcpy(fname, filename);
	strcat(fname, ext);
 
	FILE *fp; 
	fp = fopen(fname, "r");

    char* line = NULL;
    size_t len = 0;
    ssize_t read;

    int op_id, col_id;

    if (strcmp(filename, "EMP") == 0){
    	int* row = malloc(100 * sizeof(int));
    	for(int i = 0; i < 100; i++) {
			row[i] = 0;
		}
    	// int row[100] = {0};
    	char* field[] = {"eid", "ename", "eage", "eaddress", "salary", "deptno"};
    	for(int i = 0; i < 6; i++) {
    		if(strcmp(fieldname, field[i]) == 0) {
    			col_id = i;
    			break;
    		}
    	}

    	int row_id = 0;
        while ((read = getline(&line, &len, fp)) != -1) {

        	line[strcspn(line, "\n")] = '\0';
            // printf("%s", line);
            char* values = strtok(line, ", ");
            int ind = 0;
            while(values != NULL){

            	if(ind == col_id) {
            		if(strcmp(op, "=") == 0) {
            			if(strcmp(values, val) == 0) {
            				row[row_id] = 1;
            			}
            		}            		    	
        		    else if(strcmp(op, "<=") == 0) {
        		    	if(col_id == 1 || col_id == 3) {
        		    		printf("Column values cannot be compared\n");
        		    	}
        		    	else if(col_id == 0 || col_id == 2 || col_id == 5) {
        		    		int val1 = atoi(values);
        		    		int comp = atoi(val);

        		    		if(val1 <= comp) {
        		    			row[row_id] = 1;
        		    		}

        		    	}
        		    	else if(col_id == 4) {
        		    		float val1 = atof(values);
        		    		float comp = atof(val);

        		    		if(val1 <= comp) {
        		    			row[ind] = 1;
        		    		}

        		    	}
        		    }
        		    else if(strcmp(op, ">=") == 0) {
        		    	if(col_id == 1 || col_id == 3) {
        		    		printf("Column values cannot be compared\n");
        		    	}
        		    	else if(col_id == 0 || col_id == 2 || col_id == 5) {
        		    		int val1 = atoi(values);
        		    		int comp = atoi(val);

        		    		if(val1 >= comp) {
        		    			row[row_id] = 1;
        		    		}

        		    	}
        		    	else if(col_id == 4) {
        		    		float val1 = atof(values);
        		    		float comp = atof(val);

        		    		if(val1 >= comp) {
        		    			row[row_id] = 1;
        		    		}

        		    	}
        		    }
        		    else if(strcmp(op, "<") == 0) {
        		    	if(col_id == 1 || col_id == 3) {
        		    		printf("Column values cannot be compared\n");
        		    	}
        		    	else if(col_id == 0 || col_id == 2 || col_id == 5) {
        		    		int val1 = atoi(values);
        		    		int comp = atoi(val);

        		    		if(val1 < comp) {
        		    			row[row_id] = 1;
        		    		}

        		    	}
        		    	else if(col_id == 4) {
        		    		float val1 = atof(values);
        		    		float comp = atof(val);

        		    		if(val1 < comp) {
        		    			row[row_id] = 1;
        		    		}

        		    	}
        		    }
        		    else if(strcmp(op, ">") == 0) {
        		    	if(col_id == 1 || col_id == 3) {
        		    		printf("Column values cannot be compared\n");
        		    	}
        		    	else if(col_id == 0 || col_id == 2 || col_id == 5) {
        		    		int val1 = atoi(values);
        		    		int comp = atoi(val);

        		    		if(val1 > comp) {
        		    			row[row_id] = 1;
        		    		}

        		    	}
        		    	else if(col_id == 4) {
        		    		float val1 = atof(values);
        		    		float comp = atof(val);

        		    		if(val1 > comp) {
        		    			row[row_id] = 1;
        		    		}

        		    	}
        		    }
        		    else if(strcmp(op, "!=") == 0) {
        		    	if(strcmp(values, val) != 0) {
            				row[row_id] = 1;
            			}
        		    }
            	} 
        		printf("%s ", values);
            	values = strtok(NULL, ", ");
            	ind++;
            }
            printf("\n");
            row_id++;
        }

        for(int i = 0; i < 100; i++) {
        	printf("%d ", row[i]);
        }
        printf("**************************************************\n");
        fclose(fp);
    	return row;
    }

    // else if (strcmp(filename, "DEPT") == 0){
    // 	char* field[] = {"dnum", "dname", "dlocation"};
    // 	for(int i = 0; i < 3; i++) {
    // 		if(strcmp(fieldname, field[i]) == 0) {
    // 			col_id = i;
    // 			break;
    // 		}
    // 	}

    // }
	fclose(fp);

}



int* intersect(int old_row[100], int new_row[100]) {
	for(int i = 0; i < 100; i++) {
		new_row[i] = old_row[i] * new_row[i];
	}
	return new_row;
}
int* or(int old_row[100], int new_row[100]) {
	for(int i = 0; i < 100; i++) {
		if(old_row[i] == 1 || new_row[i] == 1)
			new_row[i] = 1;
		else
			new_row[i] = 0;
	}
	return new_row;
}

int* and_condition(char cond_str[]) {
	int* row = malloc(100 * sizeof(int));
	for(int i = 0; i < 100; i++) {
		row[i] = 1;
	}
	// int row[100] = {0};
    char* values = mult1_tok(cond_str, " AND ");
    while(values != NULL){
		printf("%s\n", values);


    	char* fieldname = NULL;
    	char* op = NULL;
    	char* val = NULL;
    	int temp=0;
    	char* cond = strtok(values, " ");
    	while(cond != NULL){
    		printf("%s=================================\n", cond);
    		if (temp==0)
    			fieldname = cond;
    		else if (temp == 1)
    			op = cond;
    		else if (temp == 2)
    			val = cond;
    		cond = strtok(NULL, " ");
    		temp++;
    	}
    	int *row1 = getRowID("EMP", fieldname, op, val);
    	printf("Inside Inside \n");
	    for (int i=0; i<100; i++){
			printf("%d ",row1[i]);
		}
		printf("\n");
		for (int i=0; i<100; i++){
			printf("%d ",row[i]);
		}
    	row = intersect(row, row1);
    	values = mult1_tok(NULL, " AND ");

    }
    printf("Inside \n");
    for (int i=0; i<100; i++){
		printf("%d ",row[i]);
	}
    return row;
}

int* condition(char cond_str[]) {
	int* row = malloc(100 * sizeof(int));
	for(int i = 0; i < 100; i++) {
		row[i] = 0;
	}
	// int row[100] = {0};
    char* values = multi_tok(cond_str, " OR ");
    while(values != NULL){
		printf("%s----------------------------------------\n", values);
		// char arg[100];
		// strcpy(arg, values);
		row = or(row, and_condition(values));
    	values = multi_tok(NULL, " OR ");

    }
    return row;
}



void insert(const char* filename, char* val_list){
	const char ext[] = ".txt";
	char *fname = malloc(strlen(filename) + strlen(ext) + 1);
	strcpy(fname, filename);
	strcat(fname, ext);

	FILE *fp; 
	fp = fopen(fname, "a+");

	fputs("\n(", fp);
	fputs(val_list, fp);
	fputs(")", fp);
	
	fclose(fp);
}


void get(char* filename, char* field_list, char* cond){

    const char ext[] = ".txt";
    char *fname = malloc(strlen(filename) + strlen(ext) + 1);
    strcpy(fname, filename);
    strcat(fname, ext);

    int n = noOfLines(filename);
    int* row;
    row = (int*)malloc(n * sizeof(int));
    if(cond == NULL) {
        for(int i = 0; i < n; i++) {
            row[i] = 1;
        }
    }
    else {
       row = condition(cond);
    }


    int size = 0;
    char** val_list = (char**) malloc(sizeof(char*)*50);
    for(int i=0; i<50; i++){
        val_list[i] = (char*) malloc(sizeof(char)*10);
    }

    char* vals = strtok(field_list, ", ");
    while(vals!=NULL){
        strcpy(val_list[size], vals);
        vals = strtok(NULL, ", ");
        size++;
    }


    if (strcmp(filename, "EMP") == 0){

        int par[6]={0};
        int k,i;
        char* field[] = {"eid", "ename", "eage", "eaddress", "salary", "deptno"};

        for(k=0;k<size;k++){
            for( i = 0; i < 6; i++) {
                if(strcmp(val_list[k], field[i]) == 0) {
                    par[i]=1;
                }
            }
        }

        FILE *fp;
        fp = fopen(fname, "r");

        char* line = NULL;
        size_t len = 0;
        ssize_t read;
        int row_ind=0;   
         while ((read = getline(&line, &len, fp)) != -1) {

            line[strcspn(line, "\n")] = '\0';
            // printf("%s", line);
            int col_ind = 0;
            char* values = strtok(line, ", ");
            while(values!=NULL){
                if(par[col_ind]==1  && row[row_ind]==1){
                    printf("%s",values);
                }
                values = strtok(NULL, ", ");
                col_ind++;
            }
            printf("\n");
            row_ind++;
         }



    }
    else if(strcmp(filename, "DEPT") == 0){

        int par[3]={0};
        int i,k;
        char* field[] = {"dnum","dname","dloc"};

        for(k=0;k<size;k++){
            for( i = 0; i < 3; i++) {
                if(strcmp(val_list[k], field[i]) == 0) {
                    par[i]=1;
                }
            }
        }


        FILE *fp;
        fp = fopen(fname, "r");

        char* line = NULL;
        size_t len = 0;
        ssize_t read;

        int row_ind=0;   
        while ((read = getline(&line, &len, fp)) != -1) {

            line[strcspn(line, "\n")] = '\0';
            // printf("%s", line);
            int col_ind = 0;
            char* values = strtok(line, ", ");
            while(values!=NULL){
                if(par[col_ind]==1  && row[row_ind]==1){
                    printf("%s",values);
                }
                values = strtok(NULL, ", ");
                col_ind++;
            }
            printf("\n");
            row_ind++;
         }

    }

}


void update(char* filename,char* parameter,char* newval, char* cond){

    const char ext[] = ".txt";
	char *fname = malloc(strlen(filename) + strlen(ext) + 1);
	strcpy(fname, filename);
	strcat(fname, ext);

	int n = noOfLines(filename);
    int* row;
    row = (int*)malloc(n * sizeof(int));
    if(cond == NULL) {
        for(int i = 0; i < n; i++) {
            row[i] = 1;
        }
    }
    else {
	   row = condition(cond);
    }
    
    if (strcmp(filename, "EMP") == 0){

    	int par[6]={0};
        int i;
    	char* field[] = {"eid", "ename", "eage", "eaddress", "salary", "deptno"};

    	
	    for( i = 0; i < 6; i++) {
	    	if(strcmp(parameter, field[i]) == 0) {
	    		par[i]=1;
	    	}
	    }
	    

        FILE *fp;
	    fp = fopen(fname, "r");

	    FILE *fptr2 = fopen("replica.txt", "w");

        char* line = NULL;
        size_t len = 0;
        ssize_t read;
        int row_ind=0;   
         while ((read = getline(&line, &len, fp)) != -1) {

	        line[strcspn(line, "\n")] = '\0';
	        // printf("%s", line);
	        int col_ind = 0;
	        char* values = strtok(line, ", ");
            do{	

                if(par[col_ind]==1  && row[row_ind]==1 && col_ind==0){
	            	fprintf(fptr2,"%s",newval);
	            }
	            else if(par[col_ind]==1  && row[row_ind]==1){
	            	fprintf(fptr2,", %s",newval);
	            }
	            else if(col_ind==0)
	            	fprintf(fptr2,"%s",values);
	            else 
	            	fprintf(fptr2,", %s",values);
                col_ind++;
                values = strtok(NULL, ", ");
            }while(values!=NULL);

            fprintf(fptr2,"\n");
            row_ind++;
        }

        fclose(fp);
        fclose(fptr2);
        remove(fname);
        //rename the file replica.c to original name
        rename("replica.txt", fname);

    }
    else if(strcmp(filename, "DEPT") == 0){

        int par[3]={0};
        int i,k;
    	char* field[] = {"dnum","dname","dloc"};

    	for( i = 0; i < 6; i++) {
	    	if(strcmp(parameter, field[i]) == 0) {
	    		par[i]=1;
	    	}
	    }


        FILE *fp;
	    fp = fopen(fname, "r");
        FILE *fptr2 = fopen("replica.txt", "w");

        char* line = NULL;
        size_t len = 0;
        ssize_t read;
  
        int row_ind=0;   
        while ((read = getline(&line, &len, fp)) != -1) {

	        line[strcspn(line, "\n")] = '\0';
	        // printf("%s", line);
	        int col_ind = 0;
	        char* values = strtok(line, ", ");
	        do{	

	            if(par[col_ind]==1  && row[row_ind]==1 && col_ind==0){
	            	fprintf(fptr2,"%s",newval);
	            }
	            else if(par[col_ind]==1  && row[row_ind]==1){
	            	fprintf(fptr2,",%s",newval);
	            }
	            else if(col_ind==0)
	            	fprintf(fptr2,"%s",values);
	            else 
	            	fprintf(fptr2,",%s",values);
                col_ind++;
                values = strtok(NULL, ", ");
            }while(values!=NULL);
            // while(values!=NULL){	            
	           //  if(par[col_ind]==1  && row[row_ind]==1){
	           //  	fprintf(fptr2,"%s,",newval);
	           //  }
	           //  else
	           //  	fprintf(fptr2,"%s,",values);
            //     col_ind++;
            //     values = strtok(NULL, ", ");
            // }
            fprintf(fptr2,"\n");
            row_ind++;
         }

    
        fclose(fp);
        fclose(fptr2);
        remove(fname);
        //rename the file replica.c to original name
        rename("replica.txt", fname); 


    }


}

%}
 %union {
    int intval;              /* Constant integer value */
    float floatval;               /* Constant floating point value */
    char *str;              /* Ptr to constant string (strings are malloc'd) */
};

%token <str> FILENAME   
%token GET FROM WHERE AND OR
%token UPDATE RECORD IN SET TO
%token DELETE
%token INSERT INTO 
%token <str> STRING INT FLT EFIELD DFIELD COMP
%type <str> val 
%type <str> val_list 
%type <str> fieldname 
%type <str> fieldname_list 
%type <str> expr_list 
%type <str> expr 
%type <str> get_fieldname_list

%%

stmt_list : stmt ';'

stmt : get_stmt
	 | update_stmt
	 | delete_stmt
	 | insert_stmt
	 ;

get_stmt : GET get_fieldname_list FROM FILENAME                         {printf("%s %s\n", $2, $4); get($4, $2, NULL);}	
         | GET get_fieldname_list FROM FILENAME WHERE expr_list         {printf("%s %s %s\n", $2, $4, $6); get($4, $2, $6);}
		 ;

update_stmt : UPDATE RECORD IN FILENAME SET fieldname TO val                    {printf("%s %s %s\n", $4, $6, $8); update($4, $6, $8, NULL);}
            | UPDATE RECORD IN FILENAME SET fieldname TO val WHERE expr_list    {printf("%s %s %s %s\n", $4, $6, $8, $10); update($4, $6, $8, $10);}
			;

delete_stmt : DELETE RECORD FROM FILENAME                       {printf("%s\n", $4); del($4, NULL);}
            | DELETE RECORD FROM FILENAME WHERE expr_list       {printf("%s %s\n", $4, $6); del($4, )}
			;

insert_stmt : INSERT RECORD '(' val_list ')' INTO FILENAME {printf("%s %s\n", $4, $7); insert($7, $4);}

get_fieldname_list : fieldname_list 	{strcpy($$, $1);}
				   | '*' 				{;}
				   ;

fieldname_list : fieldname 	{strcpy($$, $1);}
			  | fieldname ',' fieldname_list 	{strcpy($$, $1);strcat($$, ", ");strcat($$, $3);}
			  ;

expr_list : expr AND expr_list 		{strcpy($$, $1); strcat($$, " AND "); strcat($$, $3);}
		  | expr OR expr_list		{strcpy($$, $1); strcat($$, " OR "); strcat($$, $3);}
		  | expr 					{strcpy($$, $1);}
		  ;

expr : fieldname COMP val 	{strcpy($$, $1); strcat($$, " "); strcat($$, $2); strcat($$, " "); strcat($$, $3);}
	 ;

fieldname : EFIELD 	{strcpy($$, $1);}
		  | DFIELD 	{strcpy($$, $1);}
		  ;

val_list : val {strcpy($$, $1);}
		 | val ',' val_list {strcpy($$, $1);strcat($$, ", ");strcat($$, $3);}
		 ; 

val : '\'' STRING '\'' {strcpy($$, $2);}
	| '\"' STRING '\"' {strcpy($$, $2);}
	| INT {printf("%s\n", $1); strcpy($$, $1);}
	| FLT {strcpy($$, $1);}
	;


%%

int main(){
	printf("Enter the expression:\n");
	if(!(yyparse()))
		printf("Query is valid\n");
	else
		printf("Query is invalid\n");
}