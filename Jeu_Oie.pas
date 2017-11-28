 PROGRAM Jeu_Oie;

USES crt;


{Jeu de l'oie : le jeu se joue seul. Le joueur est caracterise par un nombre : place
(variable), avec des cases comprises entre 0 et 66, qui situe sa position sur le plateau.
Après un jet des 2 des, on applique regles suivantes :
- On avance du nombre de cases indiquees par la somme des des.
- Si on arrive pile sur la case 66, le jeu est terminé, sinon, on recule.
- Une oie toute les neuf cases, sauf en 63, double le deplacement en cours (le joueur
ne finira jamais son tour sur un multiple de 9).
- Une tete de mort à la case 58 renvoie à la position de depart case 0.

On s'efforcera d'utiliser au maximum l'emploie de constantes.
Production d'un algo et d'un programme lisible et clair (avec commentaires).
Vérifier que le jet de de est valide.
Modulo pour test multiple de 9.

Modifs possibles :
-Randomn pour jets de des. }


{

CONST

CASE_DEPART<-0:ENTIER
CASE_OIE<-9:ENTIER
CASE_MORT<-58:ENTIER
MINI<-2:ENTIER
MAXI<-12:ENTIER
CASE_63<-63:ENTIER
ARRIVE<-66:ENTIER


VAR

	resultat,lancer,place : ENTIER

DEBUT

    place <- 0																									//On initialise la place du joueur
    REPETER
        REPETER
            ECRIRE "Veuillez rentrer le resultat du premier de"
            LIRE resultat
            ECRIRE "Veuillez rentrer le résultat du second de"
            LIRE lancer
            resultat <- resultat + lancer
            ECRIRE "Votre lance est de : ",resultat
            LIRE
            SI ((resultat < MINI) OU (resultat > MAXI)) ALORS													//Si le test est faux, le resultat n'est pas valide et on recommence
                ECRIRE "La valeur n'est pas valide"
            FIN SI
        JUSQU'A ((resultat >= MINI)ET (resultat <= MAXI))														//Si le de est compris entre 2 et 12 alors on sort de la boucle
        ECRIRE "Vous vous deplacez de ",resultat," cases
        place <- place + resultat
        ECRIRE "Vous etes desormais a la case ",place
        LIRE					
        SI place MOD CASE_OIE=0 ET place <> CASE_63 ALORS 														//On declare chaque multiple de 9 comme case oie SAUF le 63 qui est exclu.
            ECRIRE "Vous etes sur une case oie, votre deplacement compte double"	
            place <- place + resultat
            ECRIRE "Vous avancez de ",resultat," places et vous etes sur la case ",place 						//On explique au joueur pourquoi, comment et a quelle case il arrive.
            LIRE
        FINSI
        SI place = CASE_MORT ALORS 																				//On test pour savoir si le joueur est a la case 58.
            place <- CASE_DEPART
            ECRIRE "Vous retournez a la case depart"
            LIRE
        FIN SI
        SI place > ARRIVE ALORS 																				//On verifi que le joueur ne depasse pas la case 66
            ECRIRE "Vous avez depasse l'arrivé, vous reculez du nombre de deplacements qu'il vous reste."
            place <- place - (( place - ARRIVE)*2) 																//On soustrait la place du joueur a sa place moins l'arrivé et on multipli par 2 pour que le resultat soit inverse et qu'il recule du nombre de cases superieures a 66
            ECRIRE "Vous etes désormais a la case",place
            LIRE
        FINSI
        cpt <- cpt +1
    JUSQU'A (place=66)
    ECRIRE "Felicitation, vous avez gagne en ",cpt," tours !"													//On informe le joueur du nombre de tours dont il a eu besoin pour venir a bout du parcours
    LIRE
FIN}

CONST
																											//Declaration des constantes
CASE_DEPART=0;
CASE_OIE=9;
CASE_MORT=58;
MINI=2;
MAXI=12;
CASE_63=63;
ARRIVE=66;

VAR
																											//Declaration des variables
	cpt,place, resultat, lancer:integer;

BEGIN


	clrscr;																									//On efface le flux existant a l'écran pour plus de visibilitee
	place:=CASE_DEPART;																						//On initialise la place du jouer a la case depart
	REPEAT
		{REPEAT
			writeln('Veuillez rentrer le resultat du premier de');
			readln (resultat);
			writeln('Veullez rentrer le resultat du second de');
			readln (lancer);
			resultat:=resultat+lancer;
			writeln('Votre lancer est de : ',resultat);														//Code si le joueur veut rentrer les resultats des des lui meme
			Readln;
			IF ((resultat < MINI) OR (resultat>MAXI)) THEN
				writeln('La valeur n est pas valide');
			END IF
		UNTIL ((resultat >= MINI) AND (resultat <= MAXI));}
		//Mettre en commentaire pour tester le jet de des
		randomize;	
		resultat:=(2+random(10));																			//Random 10 (exclu) +2 pour que le resultat soit compris entre 2 et 12 (0+2 ou 10+2)
		writeln('Le resultat du de est de : ',resultat);
		writeln('Vous vous deplacez de ',resultat,' cases');
		place := place + resultat;	
		writeln('Vous etes desormais a la case ',place);
		readln;
		clrscr;																								//On efface les lignes existantes et on rappelle la position du joueur, c'est plus joli
		writeln('Vous etes a la case ',place);
		//Jusqu'ici
		IF ((place MOD CASE_OIE = 0) AND (place <> 63)) THEN
			BEGIN
				writeln('Vous etes sur une case Oie, votre deplacement compte double');						//Ce "SI" est utilise lorsque le joueur tombe sur une case multiple de 9
				place:=place+resultat;																		//On reaffecte a place le meme deplacement a cause de la case oie
				writeln('Vous etes desormais a la case ',place);
				readln;
				clrscr;
				writeln('Vous etes a la case ',place);
			END;

		IF  place = CASE_MORT THEN																			//Ce "SI" est utilise lorsque le joueur tombe sur la case fatidique, 58
			BEGIN	
				place := CASE_DEPART;
				writeln('Vous retournez a la case depart car vous etes arrive sur la case tete de mort. Pas de chance !');
				readln;
				clrscr;
				writeln('Vous etes a la case ',place);
			END;	

		IF place > ARRIVE THEN																				//Ce "SI" est utilise lorsque le joueur depasse la case d'arrive
			BEGIN
				place:=place-((place - ARRIVE)*2);															//On soustrait la place du joueur a sa place moins l'arrivé et on multipli par 2 pour que le resultat soit inverse et qu'il recule du nombre de cases superieures a 66
				writeln('Vous avez depasse l arrive, vous reculez du nombre de deplacements qu il vous reste.');
				writeln('Vous etes desormais a la case ',place);
				Readln;
				clrscr;
				writeln('Vous etes a la case ',place);
			END;
		cpt := cpt +1;																						//On incremente le compteur de 1 avant chaque lance afin que le joueur connaisse le nombre de tours qu'il lui a fallut
	UNTIL (place=66);
	writeln('Felicitations, vous avez gagne en ',cpt,' tours !');
	Readln;
END.
