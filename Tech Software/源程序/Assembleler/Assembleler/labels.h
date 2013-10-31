#ifndef LABELS_H
#define LABELS_H
#include<string.h>
#include<malloc.h>
#include<stdio.h>
#include<stdlib.h>

enum InstType{b,beqz,bnez,bteqz,btnez,others};

struct Inst
{
	 int pc;
	 unsigned short code;
	 char* label;
	 char* tagName;
    enum InstType type;
	 struct Inst* next;
};

struct Table
{
	 struct Inst* instruction;
	 struct Table* next;
};

struct Inst* Instructions;
struct Table* labelList;
struct Table* tagList;

void Reverse()
{
	 struct Inst* head=0;
	 struct Inst* temp=0;
	 while (Instructions) {
		  temp=Instructions;
		  Instructions=Instructions->next;
		  temp->next=head;
		  head=temp;		  
    }
	 Instructions=head;
}

void insert(int add,short bin,enum InstType InstType,char* tag,char* dest)
{
	 struct Inst* instruction=(struct Inst*)malloc(sizeof(struct Inst));
	 instruction->pc=add;
	 instruction->code=bin;
	 instruction->type=InstType;
	 instruction->label=(char*)malloc(strlen(tag)+1);
	 memset(instruction->label,'\0',strlen(tag)+1);
	 strcpy(instruction->label,tag);
	 instruction->tagName=(char*)malloc(strlen(dest)+1);
	 memset(instruction->tagName,'\0',strlen(dest)+1);
	 strcpy(instruction->tagName,dest);
	 instruction->next=Instructions;
	 Instructions=instruction;
	 if (strcmp(tag,"")!=0){
		  struct Table* table=(struct Table*)malloc(sizeof(struct Table));
		  table->instruction=instruction;
         table->next=labelList;
		  labelList=table;		  
    }
	 if (strcmp(dest,"")!=0) {
		  struct Table* table=(struct Table*)malloc(sizeof(struct Table));
		  table->instruction=instruction;
		  table->next=tagList;
		  tagList=table;
	 }
	 memset(tag,'\0',100);
	 memset(dest,'\0',100);
}

void fillCode(struct Inst* src,struct Inst* dest)
{
  short temp=(short)((dest->pc-src->pc)-1);
  if (src->type==b) {
	(src->code)|=(temp&0x7ff);
  }else {
	if (src->type!=others) {
	  (src->code)|=(temp&0xff);
	}
  }
}

void fill()
{
	 struct Table* table=tagList;
	 while (table) {
		  struct Table* it=labelList;
		  while (it) {
			   if (strcmp(it->instruction->label,
						  table->instruction->tagName)==0) {
					break;
			   }
              it=it->next;
		  }

		   if (it!=NULL) {
			 fillCode(table->instruction,it->instruction);
		   }else{
				printf("%s is unsolved.\n",table->instruction->tagName);
				exit(1);
		   }
		   	  	   
		  table=table->next;
	 }
}

void writeToFile(FILE* output){
  while(Instructions){
	fwrite(&(Instructions->code),sizeof(Instructions->code),1,output);
	//printf("code=%4x\n",Instructions->code);
	//printf("%d\n",sizeof(short));
	Instructions=Instructions->next;
  }
}

#endif
