%option noyywrap
%{
	#include<stdio.h>
	#include<string.h>
	int i,j,x,incorrect_mod;
	char check[];

	//Έλεγχος για την σωστή ονομασία των σημείων των σχημάτων
	/*ο αριθμός p αντιπροσωπεύει την θέση που θα βρίσκεται το γράμμα 
	του πρώτου σημείου του σχήματος που έγραψε ο χρήστης. Π.χ. εάν ο
	χρήστης έγραψε "square EDFA" το p αντιπροσωπεύει την θέση του
	χαρακτήρα E, δηλαδή την θέση 7. Αντίστοιχα το q αντιπροσωπέυει
	την θέση του τελευταίου χαρακτήρα, όπου στο παράδειγμα είναι η
	θέση του χαρακτήρα Α, δηλαδή η θέση 11. */

	void pointcheck(int p,int q){
		/*Εισαγωγή της συμβολοσειράς του χρήστη σε πίνακα τύπου 
		χαρακτήρων */
		strcpy(check,yytext);
		/*Εκτέλεση ενός βρόγχου for για τόσες φορές όσο είναι το
		μέγεθος του αντίστοιχου σχήματος*/
		for(i=p;i<q;i++){
			/*Εκτέλεση δεύτερου βρόγχου for για τόσες φορές 
			όσα γράμματα σημείων δεν έχουν ελεγθεί */
			for(j=1;j<q-i;j++){
				/*Εάν έστω ένα από τα γράμματα της συμβολοσειράς
				του χρήστη που βρίσκονται μετά το τώρα
				ελεγχόμενο γράμμα, έιναι το ίδιο με το
				τώρα ελεγχόμενο γράμμα, τότε η συμβολοσειρά
				του χρήστη δεν είναι σωστή */
				if(check[i+j]==check[i]){
					printf("Incorrect expression\n");
					/*Η μεταβλητή x δέχεται την τιμή 0,
					ώστε να ανιχνευθεί απο το πρόγραμμα
					μετά ότι η συμβολοσειρά δεν 
					είναι έγκυρη*/
					x=0;
					return;
							}
					}
				}
			/*Εάν η μεταβλητή x δεν έχει την τιμή 0 τότε δεν έχει 
			ανιχνευθεί κάποιο λάθος και η συμβολσειρά είναι
			έγκυρη*/
		if (x!=0){
			printf("Correct expression\n");
			}
		}
%}

/*Πιθανοί χαρακτήρες για την ονομασία σημείων των σχημάτων*/
POINT	[A-H]

%%

"point "{POINT}[\n] {printf("Correct expression\n");}

"line "{POINT}{POINT}[\n] {
strcpy(check,yytext);
if(check[5]!=check[6]){
	printf("Correct expression\n");
	}
else{
	printf("Incorrect expression\n");
	}
}

"triangle "{POINT}{POINT}{POINT}[\n] {
pointcheck(9,12);
}

"square "{POINT}{POINT}{POINT}{POINT}[\n] {
pointcheck(7,11);
}

"pentagon "{POINT}{POINT}{POINT}{POINT}{POINT}[\n] {
pointcheck(9,14);
}

"hexagon "{POINT}{POINT}{POINT}{POINT}{POINT}{POINT}[\n] {
pointcheck(8,14);
}

"heptagon "{POINT}{POINT}{POINT}{POINT}{POINT}{POINT}{POINT}[\n] {
pointcheck(9,16);
}

"octagon "{POINT}{POINT}{POINT}{POINT}{POINT}{POINT}{POINT}{POINT}[\n] {
pointcheck(8,16);
}	

[ ]

[\n] {
incorrect_mod=0;
}

. {
if(incorrect_mod!=1){
	printf("Incorrect expression \n");
	incorrect_mod=1;
	}
}

%%
main( argc, argv )
int argc;
char **argv;
    {
    ++argv, --argc;  /* skip over program name */
    if ( argc > 0 )
            yyin = fopen( argv[0], "r" );
    else
            yyin = stdin;
    yylex();
    }