#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// void update(){



// }


int* getRowID(const char* filename, char* fieldname, char* op, char* val){

	const char ext[] = ".txt";
	char *fname = malloc(strlen(filename) + strlen(ext) + 1);
	strcpy(fname, filename);
	strcat(fname, ext);
 
	FILE *fp; 
	fp = fopen(fname, "r");

	int* rows = malloc(100 * sizeof(int)); 

    char* line = NULL;
    size_t len = 0;
    ssize_t read;

    int op_id, col_id;

    if (strcmp(filename, "EMP") == 0){
    	int row[100] = {0};
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
        printf("\n");
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


void insert(const char* filename, char* val_list[], int n){

	const char ext[] = ".txt";
	char *fname = malloc(strlen(filename) + strlen(ext) + 1);
	strcpy(fname, filename);
	strcat(fname, ext);

	FILE *fp; 
	fp = fopen(fname, "a+");

	fputs("\n(", fp);
	for(int i=0; i<n-1; i++){
		fputs(val_list[i], fp);
		fputs(", ", fp);
	}
	fputs(val_list[n-1], fp);
	fputs(")", fp);
	
	fclose(fp);

}


// void del(){



// }


// void get(char* filename){



// }
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

void disp(const char* filename, char* fieldname, char* op, char* val) {
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
    	
        while ((read = getline(&line, &len, fp)) != -1) {

        	line[strcspn(line, "\n")] = '\0';
            // printf("%s", line);
            char* values = strtok(line, "Hyderabad");
            int ind = 0;
            while(values != NULL){
            
        		printf("%s", values);
            	values = strtok(NULL, "Hyderabad");
            }
            printf("\n");
        }
    }

}


void condition(char cond_str[]) {
    char* values = strtok(cond_str, "OR ");
    while(values != NULL){
		printf("%s\n", values);
    	values = strtok(NULL, "OR ");
    }
}

int main(){

	char* new_data[] = {"105", "Ravi", "40", "Chennai", "50000", "15"};
	int n = sizeof(new_data) / sizeof(new_data[0]);
	// insert("EMP", new_data, n);
	// getRowID("EMP", "ename", "=", "Ravi");
	// char str[] = "eid > 10 AND ename = 50 OR salary >= 10000 AND eid = 11";
	disp("EMP", "ename", "=", "Ravi");
	// condition(str);
	return 0;
}