//modified by:
//date:
//purpose:
//
//cmps 2240 lab10
//author: Xander Reyes
//date: Fall 2016
//Idea for this lab developed by student: Matthew Gaitan
//
//Read an encrypted file, and decrypt it using x86 assembly.
//
#include <stdio.h>
#include <string.h>
#include <malloc.h>

const char fname[] = "file10.txt";
const char fname2[] = "file10x.txt";

int main()
{
	unsigned char *str = (unsigned char *)malloc(1000);
	FILE *fpi = fopen(fname,"r");
	if (!fpi) {
		printf("ERROR opening **%s**\n", fname);	
		return 0;
	}
	fread(str, 1, 1000, fpi);
	int slen = strlen((char *)str);
	printf("str len: %i\n", slen);
	fclose(fpi);
	//
	//Encryption method:
	//
	//Each character in string is "rolled" 2 bits to the left.
	//No bits are lost in the roll operation.
	//
	//Call the decrypt10 function in lab10.s
	//Write the decryption operations there.
	//No changes are needed in this file.
	//
	extern void decrypt10(unsigned char *str);
	decrypt10(str);
	printf("%s\n", (char *)str);
	//
	free(str);
   


    unsigned char *strx = (unsigned char *)malloc(1000);
	FILE *fpix = fopen(fname2,"r");
	if (!fpix) {
		printf("ERROR opening **%s**\n", fname2);	
		return 0;
	}
	fread(strx, 1, 1000, fpix);
	int slenx = strlen((char *)strx);
	printf("str len: %i\n", slenx);
	fclose(fpix);
	//
	//Encryption method:
	//
	//Each character in string is "rolled" 2 bits to the left.
	//No bits are lost in the roll operation.
	//
	//Call the decrypt10x function in lab10.s
	//Write the decryption operations there.
	//No changes are needed in this file.
	//
	extern void decrypt10xx(unsigned char *strx);
	decrypt10xx(strx);
	printf("%s\n", (char *)strx);
	//
	free(strx);

	return 0;
}


