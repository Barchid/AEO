// Define a grammar called Hasm
grammar Hasm;

@header {

import java.util.*;	
import java.io.*;

}

																		// local routine for generator 
@parser::members {
// fihier de sortie
PrintWriter isim ;
	   
FileOutputStream codefile ;

// a mettre en package!!!!!!!!!!!!!!!!!!
// defintion des IP
public class IpElement {
	public int ipcode;
	public boolean masterGen;
	public boolean slaveGen;
	public IpElement (int code, boolean master, boolean slave) {
		ipcode = code;
		masterGen = master;
		slaveGen = slave;
	}
}


public int val_literal;
	
																// code des insctruction
int code_return = 0x1400;
int code_halt = 0x1C00;
int code_call = 0x1000;
int code_wait = 0x6000;
String version = "HasmV6.0";

			
																// gestion des zone master et slave
// varaible globale
String lit_string, last_name;
Boolean loop, VCorPC,multiplexeur = false, register_declare,ram_used =false;
int ipword, VCPCadresse, casevalue,caseadr,braadr,nb_entry,next_reg=1,IPadr,nb_state, lastadr,nb_pc =0,start_slave_adr;
																// adresse de debut des zone locale
public int master_adr, slave_adr, nbline=0;
int in_slave = 0;  												// 1 local salve ;2 local master ;0 double implantation master et slave , depend de la position de la zone de code  partie declarative
																		//	declaration table of symbol
public static int IP=1, WORD=3, PC=4, VC=5 ,IPonly = 6, REG = 7, ENTRY = 8,STATE =9;  					// type de declaration
public class SymbolElement {											// type d un enregistrement pour table des symboles
	public int idType;
	public int adresse;
	public int slave;
	public int adresse_reconfig;
	public String fathername;
	public int entry;
		public SymbolElement (int itype, int adr, int slav, int adr_reconfig) {
		idType = itype;
		adresse = adr;
		slave = slav;
		adresse_reconfig = adr_reconfig;
		fathername = "";
		entry = 0;
	}
}
Stack<String> stackentry = new Stack<String>();
Stack<String> writereg = new Stack<String>();

Stack<Integer> stackadr = new Stack<Integer>();

Map<String, SymbolElement> symbol = new HashMap<String, SymbolElement>();
public void addsymbol( String name , SymbolElement code){
	SymbolElement mycode = new SymbolElement (code.idType, code.adresse, code.slave, code.adresse_reconfig );
	symbol.put(name, mycode);
}

public class Reg {
	public int adresse;
	public String initvalue;
	public  int slave;
}
Stack <Reg> stackreg = new Stack<Reg>();
Stack <Reg> stacksavereg = new Stack<Reg>();

public void initIppredef() {
SymbolElement predef = new SymbolElement(IPonly, 0, 2, -1) ;	

predef.idType = IPonly;
predef.slave= 0;   /// master and slave
predef.adresse_reconfig = -1;

predef.adresse =  binary_code( 1, 0, 0x0);  	addsymbol("pop1", predef); addsymbol("drop", predef);addsymbol("pop", predef);
predef.adresse =  binary_code( 2, 0, 0x0);  	addsymbol("pop2", predef); 
predef.adresse =  binary_code( 3, 0, 0x0);  	addsymbol("pop3", predef); 
predef.adresse =  binary_code( 0, 0, 0x0);  	addsymbol("nop", predef); 
predef.adresse =  binary_code( 3, 2, 0x5);  	addsymbol("nip3", predef); 
predef.adresse =  binary_code( 3, 1, 0x5);  	addsymbol("nip23", predef); 
predef.adresse =  binary_code( 0, 2, 0x5);  	addsymbol("dup2", predef); 
predef.adresse =  binary_code( 0, 3, 0x5);  	addsymbol("dup3", predef); 
predef.adresse =  binary_code( 0, 1, 0x6);  	addsymbol("r>", predef); 
predef.adresse =  binary_code( 0, 0, 0x6);  	addsymbol("r>pop", predef); 
predef.adresse =  binary_code( 1, 0, 0x7);  	addsymbol(">r", predef);
predef.adresse =  binary_code( 0, 0, 0x7);  	addsymbol(">rdup", predef); 
predef.adresse =  binary_code( 0, 1, 0x8);  	addsymbol("dup", predef); 
predef.adresse =  binary_code( 0, 2, 0x8);  	addsymbol("triple", predef); 
predef.adresse =  binary_code( 0, 3, 0x8);  	addsymbol("quad", predef); 
predef.adresse =  binary_code( 2, 2, 0x9);  	addsymbol("swap", predef); 
predef.adresse =  binary_code( 2, 3, 0xA);  	addsymbol("tuck", predef); 
predef.adresse =  binary_code( 2, 3, 0xB);  	addsymbol("over", predef); 
predef.adresse =  binary_code( 3, 3, 0xC);  	addsymbol("rot", predef); 
predef.adresse =  binary_code( 3, 3, 0xD);  	addsymbol("-rot", predef); 
predef.adresse =  binary_code( 2, 1, 0xE);  	addsymbol("nip", predef); 
predef.adresse =  binary_code( 0, 0, 0xF);  	addsymbol("clearstack", predef); 
predef.adresse =  binary_code( 2, 1, 0x14);  	addsymbol("mul16", predef); addsymbol("*", predef); 			
predef.adresse =  binary_code( 2, 1, 0x20);  	addsymbol("add", predef); 		addsymbol("+", predef); addsymbol("add16", predef);
predef.adresse =  binary_code( 2, 1, 0x21);  	addsymbol("-", predef); addsymbol("minus", predef); addsymbol("minus16", predef);
predef.adresse =  binary_code( 1, 1, 0x22);  	addsymbol("1+", predef); addsymbol("inc", predef); addsymbol("++", predef);
predef.adresse =  binary_code( 1, 1, 0x23);  	addsymbol("1-", predef); addsymbol("dec", predef); addsymbol("--", predef);
predef.adresse =  binary_code( 1, 1, 0x24);  	addsymbol("invert", predef);	addsymbol("!", predef); 
predef.adresse =  binary_code( 2, 1, 0x25);  	addsymbol("and", predef);	addsymbol("&&", predef); 
predef.adresse =  binary_code( 2, 1, 0x26);  	addsymbol("or", predef); addsymbol("||", predef); 
predef.adresse =  binary_code( 2, 1, 0x27);  	addsymbol("xor", predef); 
predef.adresse =  binary_code( 1, 1, 0x28);  	addsymbol("2*", predef); 
predef.adresse =  binary_code( 1, 1, 0x29);  	addsymbol("u2/", predef); 
predef.adresse =  binary_code( 1, 1, 0x2A);  	addsymbol("2/", predef); 
predef.adresse =  binary_code( 2, 1, 0x2B);  	addsymbol("->", predef); 
predef.adresse =  binary_code( 2, 1, 0x2C);  	addsymbol("<-", predef); 
predef.adresse =  binary_code( 2, 1, 0x2D);  	addsymbol("<-$", predef); 
predef.adresse =  binary_code( 1, 1, 0x2F);  	addsymbol("negate", predef); 
predef.adresse =  binary_code( 0, 1, 0x30);  	addsymbol("true", predef); 
predef.adresse =  binary_code( 0, 1, 0x31);  	addsymbol("false", predef);
predef.adresse =  binary_code( 1, 1, 0x32);  	addsymbol("=0", predef); 
predef.adresse =  binary_code( 1, 1, 0x33);  	addsymbol("0<", predef);
predef.adresse =  binary_code( 2, 1, 0x34);  	addsymbol("and2", predef); 
predef.adresse =  binary_code( 2, 1, 0x35);  	addsymbol("xor2", predef); 
predef.adresse =  binary_code( 2, 1, 0x36);  	addsymbol("=", predef); addsymbol("eq", predef); 
predef.adresse =  binary_code( 2, 1, 0x37);  	addsymbol("or2", predef); 
predef.adresse =  binary_code( 2, 1, 0x39);  	addsymbol("<>", predef); 
predef.adresse =  binary_code( 2, 1, 0x3A);  	addsymbol(">", predef); 
predef.adresse =  binary_code( 2, 1, 0x3B);  	addsymbol("<", predef); 
predef.adresse =  binary_code( 2, 1, 0x3C);  	addsymbol("<=", predef); 
predef.adresse =  binary_code( 2, 1, 0x3D);  	addsymbol(">=", predef); 

predef.adresse =  binary_code( 1, 0, 0x48);  	addsymbol(">0", predef);  
predef.adresse =  binary_code( 0, 1, 0x40);  	addsymbol("0>", predef); 
predef.adresse =  binary_code( 1, 0, 0x49);  	addsymbol(">1", predef);  
predef.adresse =  binary_code( 0, 1, 0x41);  	addsymbol("1>", predef); 
predef.adresse =  binary_code( 1, 0, 0x4A);  	addsymbol(">2", predef);  
predef.adresse =  binary_code( 0, 1, 0x42);  	addsymbol("2>", predef); 
predef.adresse =  binary_code( 1, 0, 0x4B);  	addsymbol(">3", predef);  
predef.adresse =  binary_code( 0, 1, 0x43);  	addsymbol("3>", predef); 
predef.adresse =  binary_code( 1, 0, 0x4C);  	addsymbol(">4", predef);  
predef.adresse =  binary_code( 0, 1, 0x44);  	addsymbol("4>", predef); 
predef.adresse =  binary_code( 1, 0, 0x4D);  	addsymbol(">5", predef);  
predef.adresse =  binary_code( 0, 1, 0x45);  	addsymbol("5>", predef); 
predef.adresse =  binary_code( 1, 0, 0x4E);  	addsymbol(">6", predef);  
predef.adresse =  binary_code( 0, 1, 0x46);  	addsymbol("6>", predef); 
predef.adresse =  binary_code( 1, 0, 0x4F);  	addsymbol(">7", predef);  
predef.adresse =  binary_code( 0, 1, 0x47);  	addsymbol("7>", predef); 

predef.adresse =  binary_code( 1, 1, 0x50);  	addsymbol("read", predef); 
predef.adresse =  binary_code( 2, 0, 0x51);  	addsymbol("write", predef); 

predef.slave = 2;     //// master only

predef.adresse =  binary_code( 0, 1, 0x1);  	addsymbol("tic", predef); 
predef.adresse =  binary_code( 0, 0, 0x1);  	addsymbol("ticraz", predef); 
predef.adresse =  binary_code( 1, 0, 0x2);  	addsymbol("7seg", predef); 
predef.adresse =  binary_code( 0, 0, 0x2);  	addsymbol("7segdup", predef); 
predef.adresse =  binary_code( 1, 0, 0x3);  	addsymbol("led", predef); 
predef.adresse =  binary_code( 0, 0, 0x3);  	addsymbol("leddup", predef); 
predef.adresse =  binary_code( 0, 1, 0x4);  	addsymbol("switch", predef); 
predef.adresse =  binary_code( 0, 1, 0x12);  	addsymbol("S2M", predef); 
predef.adresse =  binary_code( 1, 0, 0x13);  	addsymbol("M2S", predef); 
predef.adresse =  binary_code( 1, 0, 0x1F0);  	addsymbol("onx", predef); 
predef.adresse =  binary_code( 1, 0, 0x1F1);  	addsymbol("ony", predef); 
predef.adresse =  binary_code( 2, 0, 0x1F2);  	addsymbol("onxy", predef); 
predef.adresse =  binary_code( 0, 0, 0x1F3);  	addsymbol("all", predef); 
predef.adresse =  binary_code( 0, 0, 0x1F8);  	addsymbol("bcomx", predef); addsymbol("b>>x", predef); 
predef.adresse =  binary_code( 0, 0, 0x1F9);  	addsymbol("bcomy", predef); addsymbol("b>>y", predef); 
predef.adresse =  binary_code( 0, 0, 0x1FA);  	addsymbol("comx", predef); addsymbol(">>x", predef); 
predef.adresse =  binary_code( 0, 0, 0x1FB);  	addsymbol("comy", predef); addsymbol(">>y", predef); 
predef.adresse =  binary_code( 0, 0, 0x1FE);  	addsymbol("comx-", predef); addsymbol("<<x", predef); 
predef.adresse =  binary_code( 0, 0, 0x1FF);  	addsymbol("comy-", predef); addsymbol("<<y", predef); 
predef.adresse =  binary_code( 1, 0, 0x402);  	addsymbol("btn", predef);
predef.adresse =  binary_code( 1, 1, 0x402);  	addsymbol("btnpush", predef);  
predef.adresse =  binary_code( 1, 0, 0x401);  	addsymbol("delay", predef);
predef.adresse =  binary_code( 0, 0, 0x410);  	addsymbol("reconfigure", predef);

predef.slave = 1;   /// slave only

predef.adresse =  binary_code( 0, 1, 0x200);  	addsymbol("get", predef); 
predef.adresse =  binary_code( 1, 0, 0x201);  	addsymbol("put", predef); 
predef.adresse =  binary_code( 0, 1, 0x202);  	addsymbol("xnum", predef); 
predef.adresse =  binary_code( 0, 1, 0x203);  	addsymbol("ynum", predef); 
predef.adresse =  binary_code( 0, 0, 0x204);  	addsymbol("sleep", predef); 

};


public static String hex(int n) {										// utilitaire hexa
		 return String.format("0x%4s", Integer.toHexString(n)).replace(' ', '0');
}
public static String hex8(int n) {										// utilitaire hexa
		 return String.format("$%s", Integer.toHexString(n)).replace(' ', '0');
}

public int [] code = new int [10000];									// tableau du code produit

public void literal_generate(String lit_string)
{	
	lit_string = lit_string.replace("_", "");
	int length = lit_string.length(); 
	String more3 ;
	if (length < 5 ){
		more3 = "000".concat(lit_string.substring(1, length));
		code[adresse++] = Integer.parseInt(more3,16) + 0x2000;
	} else if (length <8) {
		more3 = "000".concat(lit_string.substring(length-3, length));
		code[adresse++] = Integer.parseInt(more3,16) + 0x2000;
		more3 = "000".concat(lit_string.substring(1, length-3));
		code[adresse++] = Integer.parseInt(more3,16) + 0x2000;
		code[adresse++]=symbol.get("<-$").adresse;
	} else if (length <10) {
		more3 = "000".concat(lit_string.substring(length-3, length));
		code[adresse++] = Integer.parseInt(more3,16) + 0x2000;
		more3 = "000".concat(lit_string.substring(length-6, length-3));
		code[adresse++] = Integer.parseInt(more3,16) + 0x2000;
		more3 = "000".concat(lit_string.substring(1, length-6));
		code[adresse++] = Integer.parseInt(more3,16) + 0x2000;
		code[adresse++]=symbol.get("<-$").adresse;
		code[adresse++]=symbol.get("<-$").adresse;
	} else {
		warning("value out of range 32 bits : "+ lit_string, nbline);
	} ;
} ;
public static void error(String mess, Integer... b) {
    Integer ligne = b.length > 0 ? b[0] : 0;

							System.out.println("--==========================================================");
							System.out.println ("--ERROR <"+ligne+"> : "+mess);
							System.out.println("--==========================================================");
}
public static void warning(String mess, Integer... b) {
    Integer ligne = b.length > 0 ? b[0] : 0;
							System.out.println("----------------------------------------------------------");
							System.out.println ("--WARNING <"+ligne+"> : "+mess);
							System.out.println("----------------------------------------------------------");
}
public static void debug(String mess) {
							System.out.println ("--debug : "+mess);
							}
public  int binary_code(int X, int Y, int mycode) {					// generation des 16 bits a partir de X Y et IPcode

	// test de validité l'IP
		if (mycode < 2048 && mycode >=0 && X>=0 && X< 4 && Y>= 0 && Y <=4 ) {

				return  (mycode + 2048 *Y + 8192 * X + 32768);
			} else {
				error ("  binary code incorrect 0x0000 generated!!!!");
				return  0 ;

			}
	}

public void NBnull() {												// remplissage par des FFFF
	int NB = adresse % 4 ;
	switch (NB) {
		case 1 : code[adresse++]= 0xFFFF;code[adresse++]= 0xFFFF;code[adresse++]= 0xFFFF;
				break;
		case 2 : code[adresse++]= 0xFFFF;code[adresse++]= 0xFFFF;
				break;
		case 3 : code[adresse++]= 0xFFFF;
				break;
	}
}

public void call_name ( SymbolElement ref){							// generation d'un call suivant le type de mots forth vc pc etc...
	if ( ref.idType== IPonly){
		code[adresse++] = ref.adresse; 
	}
	else if (ref.idType== WORD || ref.idType== VC || ref.idType== IP){
			if (adresse % 4 > 1) 
				{ NBnull(); };
			code[adresse] = code_call; 
			code[adresse+1] = ref.adresse / 65536; 
			code[adresse+2] = ref.adresse % 65536;
			adresse = adresse +3 ;		
	}
	else if (ref.idType==PC) {
		code[adresse++] = ref.adresse /4 + 0x4000;
		 if(in_slave == 2 ){
			warning(" PC call in slave only for dynamic allocation:  check yourself!!!", nbline);
		}
	}

}
public static int adresse;



Stack<Integer> pile = new Stack<Integer>();						// pile pour gener les adresse de branchement en avant



}
																												/// grammar start here

ipName : Name {nbline = $Name.line;};

		
root  : 	{	System.out.println (version + " : begin "); code[0] = 0x0C00; code[1] = 0x0000; code[2] = 0x0004; code[3] = code_halt; 
				adresse = 0x20 ;initIppredef();  // premiere ligne du code
				Reg currentreg ;
							SymbolElement currentVC ; currentVC = new SymbolElement(0,0,0,0 );	
							currentVC.idType = VC ; currentVC.slave = 2; currentVC.adresse = 4; currentVC.adresse_reconfig = -1;  // mise a jour de la table des symboles
							symbol.put("trap1", currentVC);
							code[4]= code_halt;code[7]= code_halt;
							currentVC = new SymbolElement(0,0,0,0 );	
							currentVC.idType = VC ; currentVC.slave = 2; currentVC.adresse = 8; currentVC.adresse_reconfig = -1;
							symbol.put("trap2", currentVC);
							code[8]= code_halt;code[11]= code_halt;
							currentVC = new SymbolElement(0,0,0,0 );	
							currentVC.idType = VC ; currentVC.slave = 2; currentVC.adresse = 12; currentVC.adresse_reconfig = -1;
							symbol.put("trap3", currentVC);
							code[12]= code_halt;code[15]= code_halt;
							currentVC = new SymbolElement(0,0,0,0 );	
							currentVC.idType = VC ; currentVC.slave = 2; currentVC.adresse = 16; currentVC.adresse_reconfig = -1;
							symbol.put("trap4", currentVC);
							code[16]= code_halt;code[19]= code_halt;
							currentVC = new SymbolElement(0,0,0,0 );	
							currentVC.idType = VC ; currentVC.slave = 2; currentVC.adresse = 20; currentVC.adresse_reconfig = -1;
							symbol.put("trap5", currentVC);
							code[20]= code_halt;code[23]= code_halt;
							currentVC = new SymbolElement(0,0,0,0 );	
							currentVC.idType = VC ; currentVC.slave = 2; currentVC.adresse = 24; currentVC.adresse_reconfig = -1;
							symbol.put("trap6", currentVC);
							code[24]= code_halt;code[27]= code_halt;
							currentVC = new SymbolElement(0,0,0,0 );	
							currentVC.idType = VC ; currentVC.slave = 2; currentVC.adresse = 28; currentVC.adresse_reconfig = -1;
							symbol.put("trap7", currentVC);
							code[28]= code_halt;code[31]= code_halt;				
				}
			
			(IpT iPDeclare | vcDeclare | wordDeclare | staticDeclare)*			// declaration de mot visible sur slave et master
			(	'slave' 		{System.out.println (version+" : slave  ");
								in_slave = 1;
								slave_adr = adresse;
								}
				(IpT iPDeclare | pcDeclare | vcDeclare | wordDeclare | staticDeclare)*    	// declaration de mot  de slave
				StartT  { nbline = $StartT.line;
							NBnull();
							start_slave_adr = adresse;
							code[1] = adresse / 65536; 
							code[2] = adresse % 65536;
						
						if (ram_used) System.out.println ( "slave local RAM used by compiler: "+next_reg);
						while (!stackreg.empty())  {
							currentreg = new Reg();
							currentreg = stackreg.pop();
							literal_generate( currentreg.initvalue);
							code[adresse++] = currentreg.adresse;
							code[adresse++] = symbol.get("write").adresse;
							if (currentreg.slave==0) stacksavereg.push(currentreg);
							
							} 
						stackreg.clear();
						stackreg.addAll(stacksavereg);
						next_reg = stackreg.size()+1;
						}
						
				(homadeCode)* 
				MasterT 		{nbline = $MasterT.line;System.out.println (version+" : master  ");
									in_slave = 2;

									if (adresse == start_slave_adr) {																		// mise a jour de l adresse de branchement du svlve sur l adresse 0
										code [0] = code_halt; code[1] = 0xFFFF; code[2] = 0xFFFF; code[3] = 0xFFFF;
																				// cas ou slave est vide
									} else {
										code[adresse++] = code_halt;
										NBnull();
											
									} 
									code[adresse++] = 0xFFFF;
									NBnull();
									
									if ((slave_adr == 0x20) && (nb_pc == 0) ){
										master_adr = 8;code[4] = 0xFFFF; code[5] = 0xFFFF; code[6] = 0xFFFF; code[7] = 0xFFFF;  
									} else {
										master_adr = adresse;
									}	
											// on reinitialise les trap si il y a eu des PC declarés
									code[4+master_adr]= code_halt;code[7+master_adr]= code_halt;
									code[8+master_adr]= code_halt;code[11+master_adr]= code_halt;
									code[12+master_adr]= code_halt;code[15+master_adr]= code_halt;
									code[16+master_adr]= code_halt;code[19+master_adr]= code_halt;
									code[20+master_adr]= code_halt;code[23+master_adr]= code_halt;
									code[24+master_adr]= code_halt;code[27+master_adr]= code_halt;
									code[28+master_adr]= code_halt;	code[31+master_adr]= code_halt;										
									adresse = master_adr + 32;
									// premiere ligne du maitre
									code[master_adr] = 0x0C00; code[master_adr+1] = 0x0000; code[master_adr+2] = 0x0000; code[master_adr+3] = code_halt;  
									// recopie les codes des mots visibles sur master et slave dans le master 
										for (int i= 0x20; i< slave_adr; i++){
											code [adresse++] = code[i];
										};							


									
								NBnull();

								
								} 
				
				(IpT iPDeclare  |(vcDeclare) |(wordDeclare)|(staticDeclare))*					// mot visible sur le maitre pas de PCdeclare
				StartT { nbline = $StartT.line;NBnull();																				// mise a jour de la premiere ligne du maitre
						code[master_adr+1] = (adresse - master_adr )/ 65536; 
						code[master_adr+ 2] = (adresse - master_adr) % 65536;
						System.out.println ( " master local RAM used by compiler: "+next_reg);
						while (!stackreg.empty())  {
							currentreg = new Reg();
							currentreg = stackreg.pop();
							literal_generate( currentreg.initvalue);
							code[adresse++] = currentreg.adresse+0x2000;
							code[adresse++] = symbol.get("write").adresse;					
							} 
						}
			| 
				ProgramT 																						// pas de slave il faut cosntruire le code minimal
						{nbline = $ProgramT.line;System.out.println (version+" : program  ");
							in_slave = 2;
							code[0] = 0x1C00; adresse = 1; NBnull();
							code[4] = 0xFFFF; adresse = 5; NBnull();
							code[8] = 0x0C00; code[9] = 0x0000; code[10] = 0x0004; code[11] = 0x1c00;			// premiere ligne du maitre ds ce cas
							adresse = 40;
							master_adr = 8;
							code[24+master_adr]= code_halt;code[27+master_adr]= code_halt;
							code[28+master_adr]= code_halt;code[31+master_adr]= code_halt;
							NBnull();

						}
				(IpT iPDeclare | (vcDeclare) |(wordDeclare)|(staticDeclare))* 					// mots visible sur le maitre
				StartT { nbline = $StartT.line;NBnull();
						code[9] = (adresse - master_adr) / 65536; 
						code[10] = (adresse - master_adr) % 65536;
						if (ram_used) System.out.println ( "master local RAM used by compiler: "+next_reg);
						while (!stackreg.empty())  {
							currentreg = new Reg();
							currentreg = stackreg.pop();
							literal_generate( currentreg.initvalue);
							code[adresse++] = currentreg.adresse +0x2000;
							code[adresse++] = symbol.get("write").adresse;
						} 
						}
			)  
			(homadeCode)* 
			EndprogramT 		{nbline = $EndprogramT.line;System.out.println (version +" : end "); 									// fin de code  ffffffffff
									code[adresse] = code_halt; 
									adresse ++;NBnull();
									code[adresse] = 0xFFFF; adresse++; NBnull();  // end of file
									
																												// mettre le slave apres le master 
									////////////////////////////////////////////////////////////////////////																			
									System.out.println("============== MASTER");																			
									for(int i=master_adr; i<adresse; i++){												// affichage du code
										if (i % 4 == 0) {
											System.out.println("--------------");									
										}
										
										
										if (i < master_adr ) {
											System.out.println(hex(i)+" : " +hex(code[i] ));
										} else {
											System.out.println(hex(i-master_adr)+" : " +hex(code[i] ));
										}
									}
											System.out.println("============== SLAVE");
									for(int i=0; i<master_adr; i++){												// affichage du code
										if (i % 4 == 0) {
											System.out.println("--------------");									
										}
										
										
										if (i < master_adr ) {
											System.out.println(hex(i)+" : " +hex(code[i] ));
										} else {
											System.out.println(hex(i-master_adr)+" : " +hex(code[i] ));
										}
									}
									try {
										isim =  new PrintWriter(new BufferedWriter (new FileWriter("Homade.isim")))	;		
										}catch ( IOException e) {}
										// ecriture dans isim file															
									isim.println("constant  rom : rom_array := ( ");	
									isim.println(" --  master code ");										
									for(int i=master_adr; i<adresse; i=i+4){												
										
											isim.println(" x\""+hex(code[i]).substring( 2, 6)+"_"+
											hex(code[i+1]).substring( 2, 6)+"_"+
											hex(code[i+2]).substring( 2, 6)+"_"+
											hex(code[i+3]).substring( 2, 6)+"\", -- "+hex(i-master_adr));
										
									}
									isim.println(" --  slave code ");
									for(int i=0; i<master_adr-4 ; i=i+4){											
										
											isim.println(" x\""+hex(code[i]).substring( 2, 6)+"_"+
											hex(code[i+1]).substring( 2, 6)+"_"+
											hex(code[i+2]).substring( 2, 6)+"_"+
											hex(code[i+3]).substring( 2, 6)+"\", -- "+hex(i));
										
									}								
									isim.println(" x\""+hex(code[master_adr-4]).substring( 2, 6)+"_"+hex(code[master_adr-4+1]).substring( 2, 6)+"_"+hex(code[master_adr-4+2]).substring( 2, 6)+"_"+hex(code[master_adr-4+3]).substring( 2, 6)+"\"  -- "+hex(master_adr-4));
									isim.println(");");
									isim.close();
	
									/// ecriture dans un fichier binaire
									try {
									codefile = new FileOutputStream ( "homade.hmd");
									} catch ( FileNotFoundException e) {}
									for(int i=master_adr; i<adresse; i++){
										try {codefile.write(code[i] / 0x100);codefile.write(code[i]);}catch (IOException e){}
									}
									for(int i=0; i<master_adr; i++){
										try {codefile.write(code[i] / 0x100);codefile.write(code[i]);}catch (IOException e){}
									}										
									
									try{codefile.close();}catch (IOException e){}
								}
			;





iPDeclare :    	ipName     
					(word16) {
						boolean short_or_long=false;
						SymbolElement currentIP ; currentIP = new SymbolElement(0,0,0,0 );	nb_entry=0;IPadr=adresse;nb_state = 0;
						currentIP.idType = IPonly ; currentIP.slave = in_slave; currentIP.adresse = ipword ; currentIP.adresse_reconfig = -1;  // type IPonly si pas de spec adresse contient le code  de l IP
						}
					( '(' {currentIP.adresse_reconfig =0;} (HEXA{ /// reconfigration dynamique  ()  means 0
						int length = $HEXA.text.length(); 
						currentIP.adresse_reconfig =Integer.parseInt($HEXA.text.substring(1,length) ,16) ;
						} 
					)? ')'
					)?
					{symbol.put($ipName.text, currentIP);}		

					 ( EntryT Name 
						{
						nbline = $Name.line;
						currentIP = new SymbolElement(0,0,0,0 );	
						currentIP.idType = IPonly ; currentIP.slave = in_slave; currentIP.adresse = ipword+nb_entry; ; currentIP.adresse_reconfig = -1;
						currentIP.fathername = $ipName.text;currentIP.entry = nb_entry;
						code[adresse++]= nb_entry+ 0x2000;
						code[adresse++]=symbol.get(">r").adresse;
						adresse++; 
						nb_entry++;
						symbol.put($Name.text, currentIP);
						stackentry.push($Name.text);
						}
					)* 
						
						
						{register_declare = false;}
					((RegisterT  Name{	String valueinit = new String("0");	nbline = $Name.line;
						}
						( AffectVCPC { int tempadr = adresse;} literal {adresse=tempadr; valueinit = lit_string;} )?
						{
							register_declare = true;
							currentIP = new SymbolElement(0,0,0,0 );	
							currentIP.idType = REG ; currentIP.slave = in_slave; currentIP.adresse = next_reg ; currentIP.adresse_reconfig = -1;  // type REG adresse  emplacement memoire
							next_reg =next_reg+2 ;   /// deux emplacement pour un registre lecture ds le premier ecriture ds le second  , recopie en fin d IP
							symbol.put(">"+$Name.text, currentIP);
							symbol.put($Name.text+">", currentIP);
							Reg regelement = new Reg();
							regelement.adresse =next_reg -2;
							regelement.initvalue = valueinit;
							regelement.slave= in_slave;
							stackreg.push(regelement);
						}
						) |((InputT | OutputT) Name {nbline = $Name.line; }( AffectVCPC literal 
								)? 
							{
							warning(" Input or output not supported for soft code generation", nbline);})
					)* ((ShortT {nbline = $ShortT.line;
						short_or_long=true;
						ram_used = true;
						if (nb_entry == 0 ) {
							code[adresse++]= 0x2000;
							code[adresse++]=symbol.get(">r").adresse;
						}
						int i = 4, nb_en=nb_entry, localadr= adresse;
						if (nb_entry >0) {
							adresse--;NBnull();
							while (nb_en > 1){
								code [localadr - i] = (i)+adresse-localadr % 1024;
								nb_en--;
								i=i+3;
							}
						}
						code[adresse++]= 0x2000;
						code[adresse++]= 0x2000;
						code[adresse++]= symbol.get("write").adresse;

						
						String softname = $ipName.text.concat("_soft");}
						 // ('(' Name {softname = $Name.text;nbline = $Name.line;} ')')?  -- si on veut mettre un non pour le short pas supporté pour l isnatnt
						{
						 currentIP = new SymbolElement(0,0,0,0 );
						 currentIP.adresse_reconfig = -1; 
						 currentIP.idType = WORD; 
						 currentIP.slave = in_slave;
						 currentIP.adresse = IPadr-master_adr;
						 if(nb_entry==0) {
							symbol.put(softname, currentIP);
						} else {
							symbol.remove($ipName.text);
						}
						 while (!stackentry.empty()){
							SymbolElement entrysymbol = new SymbolElement(0,0,0,0 );
							currentIP = new SymbolElement(0,0,0,0 );
							String entryname = stackentry.pop();
							entrysymbol= symbol.get(entryname);
							currentIP.adresse_reconfig = -1; 
							currentIP.idType = WORD; 
							currentIP.slave = in_slave;
							currentIP.adresse = IPadr-master_adr+entrysymbol.entry*3;
							symbol.put(entryname.concat("_soft"), currentIP);
						
							}
						 }
						
					
					(homadeCodeIP)?
									
					)
									
					| 
					( LongT {nbline = $LongT.line;
						short_or_long=true;
						ram_used = true;
						if (nb_entry == 0 ) {
						code[adresse++]= 0x2000;
						code[adresse++]=symbol.get(">r").adresse;
						}
						int i = 4, nb_en=nb_entry, localadr= adresse;
						if (nb_entry >0) {
							adresse--;NBnull();
							while (nb_en > 1){
								code [localadr - i] = (i)+adresse-localadr % 1024;
								nb_en--;
								i=i+3;
							}
						}
						code[adresse++]= 0x2000;
						code[adresse++]= 0x2000;
						code[adresse++]= symbol.get("write").adresse;

						String softname = $ipName.text.concat("_soft"); lastadr = 0;}
						 // ('(' Name {softname = $Name.text;nbline = $Name.line;} ')')?  -- si on veut mettre un non pour le short pas supporté pour l isnatnt
						{
						 currentIP = new SymbolElement(0,0,0,0 );
						 currentIP.adresse_reconfig = -1; 
						 currentIP.idType = WORD; 
						 currentIP.slave = in_slave;
						 currentIP.adresse = IPadr-master_adr;
						 if(nb_entry==0) {
							symbol.put(softname, currentIP);
						} else {
							symbol.remove($ipName.text);
						}
						 while (!stackentry.empty()){
							SymbolElement entrysymbol = new SymbolElement(0,0,0,0 );
							currentIP = new SymbolElement(0,0,0,0 );
							String entryname = stackentry.pop();
							entrysymbol= symbol.get(entryname);
							currentIP.adresse_reconfig = -1; 
							currentIP.idType = WORD; 
							currentIP.slave = in_slave;
							currentIP.adresse = IPadr-master_adr+entrysymbol.entry*3;
							symbol.put(entryname.concat("_soft"), currentIP);
						
							}
						 }
						  (Name  {nbline = $Name.line;currentIP = new SymbolElement(0,0,0,0 );	nbline = $Name.line;
								currentIP.idType = STATE ; currentIP.slave = in_slave; currentIP.adresse = nb_state++; ; currentIP.adresse_reconfig = -1;
								currentIP.fathername = "";currentIP.entry = -1;
								symbol.put($Name.text, currentIP);
								}
						  )+   
									
						('{' Name 
						{	nbline = $Name.line; while (!writereg.empty())  {
								String namereg = writereg.pop();
								code[adresse++]= symbol.get(namereg).adresse +0x2001;
								code[adresse++] = symbol.get("read").adresse;
								code[adresse++]= symbol.get(namereg).adresse +0x2000;
								code[adresse++] = symbol.get("write").adresse;				
							} 
							if (symbol.containsKey($Name.text) ) {  														// verficication de la déclaration du mot ds la table des symboles
								if (symbol.get($Name.text).slave == in_slave || symbol.get($Name.text).slave == 0){  	// verification de la portée
									if (symbol.get($Name.text).idType  == STATE ){
										code[adresse++] = lastadr; 
										lastadr = adresse -1;				/// emplacement pour bra
										currentIP = new SymbolElement(0,0,0,0 );
										currentIP = symbol.get($Name.text);
										currentIP.entry = adresse;
										symbol.put($Name.text, currentIP);										
									} else {
										error(" "+ $Name.text +"  is not a state name !!!", nbline);
									}
								}
							} else {
								error(" "+ $Name.text +" does not exist", nbline);  
							}	
						}						
						'}' (homadeCodeIP? (
							IpdoneT {nbline = $IpdoneT.line; 
								code[adresse++]=0x2FFF;
								code[adresse++]=0x2000;
								code[adresse++]=symbol.get("write").adresse;	
								}
							| StateT  {nbline = $StateT.line; 
								code[adresse++]=0x2000;
								code[adresse++]=symbol.get("write").adresse;	
								}
							) 
							homadeCodeIP?)?  
						)*
					)
					)? SemiT {nbline = $SemiT.line;String namereg = "";
						if (short_or_long) { 
							while (!writereg.empty())  {
									namereg = writereg.pop();
								code[adresse++]= symbol.get(namereg).adresse +0x2001;
								code[adresse++] = symbol.get("read").adresse;
								code[adresse++]= symbol.get(namereg).adresse +0x2000;
								code[adresse++] = symbol.get("write").adresse;
															
								} 
							while (lastadr!= 0){
								int temp = code[lastadr];
								stackadr.push(lastadr+1 );
								code[lastadr] = adresse - lastadr  ;
								lastadr= temp;
								}
							int istate = 0;				
							while(!stackadr.empty()){
								code[adresse++] = 0x2000;
								code[adresse++] = symbol.get("read").adresse;
								code[adresse++] = 0x2000 + istate;
								istate = istate + 1 ;
								code[adresse++] = symbol.get("=").adresse;
								code[adresse++] = 0xa000;
								code[adresse++] = 3072 -(adresse  - stackadr.pop()) +1 ;
								
							}	
							code[adresse++]=symbol.get("r>pop").adresse;
							code[adresse++] = code_return; }	
						}
				; 




pcDeclare : PcT Name { nbline = $Name.line;
						SymbolElement currentPC ; currentPC = new SymbolElement( 0,0,0,0);	
						VCorPC = false;
						NBnull();
						currentPC.idType = PC ; currentPC.slave = in_slave; currentPC.adresse = adresse - master_adr; // mise a jour de la table des symboles
						if(nb_pc < 7) {
							nb_pc ++;
							VCPCadresse = nb_pc*4;
							currentPC.adresse= nb_pc*4 ;
						}else{
							VCPCadresse = adresse;
							code[adresse++]= code_halt;
							code[adresse++]= 0x0000;
							code[adresse++]= 0x0000;
							code[adresse++]= code_halt;
						}
						symbol.put($Name.text, currentPC);
					}  vcpcvalue?;
				
vcDeclare : VcT Name { nbline = $Name.line;
						SymbolElement currentVC ; currentVC = new SymbolElement(0,0,0,0 );	
						VCorPC = true;
						NBnull();
						currentVC.idType = VC ; currentVC.slave = in_slave; currentVC.adresse = adresse - master_adr; currentVC.adresse_reconfig = 0;    // mise a jour de la table des symboles
						symbol.put($Name.text, currentVC);
						VCPCadresse = adresse;
						code[adresse++]= code_return;
						code[adresse++]= 0x0000;
						code[adresse++]= 0x0000;
						code[adresse++]= code_return;
					} vcpcvalue?;
					
					
vcpcvalue : 			( AffectVCPC {int code_fin = VCorPC ? code_return : code_halt;}
						( Name
							{  nbline = $Name.line;
								if (symbol.containsKey($Name.text) ) {  														// verficication de la déclaration du mot ds la table des symboles
									if (symbol.get($Name.text).slave == in_slave || symbol.get($Name.text).slave == 0){  	// verification de la portée
										if (symbol.get($Name.text).idType  == WORD ){
											code[VCPCadresse]= code_call;
											code[VCPCadresse+1]= (symbol.get($Name.text)).adresse / 0x10000;
											code[VCPCadresse+2]= (symbol.get($Name.text)).adresse % 0x10000;
										} else if (symbol.get($Name.text).idType  == IPonly ) {
											code[VCPCadresse]= (symbol.get($Name.text)).adresse ;
											code[VCPCadresse+1]= code_fin;
										} else {
											error(" "+ $Name.text +"  not allowed in VC/PC value !!!", nbline);
										}
									} else {
										error(" "+ $Name.text +" does not exist here !!!", nbline);
									}
								} else {
									error(" "+ $Name.text +" does not exist", nbline);  
								}
							}
						| literal {
							if (lit_string.length()>4 ){
								error(" constant too long 12 bits max!!", nbline);  
								} else {
									 code[VCPCadresse]= code [adresse -1] ;  // generé par literal deja
									code[VCPCadresse+1]= code_fin;
									adresse= adresse -1;
								}
							}	
						| '{' iPextend iPextend 
							{						
							code[VCPCadresse]= code[adresse-2] ;
							code[VCPCadresse+1]= code[adresse-1];
							code[VCPCadresse+2]= code_fin;
							adresse = adresse -2;
							}
							( iPextend 
								{
								code[VCPCadresse+2]= code[adresse-1] ;
								code[VCPCadresse+3]= code_fin;
								adresse--;
								}
							)? 
						'}'
						) 
					)
				;
				
iPextend : (Name { nbline = $Name.line;
						if (symbol.containsKey($Name.text) ) {  														// verficication de la déclaration du mot ds la table des symboles
							if (symbol.get($Name.text).slave == in_slave || symbol.get($Name.text).slave == 0){  	// verification de la portée
								if (symbol.get($Name.text).idType  == IPonly ){
										code[adresse++] = (symbol.get($Name.text)).adresse ;							
								} else {
									error(" "+ $Name.text +"  not allowed in VC constructor !!!", nbline);
								}
							}
						} else {
							error(" "+ $Name.text +" does not exist", nbline);  
						}							
				}
			| literal {
							if (lit_string.length()>4 ){
								error(" constant too long 12 bits max!!", nbline);  
								}
							}
			)							
		;
				
wordDeclare : ColonT ipName  { nbline = $ColonT.line;SymbolElement currentid ; currentid = new SymbolElement( 0,0,0,0);						// declare un mot a la forth
								NBnull();
								currentid.idType = WORD ; currentid.slave = in_slave; currentid.adresse = adresse - master_adr;   // mise a kour de la table des symboles
								symbol.put($ipName.text, currentid);
							}
			(homadeCode)? 
			SemiT { code[adresse++] = code_return; };									// generation du return
staticDeclare : (
					vcpcName 
					{
						if (symbol.containsKey($vcpcName.text) ) {  														// verficication de la déclaration du mot ds la table des symboles
							if (symbol.get($vcpcName.text).slave == in_slave || symbol.get($vcpcName.text).slave == 0){  	// verification de la portée
								if (symbol.get($vcpcName.text).idType != VC && symbol.get($vcpcName.text).idType != PC ){
									error(" "+ $vcpcName.text +" is not PC or VC !!!", nbline);
								} else {
									VCPCadresse = (symbol.get($vcpcName.text)).adresse + master_adr;
									VCorPC = (symbol.get($vcpcName.text).idType == VC) && (symbol.get($vcpcName.text).adresse_reconfig != -1);
								}
								
							} else {
								error(" "+ $vcpcName.text +" does not exist here !!!", nbline);
							}
						} else {
							error(" "+ $vcpcName.text +" does not exist", nbline);  
						} 
					}
					vcpcvalue
				)
			
;			

literal :   (HEXA { lit_string= $HEXA.text;}
			| BOOL { lit_string= hex8((int)(long)Long.parseLong( $BOOL.text.substring(1,$BOOL.text.length()), 2));}
			| INT { lit_string= hex8($INT.int);}
			)    { literal_generate (lit_string);};
					
word16 :  HEXA  {	int length = $HEXA.text.length(); 
						if (length != 5 ){
							System.out.println("value out of range 16 bits fixed");
						} else{
							ipword = Integer.parseInt($HEXA.text.substring(1,length) ,16) ;
						}	
				};

homadeCode : ( 	
				BeginT { nbline = $BeginT.line;NBnull(); pile.push (adresse); 
					}
					homadeCode?
					( AgainT 
						{nbline = $AgainT.line;int begin_adr , offset; 
							begin_adr =	pile.pop();
							offset = adresse - begin_adr;
							if (offset < 1024) {  																	// BR relatif ofsset  sur 10 bit
								code[adresse++] = -offset + 1024 ;
							} else {
								if(adresse %4 > 1 ) { 																// BA  offset trop grand pour 10 bits
									NBnull();
								};
								code[adresse++]= 0x1000;													
								code[adresse++]= (begin_adr - master_adr) / 65536; 
								code[adresse++]=  (begin_adr - master_adr) % 65536;
							}
						}
					| UntilT 
						{nbline = $UntilT.line;int begin_adr , offset; 
							begin_adr =	pile.pop();
							code[adresse++]=symbol.get("pop1").adresse;	
							offset = adresse - begin_adr;
							if (offset < 1024) {  																	// BZ relatif ofsset  sur 10 bit
								code[adresse++] = -offset + 2048 ;
							} else {
								code [adresse++] = 0x0804; 
								if(adresse %4 > 1 ) { 																// bnz 4 + BA  offset trop grand pour 10 bits
									NBnull();
								};
								code[adresse++]= 0x1000;													
								code[adresse++]= (begin_adr - master_adr) / 65536; 
								code[adresse++]=  (begin_adr - master_adr) % 65536;
							}
						}
					)
				|
				ForT { 	nbline = $ForT.line;
						code [adresse++] = 0x2000;																	// indice a 0
						code[adresse++]=symbol.get(">r").adresse;
						code[adresse++]=symbol.get(">r").adresse;							
						NBnull();
						pile.push(adresse);						
					}			
					homadeCode ?
					NextT {nbline = $NextT.line;int for_adr, offset; 
							for_adr =	pile.pop();
							code[adresse++]=symbol.get("r>").adresse;	
							code[adresse++]=symbol.get("dec").adresse;	
							code[adresse++]=symbol.get(">rdup").adresse;	
							code[adresse++]=symbol.get("0<").adresse;	
							code[adresse++]=symbol.get("pop1").adresse;					
							offset = adresse - for_adr;
							if (offset < 1024) {  																	// BZ relatif ofsset  sur 10 bit
								code[adresse++] = -offset + 2048 ;
							} else {
								code [adresse++] = 0x0804; 
								if(adresse %4 > 1 ) { 																// bnz 4 + BA  offset trop grand pour 10 bits
									NBnull();
								};
								code[adresse++]= 0x1000;													
								code[adresse++]= (for_adr - master_adr) / 65536; 
								code[adresse++]=  (for_adr - master_adr) % 65536;
							}
							code[adresse++]=symbol.get("r>pop").adresse;
							code[adresse++]=symbol.get("r>pop").adresse;	
						} 
				|
				DoT {	nbline = $DoT.line;
						code[adresse++]=symbol.get("swap").adresse;
						code[adresse++]=symbol.get(">r").adresse;
						code[adresse++]=symbol.get(">r").adresse;	
						NBnull();
						pile.push(adresse);	}
					homadeCode ?
					(	LoopT { nbline = $LoopT.line;loop = true;} | LoopplusT {nbline = $LoopplusT.line; loop = false;})
						{	int for_adr, offset; 
							for_adr =	pile.pop();
							code[adresse++]=symbol.get("r>").adresse;
							if (loop){
								code[adresse++]=symbol.get("inc").adresse;
							} else {
								code[adresse++]=symbol.get("add").adresse;
							}
							code[adresse++]=symbol.get("r>").adresse;
							code[adresse++]=symbol.get(">rdup").adresse;
							code[adresse++]=symbol.get("swap").adresse;
							code[adresse++]=symbol.get(">rdup").adresse;
							code[adresse++]=symbol.get(">").adresse;
							code[adresse++]=symbol.get("pop1").adresse;
							offset = adresse - for_adr;
							if (offset < 1024) {  																	// BZ relatif ofsset  sur 10 bit
								code[adresse++] = -offset + 1024 + 2048 ;
							} else {
								code [adresse++] = 0x0404; 
								if(adresse %4 > 1 ) { 																// bnz 4 + BA  offset trop grand pour 10 bits
									NBnull();
								};
								code[adresse++]= 0x1000;													
								code[adresse++]= (for_adr - master_adr) / 65536; 
								code[adresse++]=  (for_adr - master_adr) % 65536;
							}
							code[adresse++]=symbol.get("r>pop").adresse;
							code[adresse++]=symbol.get("r>pop").adresse;
						} 
				|
				IfT { nbline = $IfT.line;
						code[adresse++]=symbol.get("pop1").adresse;
						pile.push(adresse);
						code[adresse++] = 0x0000 ;
					}
					homadeCode ?
					(
					( ElseT { nbline = $ElseT.line;
						int if_adr, ioffset ;
						if_adr = pile.pop();
						pile.push(adresse);
						code[adresse++] = 0x0000 ;
						NBnull();
						ioffset = adresse - if_adr;
						if (ioffset < 1024) {  																	// BZ relatif ofsset  sur 10 bit
								code[if_adr] = ioffset + 1024  ;
						} else {
							error(" Compiler : Then part is too large not yet implemented !!!" + ioffset, nbline);
						}	
					}
					homadeCode ?
					EndifT {nbline = $EndifT.line;
						int else_adr, eoffset ;
						else_adr = pile.pop();
						NBnull();
						eoffset = adresse - else_adr;
						if (eoffset < 1024) {  																	// BZ relatif ofsset  sur 10 bit
								code[else_adr] = eoffset  ;
						} else {
							error(" Compiler : Else part is too large not yet implemented !!!" + eoffset, nbline);
						}	
					}
					)
					|
					EndifT { nbline = $EndifT.line;
						int endif_adr, doffset ;
						endif_adr = pile.pop();
						NBnull();
						doffset = adresse - endif_adr;
						if (doffset < 1024) {  																	// BZ relatif ofsset  sur 10 bit
								code[endif_adr] = doffset  +1024;
						} else {
							error(" Compiler : Then part is too large not yet implemented !!!" + doffset, nbline);
						}	
					}
					)
				|
				WaitT {	nbline = $WaitT.line;
						if (in_slave== 1){
							error(" WAIT statement not allowed in slave : skipped !!!" , nbline);
						} else {
							code[adresse++] = code_wait;
						}
					 }
				| IndiceIT {nbline = $IndiceIT.line;
					code[adresse++]=symbol.get("r>").adresse;
					code[adresse++]=symbol.get(">rdup").adresse;
				}
				| IndiceJT {nbline = $IndiceJT.line;
					code[adresse++]=symbol.get("r>").adresse;
					code[adresse++]=symbol.get("r>").adresse;
					code[adresse++]=symbol.get("r>").adresse;
					code[adresse++]=symbol.get(">rdup").adresse;
					code[adresse++]=symbol.get("-rot").adresse;
					code[adresse++]=symbol.get(">r").adresse;
					code[adresse++]=symbol.get(">r").adresse;
				}
				| IndiceKT {nbline = $IndiceKT.line;
					code[adresse++]=symbol.get("r>").adresse;
					code[adresse++]=symbol.get("r>").adresse;
					code[adresse++]=symbol.get("r>").adresse;
					code[adresse++]=symbol.get("r>").adresse;
					code[adresse++]=symbol.get("r>").adresse;
					code[adresse++]=symbol.get(">rdup").adresse;
					code[adresse++]=symbol.get("-rot").adresse;
					code[adresse++]=symbol.get(">r").adresse;
					code[adresse++]=symbol.get(">r").adresse;
					code[adresse++]=symbol.get("-rot").adresse;
					code[adresse++]=symbol.get(">r").adresse;
					code[adresse++]=symbol.get(">r").adresse;				
				}
				|
				Name { nbline = $Name.line;
						if (symbol.containsKey($Name.text) ) {  														// verficication de la déclaration du mot ds la table des symboles
							if (symbol.get($Name.text).idType == PC ||(symbol.get($Name.text).slave == in_slave || symbol.get($Name.text).slave == 0)){  	// verification de la portée
								call_name(symbol.get($Name.text));	
								last_name = $Name.text;
							} else {
								error(" "+ $Name.text +" does not exist here !!!", nbline);
							}
						} else {
							error(" "+ $Name.text +" does not exist", nbline);  
						}
				
					}	
				(
				( { int x, y ; if (symbol.get(last_name).idType != IPonly) error (" " +last_name+" is not an IP ", nbline);}'{' INT {x =$INT.int; }
				INT {y =$INT.int; 
					if (x<0 || x >3) error(" 0, 1, 2 or 3 expected fo X ", nbline);
					else if (y<0 || y >3) error(" 0, 1, 2 or 3 expected for Y ", nbline);
						else  code [adresse -1]= code[adresse-1] % 0x0800+ x * 0x2000 + y * 0x0800 + 0x8000;
					}
				'}' 
				)
				|
					(  { // traitement preparatif pour un dynamic si <= arrive
					
					 														
						if (symbol.get(last_name).idType == VC || symbol.get(last_name).idType == PC){  	// verification de la portée
							adresse= (symbol.get(last_name).idType == PC)?adresse -1:adresse -3; // on ecrase le dernier call ou SPMD
							NBnull();  // besoin de 4 emplacement pour le wim
							VCorPC = (symbol.get(last_name).idType == VC) && (symbol.get(last_name).adresse_reconfig != -1);
							code[adresse++] = symbol.get(last_name).adresse /4 % 0x1000 + 0x3000;
							VCPCadresse = adresse;
							adresse = adresse + 4 ;   // on reserve la place pour ecrire  au plus 4 mots
						} else {
							error(" "+ last_name +" VC or PC expected !!!", nbline);
						}
					
					}
					vcpcvalue{ adresse --; // on ecrase le dernier return ou halt 
						}
					)
				| ( '^^'
					{   /// reconfiguration d'un IP
						if (symbol.get(last_name).idType == IPonly && symbol.get(last_name).adresse_reconfig != -1 ){
							lit_string= hex8(symbol.get(last_name).adresse_reconfig);
							adresse = adresse -1;
							literal_generate (lit_string);
							code[adresse++] = symbol.get("reconfigure").adresse ; // ajoute l IP reconfigure
						} else {
							error(" "+ last_name +" does not support dynamic reconfiguration!!!", nbline);
						}
					}
					)
				)?
				|
				literal
			 ) 
				(homadeCode)*;
homadeCodeIP : ( 	
				Name { nbline = $Name.line;
						if (symbol.containsKey($Name.text) ) {  														// verficication de la déclaration du mot ds la table des symboles
							if (symbol.get($Name.text).idType == IPonly &&(symbol.get($Name.text).slave == in_slave || symbol.get($Name.text).slave == 0)){  	// verification de la portée
								call_name(symbol.get($Name.text));	
							} else if (symbol.get($Name.text).idType == IPonly){
								error(" "+ $Name.text +" does not exist here !!!", nbline);
							}
							else if (symbol.get($Name.text).idType==REG) {
								if ($Name.text.charAt(0) == '>') {
									code[adresse++]= symbol.get($Name.text).adresse +0x2001;
									code[adresse++]= (symbol.get("write")).adresse;
									writereg.push($Name.text);
								}else {
									code[adresse++]= symbol.get($Name.text).adresse +0x2000;
									code[adresse++]= (symbol.get("read")).adresse;
								}
							}else if (symbol.get($Name.text).idType==STATE) {
								code[adresse++]= (symbol.get($Name.text)).adresse + 0x2000;
							} else {
								error(" "+ $Name.text +" is not an IP!!!", nbline);
							}
						} else {
							error(" "+ $Name.text +" does not exist", nbline);  
						}
				
					}	
				|
				literal 
				| 
				 ThisT {nbline = $ThisT.line;code[adresse++]=symbol.get("r>").adresse;
						code[adresse++]=symbol.get(">rdup").adresse;}
				|('-|' 
					{if (multiplexeur) {
							error (" |- -| not allowed here !!", nbline);
						} else {
							multiplexeur = true;
							casevalue = 0; braadr = 0;
							code[adresse++] = symbol.get(">rdup").adresse;
							
							lit_string= hex8(casevalue);
							literal_generate (lit_string);
							code[adresse++] = symbol.get("<>").adresse;
							code[adresse++] = symbol.get("pop1").adresse;
							caseadr = adresse; // ici pour la mise a jour du BRZ
							code[adresse++]=0;  // fin de liste
						}
					}
				homadeCodeIP+ ('|' 
					{
					int tempadr;
					casevalue++;
					code[adresse++]= braadr;  // futur BRA en fin 
					braadr=adresse-1;
					code[caseadr]= (adresse-caseadr) % 1024 + 2048;
					code[adresse++] = symbol.get("r>").adresse;
					code[adresse++] = symbol.get(">rdup").adresse;
					lit_string= hex8(casevalue);
					literal_generate (lit_string);
					code[adresse++] = symbol.get("<>").adresse;
					code[adresse++] = symbol.get("pop1").adresse;
					caseadr = adresse; // ici pour la mise a jour du BRZ
					adresse++;
					
					
					}(homadeCodeIP)+)* '|-' 
					{int tempadr;
					code [caseadr]=symbol.get("nop").adresse;;
					multiplexeur = false;
					do {
						tempadr = code[braadr];
						code[braadr]=(adresse-braadr) % 1024;
						braadr = tempadr;
					}while ( braadr!= 0);
					code[adresse++] = symbol.get("r>pop").adresse;
					}
				) 
			 ) 
			(homadeCodeIP)*;
				
vcpcName  : Name {nbline = $Name.line;};			
	





// lexer
AgainT  : ('again' | 'AGAIN'); 
BeginT  : 'begin' | 'BEGIN' ;
ColonT : ':' ;
DoT  : 'do' | 'DO';
ElseT  : 'else' | 'ELSE' ;
EndifT : 'endif' | 'ENDIF';
EndprogramT : 'endprogram' | 'ENDPROGRAM';
EntryT  : 'entry' | 'ENTRY' ;
IpdoneT  : 'ipdone' | 'IPDONE'; 
StateT  : '>state' | '>STATE' ;
InputT  : 'input' | 'INPUT' ;
OutputT  : 'output' | 'OUTPUT' ;
ForT : 'for' | 'FOR';
IfT : 'if' | 'IF';
IndiceIT : 'I()' ;
IndiceJT :  'J()' ;
IndiceKT :  'K()' ;
ThisT : 'this' | 'THIS' ;


IpT : 'IP'| 'ip'|':IP' | ':ip';
LongT : 'long' | 'LONG' ;
LoopplusT : '+loop' | '+LOOP' ;
LoopT : 'loop' | 'LOOP';
ShareT : 'share' | 'SHARE' ;

MasterT : 'master' | 'MASTER';
NextT : 'next' | 'NEXT' ;
PcT : 'PC' | 'pc' |':pc'|':PC';
ProgramT : 'program' | 'PROGRAM';
RegisterT : 'register' | 'REGISTER';
AffectVCPC : ':=' ;
ShortT : 'short' | 'SHORT' ;
SlaveT : 'slave' | 'SLAVE' ;
StartT : 'start' | 'START';
SemiT :';' ;
UntilT	: 'until' | 'UNTIL';
VcT : 'VC' | 'vc' |':vc'|':VC';

// machine instruction

WaitT 			: 'wait' | 'WAIT';
ret 			: 'ret' {code[adresse++]=code_return;};
halt 			: 'hlt' {code[adresse++]=code_halt;};


 


HEXA: '\u0024'[0-9A-Fa-f_]+ ;
BOOL : '%'[0-1_]+ ;
INT : ('-')?[0-9_]+  ;

LINE_COMMENT : '//' .*? '\r'? '\n' -> skip ;
Name : ('+'|'>'|'-'|'<'|'*'|'='|'&'|'!'|'|'|'/'|'?'|'$'|'%'|[0-1a-zA-Z0-9_])+ ;


WS : [ ','\t\r\n\r]+ -> skip ; // skip spaces, tabs, newlines


 





