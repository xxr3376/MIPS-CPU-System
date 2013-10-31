#include <cstdio>
#include <cstdlib>
#include <winsock.h>
#include <windows.h>
#include<string.h>
#include <cstring>
#include <conio.h>
#include<iostream>
using namespace std;

#pragma comment(lib, "ws2_32.lib")

const int SCRN_X = 80;
const int SCRN_Y = 100;
const int asm_total=48;
const int LimitConsoleBuffer = 4096;
char com_name[] = "COM0";
HANDLE com = INVALID_HANDLE_VALUE;
SOCKET client;
FILE *load_file;
struct AsmID
{
	char *name;
	int id;
};
AsmID RegsList[] = {
	{"R0",0},
	{"R1",1},
	{"R2",2},
	{"R3",3},
	{"R4",4},
	{"R5",5},
	{"R6",6},
	{"R7",7}
};

struct TASM
{
	char* name;
	int code;
	int x,y,z;
};
const struct TASM const_asm[] = {
	{"ADDSP3",1793,63743,65280,65535},
	{"B",4096,63488,65535,65535},
	{"BEQZ",9984,63743,65280,65535},
	{"BNEZ",12032,63743,65280,65535},
	{"SLL",14308,63743,65311,65507},
	{"SRL",14310,63743,65311,65507},
	{"SRA",14311,63743,65311,65507},
	{"ADDIU3",18400,63743,65311,65520},
	{"ADDIU",20224,63743,65280,65535},
	{"SLTI",22272,63743,65280,65535},
	{"SLTUI",24321,63743,65280,65535},
	{"BTEQZ",24576,65280,65535,65535},
	{"BTNEZ",24832,65280,65535,65535},
	{"SW_RS",25089,65280,65535,65535},
	{"ADDSP",25344,65280,65535,65535},
	{"MTSP",25824,65311,65535,65535},
	{"MOVE",32736,63743,65311,65535},  //changed by chenyong
	{"LI",28417,63743,65280,65535},
	{"CMPI",30465,63743,65280,65535},
	{"LW_SP",38657,63743,65280,65535},
	{"LW",40929,63743,65311,65504},
	{"SW_SP",55041,63743,65280,65535},
	{"SW",57313,63743,65311,65504},
	{"ADDU",59389,63743,65311,65507},
	{"SUBU",59391,63743,65311,65507},
	{"JR",61184,63743,65535,65535},
	{"MFHI",61200,63743,65535,65535},
	{"MFLO",61202,63743,65535,65535},
	{"MFPC",61248,63743,65535,65535},
	{"SLT",61410,63743,65311,65535},
	{"SLTU",61411,63743,65311,65535},
	{"SLLV",61412,63743,65311,65535},
	{"SRLV",61414,63743,65311,65535},
	{"SRAV",61415,63743,65311,65535},
	{"CMP",61418,63743,65311,65535},
	{"NEG",61419,63743,65311,65535},
	{"AND",61420,63743,65311,65535},
	{"OR",61421,63743,65311,65535},
	{"XOR",61422,63743,65311,65535},
	{"NOT",61423,63743,65311,65535},
	{"MULT",61432,63743,65311,65535},
	{"MULTU",61433,63743,65311,65535},
	{"DIV",61434,63743,65311,65535},
	{"DIVU",61435,63743,65311,65535},
	{"NOP",2048,65535,65535,65535,},
	{"INT",63489,65520,65535,65535},
	{"MFIH",63232,63743,65535,65535},
	{"MTIH",63233,63743,65535,65535}
};
char* get_hex(unsigned short num)
{
	char hex[4];
	int i,j;
	for (i=0;i<4;i++)
	{
		j = ((num & 0xF000) >> 12);
		num = (num << 4);
		if (j < 10)
			hex[i]=(char)(j+48);
		else hex[i]=(char)(j+55);
	}
	return hex;

}
int  pc_decode(unsigned short code)
{

	char* argv[64];
	const struct TASM *p = const_asm;
	int i;
	unsigned short j ,k;
	for (i=0;i<asm_total;i++)
	{
		j = ((*p).code & (*p).x & (*p).y & (*p).z); 
		k = (code & (*p).x & (*p).y & (*p).z);
		if (j == k)
			break;
		p ++;
	}
	printf("  <%04x>    ",code);
	
	if (i == asm_total)	{
		printf("--- UNKNOWN ---  ");		
		cout<<endl;
		return -1;
	}

	int argc=0;
	printf(" %s",(*p).name);	
	//strcpy(argv[argc],(*p).name);
	//argc++;
	unsigned short regs[3];
	unsigned short num;
	num=0x0000;
	regs[0] = ~(*p).x;
	regs[1] = ~(*p).y;
	regs[2] = ~(*p).z;
	for (i=0;i<3;i++)
	{
		if (regs[i] != 0)
		{
			k = (regs[i] & (*p).code);
			num = (regs[i] & code);
			if (regs[i] == k)
			{
				while ((regs[i] & 1) == 0)
				{
					num = (num >> 1);
					regs[i] = (regs[i] >> 1);
				}
				printf(" R%d",num);	
				//argv[argc][0]='R';
				//argv[argc][1]=num+'0';
				//argc++;
			}
			else if (k == 0)
			{
				while ((regs[i] & 1) == 0)
				{
					num = (num >> 1);
					regs[i] = (regs[i] >> 1);
				}
				j = ~regs[i];
				if ((num & (j >> 1)) != 0)
					num = (num | j);
				printf(" %04x",num);
				//strcpy(argv[argc],get_hex(num));
				//argc++;
			}
			else
			{
				while ((regs[i] & 1) == 0)
				{
					num = (num >> 1);
					regs[i] = (regs[i] >> 1);
				}
				printf(" %04x",num);
				//strcpy(argv[argc],get_hex(num));
				//argc++;
			}
		}//end  if(reg[i]!=0)
	}//end for 
	cout<<endl;
	return 0;
}

int get_regs_id(char argv[])
{
	if (strlen(argv) != 2)
		return -1;
	for (int i=0;i<8;i++)
	{
		if (strcmp(argv,RegsList[i].name) == 0)
			return RegsList[i].id;
	}
	//printf("%s",argv);
	return -1;
}
short get_value(char *s)   //将一个以字符串形式表示的数（十六进制）转换成整数形式，空串或形式有误都会使error = 1
{
	if (s[0] == 0)
	{
		cout<<"字符串输入为空错误"<<endl;
		return 0xFFFF;
	}
	short i, value;
	value = 0;
	char ch;	
	for (i=0;*(s+i)!=0;i++)
	{
		ch = s[i];
		value = (value << 4);
		if (ch<='9' && ch>='0')
			value = (value | (ch-'0'));
		else if (ch<='f' && ch>='a')
			value = (value | (ch-'W'));
		else if (ch<='F' && ch>='A')
			value = (value | (ch-'7'));
		else
		{			
			return 0xFFFF;
		}
	}
	return value;
}

int run_asm(unsigned short &code,char *argv[] ,int argc)
{	
	if(argc==1)
	{
		code = get_value(argv[0]);
		if (code != 0xffff)
		{ 
			if (strlen(argv[0]) > 4)
				return -1;
			return 0;
		}
	}
	const struct TASM *p = const_asm;
	int i=0;
	for (i=0;i<asm_total;i++)
	{
		if (strcmp(argv[0],(*p).name) == 0)
			break;
		p ++;
	}
	if (i == asm_total)
	{
		cout<<"输入错误"<<endl;
		return -1;
	}
	unsigned short value;
	code = ((*p).code & (*p).x & (*p).y & (*p).z);
	unsigned short regs[3], k;
	regs[0] = ~(*p).x;
	regs[1] = ~(*p).y;
	regs[2] = ~(*p).z;
	unsigned short num;
	for (i=0;i<3;i++)
	{
		if (regs[i] != 0)
		{
			if (argc < i+2)/////////cuowu
			{
				cout<<"输入错误"<<endl;
				return -1;
			}					
			
			k = (regs[i] & (*p).code);
			if (regs[i] == k)
			{
				if ((value = get_regs_id(argv[i+1])) < 0) 
				{
					cout<<"输入错误"<<endl;
					return -1;
				}
					
				while ((regs[i] & 1) == 0)
				{
					value = (value << 1);
					regs[i] = (regs[i] >> 1);
				}
				code |= value;
			}
			else
			{
				num = regs[i];
				while ((num & 1) == 0) num = (num >> 1);
				if ((value = get_value(argv[i+1])) < 0) 
				{
					cout<<"输入错误"<<endl;
					return -1;
				}						
				while ((regs[i] & 1) == 0)
				{
					value = (value << 1);
					regs[i] = (regs[i] >> 1);
				}
				code |= value;
			}
		}
		else
		{
			if (argc != i+1)
				return -1;
			break ;
		}
	}	
	//char** argvtem;
	//argvtem=pc_decode(code);
	//for(i=0;i<argc;i++)
	//	if(strcmp(argvtem[i],argv[i]) != 0)
	//		return -1;

	return 0;
}



struct Tconsole
{
	int mode;
	HANDLE hstdout;
	COORD scrn;
	CONSOLE_SCREEN_BUFFER_INFO sbinf;
	char buffer[LimitConsoleBuffer+1];
	Tconsole()
	{
		mode = 0;
		hstdout = GetStdHandle(STD_OUTPUT_HANDLE);
		WORD attr = FOREGROUND_RED | FOREGROUND_GREEN | FOREGROUND_INTENSITY | BACKGROUND_BLUE;
		SetConsoleTextAttribute(hstdout,attr);
		clearscrn();
		work();
	}	
	void clearscrn()
	{
		int size;
		LPDWORD lpNumber = new DWORD;
		scrn.X = SCRN_X;
		scrn.Y = SCRN_Y;
		SetConsoleScreenBufferSize(hstdout,scrn);
		GetConsoleScreenBufferInfo(hstdout,&sbinf);
		size = SCRN_X*SCRN_Y;
		scrn.X = scrn.Y = 0;
		FillConsoleOutputAttribute(hstdout,sbinf.wAttributes,size,scrn,lpNumber);
		FillConsoleOutputCharacter(hstdout,' ',size,scrn,lpNumber);
		gotoxy(0,0);
	}
	void gotoxy(int xpos,int ypos)
	{
		scrn.X = xpos;
		scrn.Y = ypos;
		SetConsoleCursorPosition(hstdout,scrn);
	}
	void gotoxy_cur(int next)
	{
		if (next == 0)
			return ;
		GetConsoleScreenBufferInfo(hstdout,&sbinf);
		int pos = sbinf.dwCursorPosition.Y*SCRN_X+sbinf.dwCursorPosition.X+next;
		if (next > 0)
		{
			if (pos > SCRN_X*SCRN_Y)
				return ;
		}
		else 
		{
			if (pos < 0)
				return ;
		}
		scrn.X = pos%SCRN_X;
		scrn.Y = pos/SCRN_X;
		SetConsoleCursorPosition(hstdout,scrn);
	}
	void goto_pos(int pos)
	{
		GetConsoleScreenBufferInfo(hstdout,&sbinf);
		if (pos == 0)
			pos = 0;
		else pos += sbinf.dwCursorPosition.X;
		if (pos < 0 || pos >= SCRN_X)
			return ;
		scrn.X = pos;
		scrn.Y = sbinf.dwCursorPosition.Y;
		SetConsoleCursorPosition(hstdout,scrn);
	}
	void work();
	void work_sim();
	void work_com(int );
	void parse_and_run(char [],int );
	int get_input();
	void kernel_run(char [],int ,SOCKET&,HANDLE& com,int isSIM);    //运行监控程序
	void run_R(SOCKET&,HANDLE& com,int isSIM);                      //R命令
	void run_D(SOCKET &client,char* argv[],HANDLE& com,int isSIM );    //D命令
	void run_A(SOCKET &client,char* argv[] ,HANDLE& com,int isSIM);    //A命令
	void run_U(SOCKET &client,char* argv[],HANDLE& com,int isSIM );    //U命令
	void run_G(SOCKET &client, char *argv[],HANDLE& com,int isSIM);    //G命令
	void run_int(SOCKET &client, HANDLE& com,int isSIM);                //中断处理
};


int Tconsole::get_input()
{
	int len = 0, cur = 0;
	char ch;
	buffer[len] = '\0';
	while (true)
	{
		ch = getch();
		if (ch == 8)
		{
			if (cur != 0)
			{
				if (cur == len)
				{
					cur --;
					buffer[--len] = '\0';
					gotoxy_cur(-1);
					printf(" ");
					gotoxy_cur(-1);
				}
				else
				{
					memcpy(&buffer[cur-1],&buffer[cur],len-cur);
					buffer[--len] = '\0';
					printf("\b%s ",&buffer[--cur]);
					gotoxy_cur(cur-len-1);
				}
			}
		}
		else if (ch == -32)
		{
			ch = getch();
			switch (ch)
			{
			case 75: //left
				if (cur != 0)
				{
					cur --;
					gotoxy_cur(-1);
				}
				break;
			case 77: //right
				if (cur != len)
				{
					cur ++;
					gotoxy_cur(1);
				}
				break;
			case 71: //home
				gotoxy_cur(-cur);
				cur = 0;
				break;
			case 79: //end
				gotoxy_cur(len-cur);
				cur = len;
				break;
			case 83: //delete
				if (cur != len)
				{
					len--;
					memcpy(&buffer[cur],&buffer[cur+1],len-cur);
					buffer[len] = '\0';
					printf("%s ",&buffer[cur]);
					gotoxy_cur(cur-len-1);
				}
				break;
			}
		}
		else if (ch == 13)  //回车换行
		{
			printf("%c",ch);
			return len;
		}
		else if (ch == 27)   //单引号
		{
			for (int i=0;i<len;i++)
				buffer[i] = ' ';
			gotoxy_cur(-cur);
			printf("%s",buffer);
			gotoxy_cur(-len);
			cur = len = 0;
			buffer[len] = '\0';
		}
		else
		{
			if (ch <= 126 && ch >= 32)
			{
				if(ch>='a' && ch<='z')
					ch+='A'-'a';
				if (cur == len)
				{
					if (len != LimitConsoleBuffer)
					{
						cur ++;
						buffer[len++] = ch;
						buffer[len] = '\0';
						printf("%c",ch);
					}
				}
				else
				{
					if (len == LimitConsoleBuffer)
					{
						memcpy(&buffer[cur+1],&buffer[cur],len-cur-1);
						buffer[cur] = ch;
						printf("%s",&buffer[cur++]);
						gotoxy_cur(cur-len);
					}
					else
					{
						memcpy(&buffer[cur+1],&buffer[cur],len-cur);
						buffer[++len] = '\0';
						buffer[cur] = ch;
						printf("%s",&buffer[cur++]);
						gotoxy_cur(cur-len);
					}
				}
			}
		}
	}
}

void Tconsole::parse_and_run(char buffer[],int len)
{
	if (strcmp("q",buffer) == 0||strcmp("Q",buffer) == 0)
	{
		mode = -1;
		printf("\n");
		return ;
	}
	char *argv[64];
	int in_command = 0;
	int argc = 0;
	for (int i=0;buffer[i] != '\0';i++)
	{
		if (buffer[i] != ' ')
		{
			if (in_command == 0)
				argv[argc++] = &buffer[i];
			in_command = 1;
		}
		else
		{
			buffer[i] = '\0';
			in_command = 0;
		}
	}
	if (argc == 1)
	{
		if (strcmp(argv[0],"help") == 0||strcmp(argv[0],"HELP") == 0)
		{
			printf("Help....\n");
			return ;
		}
		else if (strcmp("com1",argv[0]) == 0 || strcmp(argv[0],"COM1") == 0)
			mode = 1;
		else if (strcmp("com2",argv[0]) == 0 || strcmp(argv[0],"COM2") == 0)
			mode = 2;
		else if (strcmp("com3",argv[0]) == 0 || strcmp(argv[0],"COM3") == 0)
			mode = 3;
		else if (strcmp("com4",argv[0]) == 0 || strcmp(argv[0],"COM4") == 0)
			mode = 4;
		else if (strcmp("com5",argv[0]) == 0 || strcmp(argv[0],"COM5") == 0)
			mode = 5;
		else if (strcmp("com6",argv[0]) == 0 || strcmp(argv[0],"COM6") == 0)
			mode = 6;
		else if (strcmp("com7",argv[0]) == 0 || strcmp(argv[0],"COM7") == 0)
			mode = 7;
		else if (strcmp("com8",argv[0]) == 0 || strcmp(argv[0],"COM8") == 0)
			mode = 8;
		else if (strcmp("com9",argv[0]) == 0 || strcmp(argv[0],"COM9") == 0)
			mode = 9;
		else if (strcmp("sim",argv[0]) == 0 || strcmp("SIM",argv[0]) == 0)
			mode = 10;
		else printf("\n  ->Unknown command. Use ``help'' to list commands.\n");
	}
	else printf("\n  ->Unknown command. Use ``help'' to list commands.\n");
}

void Tconsole::work()
{
	while (true)
	{
		printf(">>");
		mode = 0;
		while (mode == 0)
		{
			int len = get_input();
			parse_and_run(buffer,len);
			if (mode == 0)
				printf("\n>>");
		}
		switch (mode)
		{
		case -1:
			exit(0);
		case 1:
			work_com(1);
			break;
		case 2:
			work_com(2);
			break;
		case 3:
			work_com(3);
			break;
		case 4:
			work_com(4);
			break;
		case 5:
			work_com(5);
			break;
		case 6:
			work_com(6);
			break;
		case 7:
			work_com(7);
			break;
		case 8:
			work_com(8);
			break;
		case 9:
			work_com(9);
			break;
		case 10:
			printf("\n");
			work_sim();
			break;
		}
	}
}

void Tconsole::work_sim()
{
	WSADATA wsaData;
	int errcode=WSAStartup(0x101,&wsaData);
	if(errcode != 0)
	{
		printf("Error ...\n");
		return ;
	}	
	sockaddr_in server;
	server.sin_family=AF_INET; //Address family
	server.sin_port=htons(8000);
	server.sin_addr.s_addr=inet_addr("127.0.0.1");
	client = socket(AF_INET,SOCK_STREAM,0);
	if(client == INVALID_SOCKET)
	{
		printf("Failed to create socket.\n");
		return ;
	}

	if(connect(client,(sockaddr*)&server,sizeof(server))!=0)
	{
		printf("Failed to bind.\n");
		return ;
	}

	int len = recv(client,buffer,LimitConsoleBuffer,0);

	if (len == 0)
	{
		printf("     Can not connect with Simulator...\n");
		closesocket(client);
		WSACleanup();
		return ;
	}
	if (len != 0)
	{
		buffer[len] = '\0';
		printf("   %s",buffer);
	}
	unsigned long ul = 1;
	unsigned short code;
	char hi, lo;
	ioctlsocket(client,FIONBIO,(unsigned long *)&ul);
	char ch;
	load_file = NULL;
	int flag=0; //标志是否是刚进入kernekl
	while (true)
	{		
		int k=4;
		while(k>0&&flag==0){    //print ok from kernel
			switch(len = recv(client,&ch,1,0))
			{
				case 0:
					printf("\n     Server lost...\n");
					goto break_while;
					break;
				case -1:					
					break;
				default:
					printf("%c",ch);
					k--;
					break;
			}	
		}	

		if(recv(client,&ch,1,0)==0)
		{
			printf("\n     Server lost...\n");
					goto break_while;		
		}

		cout<<"  >> ";
		int order_len = get_input();  //输入命令
		cout<<endl;
		kernel_run(buffer,order_len,client,com,1); //调用kernel
		cout<<endl;
		flag=1;
	}
break_while:
	closesocket(client);
	WSACleanup();
	return ;
}

void Tconsole::kernel_run(char [],int order_len,SOCKET& client,HANDLE& com,int isSIM)
{
	char *argv[64];
	int in_command = 0;
	int argc = 0;

	buffer[order_len]='\0';
	for (int i=0;buffer[i] != '\0';i++)
	{
		if (buffer[i] != ' ')
		{
			if (in_command == 0)
				argv[argc++] = &buffer[i];
			in_command = 1;
		}
		else
		{
			buffer[i] = '\0';			
			in_command = 0;
		}
	}
	argv[argc]="z";
	argv[argc++]="z";
	argv[argc++]="z";


	switch(buffer[0])
	{
		case 0x52:    //R
			run_R(client,com,isSIM);
			break;
		case 0x44:  //D
			run_D(client,argv,com,isSIM);
			break;
		case 0x41:     //A
			run_A(client,argv,com,isSIM);
			break;
		case 0x55:  //u
			run_U(client,argv,com,isSIM);
			break;
		case 0x47:   //G
			run_G(client,argv,com,isSIM);
			break;
		default:
			break;	
	}
	return ;
}

void Tconsole::run_R(SOCKET &client,HANDLE& com,int isSIM)
{
	int len=0,count=0;
	unsigned short regnum=0;
	short temp=0;
	DWORD size;
 	char ch;

	//发送命令R
	

	if(isSIM==1)
	{
		ch=0x52;
		send(client,&ch,1,0);	
		while(count<12){
			switch(len = recv(client,&ch,1,0))
			{
				case 0:
					printf("\n     Server lost...\n");						
					return;
				case -1:				
					break;
				default:		
					if((count&1)==0)
					{
						temp=short(ch);	
						temp&=0xFF;
					}
					else if(count&1 !=0)
					{					
						regnum=short(ch);
						regnum=regnum<<8;
						regnum |=temp;				
						cout<<"R"<<(count-1)/2<<"=";
						printf("%04x  ",regnum);						
							
						if((count-1)/2==2)				
							cout<<endl;							
						regnum=0;						
					}
					++count;
					break;				
			}				
		}		
	}
	else
	{
		ch=0x52;
		size=0;
		while(size==0)
		{
			WriteFile(com,&ch,1,&size,NULL);
		}
		while(count<12){
			ReadFile(com,&ch,1,&size,NULL);
			if(size==1)
			{						
				if((count&1)==0)
				{
					temp=short(ch);	
					temp&=0xFF;
				}
				else if(count&1 !=0)
				{					
					regnum=short(ch);
					regnum=regnum<<8;
					regnum |=temp;				
					cout<<"R"<<(count-1)/2<<"=";
					printf("%04x  ",(unsigned short)( regnum));						
						
					if((count-1)/2==2)				
						cout<<endl;							
					regnum=0;						
				}
				++count;	
			}		
			if (com == INVALID_HANDLE_VALUE)
			{
				printf("  COM lost...\n");
				return;
			}
		}		
	
	}
	return;
}
void Tconsole::run_D(SOCKET &client,char* argv[64],HANDLE& com,int isSIM )
{
	int len=0;
	char ch;	
	short count=0,num=0,temp=0;  //读取次数、内存中的数,临时用
	unsigned short first_addr=0;//首地址
	DWORD size;
	first_addr = get_value(argv[1]);
	if(first_addr>=0xBF00 || first_addr<0x8000) 
		first_addr = 0x8000;
	count=get_value(argv[2]);
	if (count==0xFFFF ||  count < 10)      //省略第三个参数或第三个参数小于10
		count = 0x0a;

	if(isSIM==1)
	{
		//发送命令D
		ch=0x44;
		send(client,&ch,1,0);
		//SEND ADDR
		ch=(first_addr&0x00ff);
		send(client,&ch,1,0);
		temp=(first_addr>>8);
		ch=temp&0x00ff;
		send(client,&ch,1,0);
		//SEND MEMS
		temp=0;
		ch=(count&0x00ff);
		send(client,&ch,1,0);
		temp=(count>>8);
		ch=temp&0x00ff;
		send(client,&ch,1,0);	
		temp=0;
		int countorder=0;
		while(countorder<2*count){
			switch(len = recv(client,&ch,1,0))
			{
				case 0:
					printf("\n     Server lost...\n");						
					return;
				case -1:				
					break;
				default:					
					if((countorder&1)==0)
					{
						temp=short(ch);		
						temp=temp&0xff;
					}
					else if(countorder&1 !=0)
					{					
						num=short(ch);
						num=num<<8;
						num=num&0xff00;
						num |=temp;
						printf("[%04x]    ",(first_addr+countorder/2));
						printf("%04x \n",(unsigned short)(num));
						num=0;	
						temp=0;
					}
					countorder=countorder+1;
					break;				
			}				
		}	
		countorder=0;
	}
	else   //与串口连接
	{
		//发送命令D
		ch=0x44;
		size=0;
		while(size==0)		
			WriteFile(com,&ch,1,&size,NULL);
		//SEND ADDR
		temp=0;
		ch=(first_addr&0x00ff);
		size=0;
		while(size==0)		
			WriteFile(com,&ch,1,&size,NULL);
		temp=(first_addr>>8);
		ch=temp&0x00ff;
		size=0;
		while(size==0)		
			WriteFile(com,&ch,1,&size,NULL);
		//SEND MEMS
		temp=0;
		ch=(count&0x00ff);
		size=0;
		while(size==0)		
			WriteFile(com,&ch,1,&size,NULL);
		temp=(count>>8);
		ch=temp&0x00ff;
		size=0;
		while(size==0)		
			WriteFile(com,&ch,1,&size,NULL);

		temp=0;
		int countorder=0;
		while(countorder<2*count){
			ReadFile(com,&ch,1,&size,NULL);
			if(size==1)
			{				
				if((countorder&1)==0)
				{
					temp=short(ch);		
					temp=temp&0xff;
				}
				else if(countorder&1 !=0)
				{					
					num=short(ch);
					num=num<<8;
					num=num&0xff00;
					num |=temp;
					printf("[%04x]    ",(first_addr+countorder/2));
					printf("%04x \n",(unsigned short)(num));
					num=0;	
					temp=0;
				}
				countorder=countorder+1;
			}	

			if (com == INVALID_HANDLE_VALUE)
			{
				printf("  COM lost...\n");
				return;
			}
					
		}	
		countorder=0;
	}	
	return;
}

void Tconsole::run_A(SOCKET &client,char* argv[64],HANDLE& com,int isSIM )
{
	char ch;
	DWORD size;
	unsigned short addr=0x4000,temp=0,len=0;
	addr = get_value(argv[1]);
	if(addr>=0x8000 || addr<0x4000) 
		addr = 0x4000;
	
	if(isSIM==1){	
		ch=0x41;
		send(client,&ch,1,0);	
		while(true)
		{
			if(recv(client,&ch,1,0)==0)
			{
				printf("\n     Server lost...\n");					
				return ;
			}
			

			printf("[%04x]  ",addr);
			int mips=get_input();
			cout<<endl;
			if(mips==0)
			{
				ch=0;
				send(client,&ch,1,0);			
				send(client,&ch,1,0);
				return;
			}			
			int in_command = 0;
			int argc = 0;
			buffer[mips]='\0';
			for (int i=0;buffer[i] != '\0';i++)
			{
				if (buffer[i] != ' ')
				{
					if (in_command == 0)
						argv[argc++] = &buffer[i];
					in_command = 1;
				}
				else
				{
					buffer[i] = '\0';			
					in_command = 0;
				}
			}

			/////////////	
			unsigned short code=0;
			if(run_asm(code,argv,argc)==-1)
				continue;
			

			ch=(addr&0x00ff);
			send(client,&ch,1,0);
			temp=addr>>8;
			ch=temp&0x00ff;
			send(client,&ch,1,0);
			
			ch=code&0x00ff;
			send(client,&ch,1,0);
			temp=code>>8;
			ch=temp&0x00ff;
			send(client,&ch,1,0);
			
			addr=addr+1;
		
		}
	}

	else{
		ch=0x41;
		size=0;
		while(size==0)		
			WriteFile(com,&ch,1,&size,NULL);
		while(true)
		{
			
			if (com == INVALID_HANDLE_VALUE)
			{
				printf("  COM lost...\n");
				return;
			}
			printf("[%04x]  ",addr);
			int mips=get_input();
			cout<<endl;
			if(mips==0)
			{
				ch=0;
				size=0;
				while(size==0)		
					WriteFile(com,&ch,1,&size,NULL);		
				size=0;
				while(size==0)		
					WriteFile(com,&ch,1,&size,NULL);	
				return;
			}			
			int in_command = 0;
			int argc = 0;
			buffer[mips]='\0';
			for (int i=0;buffer[i] != '\0';i++)
			{
				if (buffer[i] != ' ')
				{
					if (in_command == 0)
						argv[argc++] = &buffer[i];
					in_command = 1;
				}
				else
				{
					buffer[i] = '\0';			
					in_command = 0;
				}
			}

			/////////////	
			unsigned short code=0;
			if(run_asm(code,argv,argc)==-1)
				continue;

			printf("code:%04x \n",code);	
			temp=0;
			ch=(addr&0x00ff);
			size=0;
			while(size==0)		
				WriteFile(com,&ch,1,&size,NULL);
			temp=addr>>8;
			ch=temp&0x00ff;
			size=0;
			while(size==0)		
				WriteFile(com,&ch,1,&size,NULL);
			
			ch=code&0x00ff;
			size=0;
			while(size==0)		
				WriteFile(com,&ch,1,&size,NULL);
			temp=code>>8;
			ch=temp&0x00ff;
			size=0;
			while(size==0)		
				WriteFile(com,&ch,1,&size,NULL);
			addr=addr+1;		
		}		
	}
	return ;

}
void Tconsole::run_U(SOCKET &client, char *argv[],HANDLE& com,int isSIM)
{
	int len=0;
	char ch;
	DWORD size;
	unsigned short count=0,first_addr=0,num=0,temp=0;  //读取次数、首地址、内存中的数,临时用


	first_addr = get_value(argv[1]);
	if(first_addr>=0x8000 || first_addr<0x4000) 
		first_addr = 0x4000;
	count=get_value(argv[2]);
	if (count==0xFFFF ||  count < 10)      //省略第三个参数或第三个参数小于10
		count = 0x0a;
	if(isSIM==1)
	{	
		//发送命令U
		ch=0x55;
		send(client,&ch,1,0);
		//SEND ADDR
		ch=(first_addr&0x00ff);
		send(client,&ch,1,0);
		temp=(first_addr>>8);
		ch=temp&0x00ff;
		send(client,&ch,1,0);
		//SEND MEMS
		ch=(count&0x00ff);
		send(client,&ch,1,0);
		temp=(count>>8);
		ch=temp&0x00ff;
		send(client,&ch,1,0);	   	

		int countorder=0;
		while(countorder<2*count){
			switch(len = recv(client,&ch,1,0))
			{
				case 0:
					printf("\n     Server lost...\n");					
					return;
				case -1:				
					break;
				default:					
					if((countorder&1)==0)
					{
						temp=short(ch);	
						temp=temp&0x00ff;						
					}
					else if(countorder&1 !=0)
					{					
						num=short(ch);
						num=num<<8;
						num=num&0xff00;					
						num |=temp;					
						printf("[%04x]    ",(first_addr+countorder/2));
						pc_decode(num);
						num=0;						
					}
					countorder=countorder+1;
					break;				
			}				
		}	
	}
	else
	{
		//发送命令U
		ch=0x55;
		size=0;
		while(size==0)		
			WriteFile(com,&ch,1,&size,NULL);
		//SEND ADDR
		if (com == INVALID_HANDLE_VALUE)
		{
			printf("  COM lost...\n");
			return;
		}

		ch=(first_addr&0x00ff);
		size=0;
		while(size==0)		
			WriteFile(com,&ch,1,&size,NULL);
		temp=(first_addr>>8);
		ch=temp&0x00ff;
		size=0;
		while(size==0)		
			WriteFile(com,&ch,1,&size,NULL);
		//SEND MEMS
		ch=(count&0x00ff);
		size=0;
		while(size==0)		
			WriteFile(com,&ch,1,&size,NULL);
		temp=(count>>8);
		ch=temp&0x00ff;
		size=0;
		while(size==0)		
			WriteFile(com,&ch,1,&size,NULL);   	

		int countorder=0;
		while(countorder<2*count){
			ReadFile(com,&ch,1,&size,NULL);
			if(size==1)
			{							
				if((countorder&1)==0)
				{
					temp=short(ch);	
					temp=temp&0x00ff;						
				}
				else if(countorder&1 !=0)
				{					
					num=short(ch);
					num=num<<8;
					num=num&0xff00;					
					num |=temp;					
					printf("[%04x]    ",(first_addr+countorder/2));
					pc_decode(num);
					num=0;						
				}
				countorder=countorder+1;						
			}				
		}	//end while	
	} //end if
			
	return;

}
void Tconsole::run_G(SOCKET &client, char *argv[],HANDLE& com,int isSIM)
{
	int len=0;
	char ch;
	DWORD size;
	unsigned short first_addr=0,temp=0;  //首地址
	first_addr = get_value(argv[1]);
	if(first_addr>=0x8000 || first_addr<0x4000) 
		first_addr = 0x4000;

	if(isSIM==1)
	{
		//发送命令g
		ch=0x47;
		send(client,&ch,1,0);

		ch=(first_addr&0x00ff);
		send(client,&ch,1,0);
		temp=(first_addr>>8);
		ch=temp&0x00ff;
		send(client,&ch,1,0);

		while(true)
		{
			switch(len = recv(client,&ch,1,0))
			{
				case 0:
					printf("\n     Server lost...\n");					
					return;
				case -1:				
					break;
				default:
					switch(ch)
					{
						case 0x0f:
							run_int(client,com,isSIM);
							break;
						case 0x07:
							return;					
						default:
							printf("%",ch);
							break;
					}
					break;
			}
		}
	}
	else
	{
		//发送命令g
		ch=0x47;
		size=0;
		while(size==0)		
			WriteFile(com,&ch,1,&size,NULL);

		ch=(first_addr&0x00ff);
		size=0;
		while(size==0)		
			WriteFile(com,&ch,1,&size,NULL);
		temp=(first_addr>>8);
		ch=temp&0x00ff;
		size=0;
		while(size==0)		
			WriteFile(com,&ch,1,&size,NULL);

		while(true)
		{
			if (com == INVALID_HANDLE_VALUE)
			{
				printf("  COM lost...\n");
				return;
			}
			ReadFile(com,&ch,1,&size,NULL);
			if(size==1)
			{				
				switch(ch)
				{
					case 0x0f:
						run_int(client,com,isSIM);
						break;
					case 0x07:
						return;					
					default:
						printf("%",ch);
						break;
				}					
			}
		}
	}
	return;
}
void Tconsole::run_int(SOCKET &client, HANDLE &com, int isSIM)
{
	int len=0;
	char ch;
	DWORD size;
	if(isSIM==1)
	{
		while(true)
		{
			switch(len = recv(client,&ch,1,0))
			{
				case 0:
					printf("\n     Server lost...\n");						
					return;
				case -1:				
					break;
				default:					
					switch(ch)
					{
						case 0x0f:
							return;
						case 0x10:
							cout<<"外部中断"<<endl;
							break;
						case 0x20:
							cout<<"时钟中断"<<endl;
							break;
						case 0x00:
							cout<<"int 指令中断"<<endl;
							break;										
						default:
							printf("%",ch);
							break;
					}
					break;
			}
		}	
	}
	else
	{
		while(true)
		{
			if (com == INVALID_HANDLE_VALUE)
			{
				printf("  COM lost...\n");
				return;
			}
			ReadFile(com,&ch,1,&size,NULL);
			if(size==1)
			{				
				switch(ch)
				{
					case 0x10:
						cout<<"外部中断"<<endl;
						break;
					case 0x20:
						cout<<"时钟中断"<<endl;
						break;
					case 0x00:
						cout<<"int 指令中断"<<endl;
						break;
					case 0x0f:
						return;					
					default:
						printf("%",ch);
						break;
				}					
			}
		}	
	}
	return;
}
void Tconsole::work_com(int com_num)
{
	com_name[3] = '0'+com_num;
	DCB dcb;
	com = CreateFileA(com_name,GENERIC_READ|GENERIC_WRITE,0,NULL,OPEN_EXISTING,0,NULL);
	if (com == INVALID_HANDLE_VALUE)
	{
		printf("\n   Can not open %s\n",com_name);
		return ;
	}
	GetCommState(com,&dcb);
	dcb.BaudRate = 9600;
	dcb.ByteSize = 8;
	dcb.StopBits = ONESTOPBIT;
	SetCommState(com,&dcb);
	dcb.ByteSize = 8;
	dcb.Parity = ODDPARITY;
	dcb.StopBits = ONESTOPBIT;
	dcb.fBinary = TRUE;
	dcb.fParity = FALSE;
	SetCommState(com,&dcb);
	unsigned char ch;
	DWORD size;
	int len;
	load_file = NULL;
	unsigned short code;
	char hi, lo;
	printf("\n   Ok..  Connected with com...\n");

	int flag=0; //标志是否是刚进入kernel
	while (true)
	{		
		if (com == INVALID_HANDLE_VALUE)
		{
			printf("  COM lost...\n");
			goto break_loop;
		}
		int k=4;
		
		while(k>0&&flag==0){    //print ok from kernel
			ReadFile(com,&ch,1,&size,NULL);
			if(size==1)
			{			
					printf("%c",ch);
					k--;					
			}	
		}		

		cout<<"  >> ";
		int order_len = get_input();  //输入命令
		cout<<endl;
		kernel_run(buffer,order_len,client,com,0); //调用kernel
		cout<<endl;
		flag=1;
	}
break_loop:	
	return ;
}								
							

int main()
{
	Tconsole console;
	return 0;
}
