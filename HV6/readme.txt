Utilisation de hasmV6

2 fichiers utiles Hasm.g' et HV6.java
+ les librairies de antlr

le code du compilateur sse trouve ds  : Hasm.G4
	on peut y ajouet des IP  en le rangeant dans la table des symboles 
	
	exemple
	predef.adresse =  binary_code( 0, 0, 0xxxx);  	addsymbol("mon_symbol", predef); 
	
Generation du compilateur 
	voir https://theantlrguy.atlassian.net/wiki/display/ANTLR4/Getting+Started+with+ANTLR+v4
	sous windows
		ajouter le classpath
		SET CLASSPATH=.;C:\Javalib\antlr-4.5-complete.jar;%CLASSPATH%
		
		la commande  qui genere les classes java
			antlr4 Hasm.g4
		 fichier antlr4.bat   : 
			java org.antlr.v4.Tool %*
			
		la commande de compilation 
			javac Hasm*.java
			
		enfin le test du compilateur avec un exemple test.fsh
			grun Hasm root -gui test.fsh
		fichier grun.bat :
			java org.antlr.v4.runtime.misc.TestRig %*
			
		pour generer la class HV6 qui prend un fichier xxx.fsh et produit xxx.hmd
			il faut si besoin recompiler la classe HV6.class
				javac Hasm*.java HV6.java
				
Lancement d'un compilation 
	java HV6 test.fsh


Synatxe Hasm V6.1

	https://sites.google.com/site/homadeguide/assembleur-homade-v6