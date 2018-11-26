// Define a grammar called Hasm
grammar H2V;

@header {

import java.util.*;	
import java.io.*;

}

																		// local routine for generator 
@parser::members {
String version = "H2V.6.1";

// fihier de sortie
PrintWriter vhdl ;



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


			
															// gestion des zone master et slave
// varaible globale
String lit_string, last_name, selecteur, ipreconfigurable;
String valueinit = new String("0");
Boolean loop, VCorPC, multiplexeur=false, register_declare, inout, short_long=true;
int ipword, VCPCadresse, nextsignal, nextinstance, nbCase, sizestack,nb_entry, nb_state,last_idType;
																// adresse de debut des zone locale
public int master_adr, slave_adr, nbline=0;
int in_slave = 0;  												// 1 local salve ;2 local master ;0 double implantation master et slave , depend de la position de la zone de code  partie declarative
																		//	declaration table of symbol
public static int IP=1, WORD=3, PC=4, VC=5 ,IPonly = 6, REG = 7, ENTRY = 8, STATE = 9;  					// type de declaration
public class SymbolElement {											// type d un enregistrement pour table des symboles
	public int idType;
	public int adresse;
	public int slave;
	public int adresse_reconfig;
	public String fathername;
	public int entry;
	public boolean register;
		public SymbolElement (int itype, int adr, int slav, int adr_reconfig) {
		idType = itype;
		adresse = adr;
		slave = slav;
		adresse_reconfig = adr_reconfig;
		fathername = "";
		register = false;
		entry = 0;
	}
}


// stack de generation vhdl

Stack<String> stackvhdl = new Stack<String>();
Stack<String> datastack = new Stack<String>();
Stack<String> savestack = new Stack<String>();
Stack<String> longstack = new Stack<String>();
Stack<String> stacksensivity = new Stack<String>();
Stack<String> outputstack = new Stack<String>();


// list de stack pour le case
ArrayList<Stack<String>> listOfStack = new ArrayList<Stack<String>>();

public class InstanceElement {
	public String name;
	public boolean userdefined;
	public int nbin;
	public int nbout;
	public String pin1,pin2,pin3;;
	public String pout1,pout2,pout3;
	public int ipcode;
	public int entry;
}
Stack<InstanceElement> stackinstance = new Stack<InstanceElement>();

// stack des register pour un IP short

public class InstanceRegister {
	public String name;
	public String valueinit;
}
Stack<InstanceRegister> stackreg = new Stack<InstanceRegister>();

Stack<InstanceRegister> savereg = new Stack<InstanceRegister>();

Stack<String> onlining = new Stack<String>();
Stack<String> long_onlining = new Stack<String>();
List<String> listcomponent = new ArrayList<String>();

Stack <SymbolElement> restoresymbolreg = new Stack<SymbolElement>();
Stack<String> restorenamereg = new Stack<String>();

Map<String, SymbolElement> symbol = new HashMap<String, SymbolElement>();
public void addsymbol( String name , SymbolElement code){
	SymbolElement mycode = new SymbolElement (code.idType, code.adresse, code.slave, code.adresse_reconfig );
	symbol.put(name, mycode);
}
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
predef.adresse =  binary_code( 2, 1, 0x36);  	addsymbol("=", predef);
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
public static int mylog2(int n) {										// utilitaire hexa
		if( n<=0) return -1;
		if (n<2) return 0;
		if (n<4) return 1;
		if (n<8) return 2;
		if (n<16) return 3;
		if (n<32) return 4;
		if (n<64) return 5;
		if (n<128) return 6;
		if (n<256) return 7;
		return 8;								 
		 
}

public static String hex(int n) {										// utilitaire hexa
		 return String.format("0x%4s", Integer.toHexString(n)).replace(' ', '0');
}
public static String hex8(int n) {										// utilitaire hexa
		 return String.format("$%s", Integer.toHexString(n)).replace(' ', '0');
}
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
public String vhdlise(String name){
	String vhdlname ="";
		vhdlname = name.replace("+", "_plus").replace(">", "_GE").replace("-", "_minus").replace("<", "_LT").replace("*", "_star").replace("=", "_egal").replace("&", "_and").
		replace("!", "_not").
		replace("|", "_or").
		replace("/", "_div").
		replace("?", "_query").
		replace("$", "_dollar").
		replace("%", "_percent");
		return vhdlname;
}
public  int binary_code(int X, int Y, int mycode) {					// generation des 16 bits a partir de X Y et IPcode

	// test de validité l'IP
		if (mycode < 2048 && mycode >=0 && X>=0 && X< 4 && Y>= 0 && Y <=4 ) {

				return  (mycode + 2048 *Y + 8192 * X + 32768);
			} else {
				error("binary code incorrect 0x0000 generated!!!!", nbline);
				return  0 ;

			}
	}



public static int adresse;



Stack<Integer> pile = new Stack<Integer>();						// pile pour gener les adresse de branchement en avant



}
																												/// grammar start here

ipName : Name {nbline = $Name.line;};

		
root  : 	{	initIppredef();try {
										vhdl =  new PrintWriter(new BufferedWriter (new FileWriter("Homade.vhd")))	;		
										}catch ( IOException e) {}
				System.out.println (version + " : begin ");
				 }  // premiere ligne du code
			
			(IpT iPDeclare | vcDeclare | wordDeclare | staticDeclare)*			// declaration de mot visible sur slave et master
			(	'slave' 		
				(IpT iPDeclare | pcDeclare | vcDeclare | wordDeclare | staticDeclare)*    	// declaration de mot  de slave
				StartT  
				(homadeCode)* 
				MasterT 		
				
				(IpT iPDeclare  |(vcDeclare) |(wordDeclare)|(staticDeclare))*					// mot visible sur le maitre pas de PCdeclare
				StartT 
			| 
				ProgramT 																						// pas de slave il faut cosntruire le code minimal
						
				(IpT iPDeclare | (vcDeclare) |(wordDeclare)|(staticDeclare))* 					// mots visible sur le maitre
				StartT 
			)  
			(homadeCode)* 
			EndprogramT 			{	vhdl.close(); System.out.println (version + " : end ");}
			;





iPDeclare :     ipName     {  boolean short_or_long = false;
							System.out.println ("compiling Ip :  "+$ipName.text);
							nextsignal = 0; 
							nextinstance = 0; 
							nb_entry=0;
							String state_start = "hasm hasm ";
							ipreconfigurable="(others=> \'Z\')";
							stackvhdl.clear();
							}
					(word16) {
						SymbolElement currentIP ; currentIP = new SymbolElement(0,0,0,0 );	
						currentIP.idType = IPonly ; currentIP.slave = in_slave; 
						currentIP.adresse = ipword ; currentIP.adresse_reconfig = -1;  // type IPonly si pas de spec adresse contient le code  de l IP
						vhdl.println (" -- ================= new IP ================");
							vhdl.println ("library IEEE;");
							vhdl.println ("use IEEE.STD_LOGIC_1164.ALL;");
							vhdl.println ("use ieee.std_logic_unsigned.all;");	
							vhdl.println ("entity IP"+vhdlise($ipName.text)+" is");
							vhdl.println ("generic ( mycode : STD_LOGIC_VECTOR (10 downto 0):= \""+ Integer.toString(ipword, 2).substring(5,16) +"\");");
							vhdl.println ("   port ( ");
							int ipcode = ipword;
							int x = (ipcode % 0x8000) / 0x2000;
							int y = (ipcode % 0x2000) / 0x0800; 
							vhdl.println ("   clk : in  STD_LOGIC;");
							vhdl.println ("   reset : in  STD_LOGIC:='0';");
							if ( x> 0 ) vhdl.println ("   Tin : in  STD_LOGIC_VECTOR (31 downto 0);");
							if ( x> 1 ) vhdl.println ("   Nin : in  STD_LOGIC_VECTOR (31 downto 0);");
							if ( x> 2 ) vhdl.println ("   N2in : in  STD_LOGIC_VECTOR (31 downto 0);");
							if ( y> 0 ) vhdl.println ("   Tout : out  STD_LOGIC_VECTOR (31 downto 0);");
							if ( y> 1 ) vhdl.println ("   Nout : out  STD_LOGIC_VECTOR (31 downto 0);");
							if ( y> 2 ) vhdl.println ("   N2out : out  STD_LOGIC_VECTOR (31 downto 0);");
							vhdl.println ("   Ipcode : in  STD_LOGIC_VECTOR (10 downto 0)");
						}
					( '(' {ipreconfigurable="(others=> \'0\')";; currentIP.adresse_reconfig = 0;}(HEXA
						{ /// reconfigration dynamique '()' suffit si pas de valeur dispo tout  ZZZ ou 000 si reconfigurable
						int length = $HEXA.text.length(); 
						currentIP.adresse_reconfig =Integer.parseInt($HEXA.text.substring(1,length) ,16) ;
						
						} 
					)? ')'
					)?
					{symbol.put($ipName.text, currentIP);}												   
					(( ( EntryT Name {
							nbline = $Name.line;
							currentIP = new SymbolElement(0,0,0,0 );	
							currentIP.idType = ENTRY ; currentIP.slave = in_slave; currentIP.adresse = ipword+nb_entry; ; currentIP.adresse_reconfig = -1;currentIP.register = false;
							currentIP.fathername = $ipName.text;currentIP.entry = nb_entry;
							nb_entry++;
							symbol.put($Name.text, currentIP);
							} 
						)* {if (nb_entry> 0) {warning (" "+(mylog2(nb_entry)  )+" bits are used for the IP codes associated to the "+nb_entry +" entries !!");}
							}
						{ register_declare = false;}
						( 	( RegisterT   Name{	String valueinit = new String("0");nbline = $Name.line;	}
								( AffectVCPC literal {	valueinit = lit_string;} )?
								{
									InstanceRegister instreg = new InstanceRegister();
									instreg.name=$Name.text;
									instreg.valueinit= valueinit;
									stackreg.push(instreg);
									register_declare = true;
									currentIP = new SymbolElement(0,0,0,0 );	// mise a jour  boolean register ds le symbol IP
									currentIP = symbol.get($ipName.text);
									currentIP.register = true;
									symbol.put($ipName.text, currentIP);
									currentIP = new SymbolElement(0,0,0,0 );	
									currentIP.idType = REG ; currentIP.slave = in_slave; currentIP.adresse = 0 ; currentIP.adresse_reconfig = -1;  // type IPonly si pas de spec adresse contient le code  de l IP
									symbol.put(">"+$Name.text, currentIP);
									symbol.put($Name.text+">", currentIP);
								}
							) |  (InputT { inout=true;}| OutputT{inout=false;}) Name  ( AffectVCPC literal 
									{	valueinit = lit_string;nbline = $Name.line;} 
								)? 
									{currentIP = new SymbolElement(0,0,0,0 );	
									currentIP.idType = REG ; currentIP.slave = in_slave; currentIP.adresse = -1 ; currentIP.adresse_reconfig = -1;  // type IPonly si pas de spec adresse contient le code  de l IP
									
									currentIP.fathername = String.format("x\"%8s", valueinit.substring(1,valueinit.length())).replace(' ', '0').concat("\"");
									
									if ( inout ) {
										vhdl.println ("   ;"+$Name.text+" : in  STD_LOGIC_VECTOR (31 downto 0) := "+String.format("x\"%8s", valueinit.substring(1,valueinit.length())).replace(' ', '0')+"\"");
										symbol.put($Name.text+">", currentIP);
									}else{ 
										vhdl.println ("   ;"+$Name.text+" : out  STD_LOGIC_VECTOR (31 downto 0)");
										vhdl.println ("   ;"+$Name.text+"_enable : out  STD_LOGIC");
										symbol.put(">"+$Name.text, currentIP);
										outputstack.push( $Name.text+" <= "+String.format("x\"%8s", valueinit.substring(1,valueinit.length())).replace(' ', '0')+"\" ;");
										outputstack.push( $Name.text+"_enable <= \'0\' ;");
									}
									}
						)* ( 
						
						((ShortT {	
							nbline = $ShortT.line;
							short_or_long = true;
							vhdl.println (");");
							vhdl.println ("end IP"+vhdlise($ipName.text)+";");
							vhdl.println ("architecture archi_IP"+vhdlise($ipName.text)+" of  IP"+vhdlise($ipName.text)+" is");

							savereg.clear();
							savereg.addAll(stackreg);
							stackreg.clear();
							stackreg.addAll(savereg);
							if ( x==3 ) stackvhdl.push(new String("N2in"));
							if ( x==2 || x==3) stackvhdl.push(new String("Nin"));
							if ( x!=0 ) stackvhdl.push(new String("Tin"));
						}
						(homadeCodeIP)? 
						)
						| 
						(LongT{
							nbline = $LongT.line;
							short_long = false;
							short_or_long = true;
							restoresymbolreg.clear();
							vhdl.println (" ; IPdone : out STD_LOGIC);");
							vhdl.println ("end IP"+vhdlise($ipName.text)+";");
							vhdl.println ("architecture archi_IP"+vhdlise($ipName.text)+" of  IP"+vhdlise($ipName.text)+" is");


							if ( x==3 ) stackvhdl.push(new String("N2in"));
							if ( x==2 || x==3) stackvhdl.push(new String("Nin"));
							if ( x!=0 ) stackvhdl.push(new String("Tin"));
								longstack.clear();
								longstack.addAll(stackvhdl);
								
								vhdl.println ("signal   IPdone_i : std_logic;");
								vhdl.println ("signal go : std_logic := '0';");
								onlining.push("go <= \'1\' when  mycode(10 downto "+ (mylog2(nb_entry-1)+1) +") =ipcode(10 downto "+ (mylog2(nb_entry-1)+1)+")  else \'0\';");
								vhdl.println ("type state_type is (");}
						  (Name { nbline = $Name.line;
								if (state_start=="hasm hasm ")
								{ state_start = $Name.text;
									long_onlining.push("end process;");
									long_onlining.push("    end case;");
									long_onlining.push("        next_state <= "+$Name.text+";");
									long_onlining.push("    when others =>");
									vhdl.println ("                  "+$Name.text);
								} else {vhdl.println ("                  , "+$Name.text);}
								
								currentIP = new SymbolElement(0,0,0,0 );	
								currentIP.idType = STATE ; currentIP.slave = in_slave; currentIP.adresse = nb_state++; ; currentIP.adresse_reconfig = -1;currentIP.register = false;
								currentIP.fathername = "";currentIP.entry = -1;
								symbol.put($Name.text, currentIP);
								
							} )+   {vhdl.println ("                  );");
									vhdl.println ("signal state, next_state : state_type := "+ state_start+" ;");
									}
									
						('{' Name {nbline = $Name.line;
									stackvhdl.clear();
									stackvhdl.addAll(longstack);
									while (!restoresymbolreg.empty()){
										symbol.put(restorenamereg.pop(),restoresymbolreg.pop());
									}
									}
						'}' (homadeCodeIP? (
							IpdoneT {long_onlining.push("        IPdone_i <= '1'; ");
									 long_onlining.push("        next_state<= "+state_start+"; ");
									 onlining.push ("IPdone <= \'1\' when IPdone_i=\'1\' else \'0\' ; ");
									 if (y!=0) onlining.push ("Tout <="+stackvhdl.pop()+" when IPdone_i=\'1\' else "+ipreconfigurable+"; ");
									if (y>=2) onlining.push ("Nout <="+stackvhdl.pop()+" when IPdone_i=\'1\' else "+ipreconfigurable+"; ");
									if (y==3) onlining.push ("N2out <="+stackvhdl.pop()+" when IPdone_i=\'1\' else "+ipreconfigurable+"; ");}
							| StateT { long_onlining.push("      next_state<= "+stackvhdl.pop()+"; ");} ) 
							homadeCodeIP?)?  {
								long_onlining.push("    when "+$Name.text+" => ");							
								}
							)*
							{
								long_onlining.push("    case (state) is");
								long_onlining.push("        IPdone_i<= \'0\';");
								long_onlining.push("        next_state <= state;");
								savereg.clear();
								savereg.addAll(stackreg);
								while (!savereg.empty()){
									InstanceRegister instreg = new InstanceRegister();
									instreg = savereg.pop();
									long_onlining.push ("        "+instreg.name+"_i <= "+instreg.name+" ; ");
								}
								while(!outputstack.empty()){
									long_onlining.push("        "+outputstack.pop());
								}
								outputstack.clear();
								long_onlining.push("begin");
								long_onlining.push("                                     )");
								while(!stacksensivity.empty()){
									long_onlining.push("                                   ,"+stacksensivity.pop());
								}
								stacksensivity.clear();

								long_onlining.push("NEXT_STATE_DECODE: process (state,go");
							}
						)))
					)
					{	
					savereg.clear();
					savereg.addAll(stackreg);
					while (!stackreg.empty()){
							InstanceRegister instreg = new InstanceRegister();
							instreg = stackreg.pop();
							vhdl.println ("signal "+instreg.name+"_i , "+instreg.name+" : std_logic_vector(31 downto 0) := "+
										String.format("x\"%8s", instreg.valueinit.substring(1,instreg.valueinit.length())).replace(' ', '0')+"\" ;");
							if(symbol.containsKey(">"+instreg.name)) {
								symbol.remove(">"+instreg.name);
								}
							if(symbol.containsKey(instreg.name+">")) {
								symbol.remove(instreg.name+">");
								}
					}
					vhdl.println ("begin");
						// process registre
						onlining.push("   end process;");
						onlining.push("      end if;");
						onlining.push("      	end if;");
						stackreg.clear();
						stackreg.addAll(savereg);
						while (!savereg.empty()){
							InstanceRegister instreg = new InstanceRegister();
							instreg = savereg.pop();
							onlining.push("			"+instreg.name+" <= "+instreg.name+"_i;");
						}

						if ( !short_long ) onlining.push("          	state <= next_state;");
						onlining.push("      	else");
						if (state_start!="hasm hasm ")
							onlining.push("      		state <= "+state_start+";");
							//  init des registres ici!!!
						while (!stackreg.empty()){
							InstanceRegister instreg = new InstanceRegister();
							instreg = stackreg.pop();
							onlining.push("			"+instreg.name+" <= "+String.format("x\"%8s", instreg.valueinit.substring(1,instreg.valueinit.length())).replace(' ', '0')+"\" ;");
						}
						onlining.push("      	if (reset = '1') then");
						onlining.push("      if (clk'event and clk = '1') then");
						onlining.push("   begin");
						onlining.push("   SYNC_PROC: process (clk)");
						while (!stackinstance.empty()){
							InstanceElement instance = new InstanceElement();
							instance = stackinstance.pop();
							vhdl.println ("inst_IP"+vhdlise(instance.name).concat("_").concat(hex(nextinstance++).substring(2,6))+" : IP" +vhdlise(instance.name)+" PORT MAP(");
							vhdl.println ("    clk => clk");
							if (instance.nbin>0)vhdl.println ("   ,Tin => "+instance.pin1);
							if (instance.nbin>1)vhdl.println ("   ,Nin => "+instance.pin2);
							if (instance.nbin>2)vhdl.println ("   ,N2in => "+instance.pin3);
							if (instance.nbout>0 )vhdl.println ("   ,Tout => "+instance.pout1);
							if (instance.nbout>1)vhdl.println ("   ,Nout => "+instance.pout2);
							if (instance.nbout>2)vhdl.println ("   ,N2out => "+instance.pout3);
							if (instance.userdefined)vhdl.println ("   ,ipcode => \""+ Integer.toString(symbol.get(instance.name).adresse+instance.entry , 2).substring(5,16) +"\"");
							vhdl.println (");");
						}
						
						while (!onlining.empty()){
							vhdl.println (onlining.pop());
						}
						while (!long_onlining.empty()){
							vhdl.println (long_onlining.pop());
						}
						 ipcode = symbol.get($ipName.text).adresse;
						 y = (ipcode % 0x2000) / 0x0800;
						 if (short_long) {
							vhdl.println (" --  OUPUT  ");
							if ( y> 0 ) vhdl.println ("Tout <= "+ stackvhdl.pop() +" when mycode(10 downto "+ (mylog2(nb_entry-1)+1) +") =ipcode(10 downto "+ (mylog2(nb_entry-1)+1)+") else "+ipreconfigurable+" ;");
							if ( y> 1 ) vhdl.println ("Nout <= "+ stackvhdl.pop() +" when mycode(10 downto "+ (mylog2(nb_entry-1)+1) +") =ipcode(10 downto "+ (mylog2(nb_entry-1)+1)+") else "+ipreconfigurable+" ;");
							if ( y> 2 ) vhdl.println ("N2out <= "+ stackvhdl.pop() +" when mycode(10 downto "+ (mylog2(nb_entry-1)+1) +") =ipcode(10 downto "+ (mylog2(nb_entry-1)+1)+") else "+ipreconfigurable+" ;");
						}
							
						vhdl.println ("end archi_IP"+vhdlise($ipName.text)+" ;");	
					
					}					
					
					)? SemiT {
						nbline = $SemiT.line;
						listcomponent.clear(); 
						if (! short_or_long)
							vhdl.println ("end IP"+vhdlise($ipName.text)+";");
						}
				;  // mettre a IP et adresse a jour





pcDeclare : PcT Name  vcpcvalue?;
				
vcDeclare : VcT Name  vcpcvalue?;
					
					
vcpcvalue : 		( AffectVCPC 
						( Name							
						| literal 
						| '{' iPextend iPextend ( iPextend)? '}'
						) 
					)
				;
				
iPextend : (Name 
			| literal 
			)							
		;
				
wordDeclare : ColonT ipName  
			(homadeCode)? 
			SemiT ;									// generation du return
staticDeclare : (
					vcpcName 
					
					vcpcvalue
				)
			
;			

literal :   (HEXA { lit_string= $HEXA.text;}
			| BOOL { lit_string= hex8((int)(long)Long.parseLong( $BOOL.text.substring(1,$BOOL.text.length()), 2));}
			| INT { lit_string= hex8($INT.int);}
			)    ;
					
word16 :  HEXA  {	int length = $HEXA.text.length(); 
						if (length != 5 ){
							warning("value out of range 16 bits fixed");
						} else{
							ipword = Integer.parseInt($HEXA.text.substring(1,length) ,16) ;
						}	
				};

homadeCode : ( 	
				BeginT 
					homadeCode? 
					( AgainT 
						
					| UntilT 
						
					)
				|
				ForT 			
					homadeCode? 
					NextT 
				|
				DoT 
					homadeCode? 
					(	LoopT  | LoopplusT )
						
				|
				IfT 
					homadeCode? 
					(
					( ElseT 
					homadeCode? 
					EndifT 
					)
					|
					EndifT 
					)
				|
				WaitT 
				| IndiceIT 
				| IndiceJT 
				| IndiceKT 
				|
				Name 	
				(('{' INT INT '}')|( vcpcvalue)| ( '^^' ))?
				|
				literal
			 ) 
				(homadeCode)*;
homadeCodeIP : ( 	
				Name 
					{String currentname = $Name.text, s1, s2, s3, s4 ;
						nbline = $Name.line;
						InstanceElement instance = new InstanceElement ();
						instance.userdefined = false;
					if(symbol.containsKey($Name.text)){
						if(symbol.get($Name.text).idType == IPonly){
							if (currentname.equals("dup") ) {
								s1 = stackvhdl.pop();
								s2 = s1;
								stackvhdl.push(s1);
								stackvhdl.push(s2);
							} 
							else 
							if (currentname.equals("triple") ) {
								s1 = stackvhdl.pop();
								s2 = s1;
								s3 = s1;
								stackvhdl.push(s1);
								stackvhdl.push(s2);
								stackvhdl.push(s3);
							} 
							else if (currentname.equals("quad") ) {
								s1 = stackvhdl.pop();
								s2 = s1;
								s3 = s1;
								s4 = s1;
								stackvhdl.push(s1);
								stackvhdl.push(s2);
								stackvhdl.push(s3);
								stackvhdl.push(s4);
							} 
							else if (currentname.equals("nop") ) {
							} 
							else if (currentname.equals("rot") ) {
								s1 = stackvhdl.pop();
								s2 = stackvhdl.pop();
								s3 = stackvhdl.pop();
								stackvhdl.push(s2);
								stackvhdl.push(s1);
								stackvhdl.push(s3);
							} 
							else if (currentname.equals("-rot") ) {
								s1 = stackvhdl.pop();
								s2 = stackvhdl.pop();
								s3 = stackvhdl.pop();
								stackvhdl.push(s1);
								stackvhdl.push(s3);
								stackvhdl.push(s2);
							} 
							else if (currentname.equals("swap") ) {
								s1 = stackvhdl.pop();
								s2 = stackvhdl.pop();
								stackvhdl.push(s1);
								stackvhdl.push(s2);
							} 
							else if (currentname.equals("tuck") ) {
								s1 = stackvhdl.pop();
								s2 = stackvhdl.pop();
								stackvhdl.push(s1);
								stackvhdl.push(s2);
								stackvhdl.push(s1);
							} 
							else if (currentname.equals("over") ) {
								s1 = stackvhdl.pop();
								s2 = stackvhdl.pop();
								stackvhdl.push(s2);
								stackvhdl.push(s1);
								stackvhdl.push(s2);
							} 
							else if (currentname.equals("nip") ) {
								s1 = stackvhdl.pop();
								s2 = stackvhdl.pop();
								stackvhdl.push(s1);
							} 
							else if (currentname.equals("drop") ) {
								stackvhdl.pop();
							} else if (currentname.equals("pop") ) {
								stackvhdl.pop();
							} 
							else if (currentname.equals("pop1") ) {
								stackvhdl.pop();
							} 
							else if (currentname.equals("pop2") ) {
								stackvhdl.pop();
								stackvhdl.pop();
							} 
							else if (currentname.equals("pop3") ) {
								stackvhdl.pop();
								stackvhdl.pop();
								stackvhdl.pop();
							} 
							else if (currentname.equals("nip3") ) {
								s1 = stackvhdl.pop();
								s2 = stackvhdl.pop();
								s3 = stackvhdl.pop();
								stackvhdl.push(s2);
								stackvhdl.push(s1);
							} 
							else if (currentname.equals("nip23") ) {
								s1 = stackvhdl.pop();
								s2 = stackvhdl.pop();
								s3 = stackvhdl.pop();
								stackvhdl.push(s1);
							} 
							else if (currentname.equals("dup2") ) {
								s1 = stackvhdl.pop();
								s2 = stackvhdl.pop();
								stackvhdl.push(s2);
								stackvhdl.push(s1);
								stackvhdl.push(s2);
								stackvhdl.push(s1);
							} 
							else if (currentname.equals("dup3") ) {
								s1 = stackvhdl.pop();
								s2 = stackvhdl.pop();
								s3 = stackvhdl.pop();
								stackvhdl.push(s3);
								stackvhdl.push(s2);
								stackvhdl.push(s1);
								stackvhdl.push(s3);
								stackvhdl.push(s2);
								stackvhdl.push(s1);
							} 
							else if (currentname.equals(">r") ) {
								s1 = stackvhdl.pop();
								datastack.push(s1);
							} 
							else if (currentname.equals(">rdup") ) {
								s1 = stackvhdl.pop();
								datastack.push(s1);
								stackvhdl.push(s1);
							} 
							else if (currentname.equals("r>") ) {
								s1 = datastack.pop();
								stackvhdl.push(s1);
							}
							else if (currentname.equals("mul16") || currentname.equals("*")) {
								if (!listcomponent.contains("mul16")){
									vhdl.println ("COMPONENT mul16");
									vhdl.println ("PORT(");
									vhdl.println ("    clk : IN std_logic;");
									vhdl.println ("    Tin : IN std_logic_vector(31 downto 0);");
									vhdl.println ("    Nin : IN std_logic_vector(31 downto 0);");
									vhdl.println ("    Tout : OUT std_logic_vector(31 downto 0));");
									vhdl.println ("END COMPONENT;");
									listcomponent.add("mul16");
								}
								instance.name="mul16";
								instance.nbin=2;
								instance.nbout=1;
								instance.pin1= stackvhdl.pop();
								instance.pin2 =stackvhdl.pop();	
								instance.pout1 = "Hasm".concat(hex(nextsignal++).substring(2,6));
								vhdl.println ("signal "+instance.pout1+" : std_logic_vector(31 downto 0);");
								stackvhdl.push(instance.pout1);
								stackinstance.push(instance);
							} 
							else if (currentname.equals("+") || currentname.equals("add")) {
								instance.pin1= stackvhdl.pop();
								instance.pin2 =stackvhdl.pop();
								instance.pout1 = "Hasm".concat(hex(nextsignal++).substring(2,6));
								vhdl.println ("signal "+instance.pout1+" : std_logic_vector(31 downto 0);");
								stackvhdl.push(instance.pout1);
								onlining.push(instance.pout1.concat(" <= ").concat(instance.pin2).concat(" + ").concat(instance.pin1).concat(" ;"));
							} 
							else if (currentname.equals("add16")) {
								instance.pin1= stackvhdl.pop();
								instance.pin2 =stackvhdl.pop();
								instance.pout1 = "Hasm".concat(hex(nextsignal++).substring(2,6));
								vhdl.println ("signal "+instance.pout1+" : std_logic_vector(31 downto 0);");
								stackvhdl.push(instance.pout1);
								onlining.push(instance.pout1.concat("(31 downto 16) <= x\"0000\";"));
								onlining.push(instance.pout1.concat("(15 downto 0) <= ").concat(instance.pin2).concat("(15 downto 0) + ").concat(instance.pin1).concat("(15 downto 0) ;"));
							} 
							else if (currentname.equals("inc")||currentname.equals("1+")||currentname.equals("++") ) {
								instance.pin1= stackvhdl.pop();
								instance.pout1 = "Hasm".concat(hex(nextsignal++).substring(2,6));
								vhdl.println ("signal "+instance.pout1+" : std_logic_vector(31 downto 0);");
								stackvhdl.push(instance.pout1);
								onlining.push(instance.pout1.concat(" <= ").concat(instance.pin1).concat(" + x\"00000001\" ;"));
							} 
							else if (currentname.equals("-") || currentname.equals("minus")) {
								instance.pin1= stackvhdl.pop();
								instance.pin2 =stackvhdl.pop();
								instance.pout1 = "Hasm".concat(hex(nextsignal++).substring(2,6));
								vhdl.println ("signal "+instance.pout1+" : std_logic_vector(31 downto 0);");
								stackvhdl.push(instance.pout1);
								onlining.push(instance.pout1.concat(" <= ").concat(instance.pin2).concat(" - ").concat(instance.pin1).concat(" ;"));
							} 
							else if (currentname.equals("=") ) {
								instance.pin1= stackvhdl.pop();
								instance.pin2 =stackvhdl.pop();
								instance.pout1 = "Hasm".concat(hex(nextsignal++).substring(2,6));
								vhdl.println ("signal "+instance.pout1+" : std_logic_vector(31 downto 0);");
								stackvhdl.push(instance.pout1);
								onlining.push(instance.pout1.concat(" <= (others=> \'1') when ").concat(instance.pin2).concat(" = ").concat(instance.pin1).concat(" else (others=> \'0');"));
							} 
							else if (currentname.equals("<") ) {
								instance.pin1= stackvhdl.pop();
								instance.pin2 =stackvhdl.pop();
								instance.pout1 = "Hasm".concat(hex(nextsignal++).substring(2,6));
								vhdl.println ("signal "+instance.pout1+" : std_logic_vector(31 downto 0);");
								stackvhdl.push(instance.pout1);
								onlining.push(instance.pout1.concat(" <= (others=> \'1') when ").concat(instance.pin2).concat(" < ").concat(instance.pin1).concat(" else (others=> \'0');"));
							} 
							else if (currentname.equals("<=") ) {
								instance.pin1= stackvhdl.pop();
								instance.pin2 =stackvhdl.pop();
								instance.pout1 = "Hasm".concat(hex(nextsignal++).substring(2,6));
								vhdl.println ("signal "+instance.pout1+" : std_logic_vector(31 downto 0);");
								stackvhdl.push(instance.pout1);
								onlining.push(instance.pout1.concat(" <= (others=> \'1') when ").concat(instance.pin2).concat(" <= ").concat(instance.pin1).concat(" else (others=> \'0');"));
							}
							else if (currentname.equals(">") ) {
								instance.pin1= stackvhdl.pop();
								instance.pin2 =stackvhdl.pop();
								instance.pout1 = "Hasm".concat(hex(nextsignal++).substring(2,6));
								vhdl.println ("signal "+instance.pout1+" : std_logic_vector(31 downto 0);");
								stackvhdl.push(instance.pout1);
								onlining.push(instance.pout1.concat(" <= (others=> \'1') when ").concat(instance.pin2).concat(" > ").concat(instance.pin1).concat(" else (others=> \'0');"));
							}
							else if (currentname.equals(">=") ) {
								instance.pin1= stackvhdl.pop();
								instance.pin2 =stackvhdl.pop();
								instance.pout1 = "Hasm".concat(hex(nextsignal++).substring(2,6));
								vhdl.println ("signal "+instance.pout1+" : std_logic_vector(31 downto 0);");
								stackvhdl.push(instance.pout1);
								onlining.push(instance.pout1.concat(" <= (others=> \'1') when ").concat(instance.pin2).concat(" >= ").concat(instance.pin1).concat(" else (others=> \'0');"));
							}
							else if (currentname.equals("<>") ) {
								instance.pin1= stackvhdl.pop();
								instance.pin2 =stackvhdl.pop();
								instance.pout1 = "Hasm".concat(hex(nextsignal++).substring(2,6));
								vhdl.println ("signal "+instance.pout1+" : std_logic_vector(31 downto 0);");
								stackvhdl.push(instance.pout1);
								onlining.push(instance.pout1.concat(" <= (others=> \'1') when ").concat(instance.pin2).concat(" /= ").concat(instance.pin1).concat(" else (others=> \'0');"));
							}
							else if (currentname.equals("0<") ) {
								instance.pin1= stackvhdl.pop();
								instance.pin2 =stackvhdl.pop();
								instance.pout1 = "Hasm".concat(hex(nextsignal++).substring(2,6));
								vhdl.println ("signal "+instance.pout1+" : std_logic_vector(31 downto 0);");
								stackvhdl.push(instance.pout1);
								onlining.push(instance.pout1.concat(" <= (others=> \'1') when ").concat(instance.pin2).concat(" < 0 else (others=> \'0');"));
							}
							else if (currentname.equals("0=") ) {
								instance.pin1= stackvhdl.pop();
								instance.pin2 =stackvhdl.pop();
								instance.pout1 = "Hasm".concat(hex(nextsignal++).substring(2,6));
								vhdl.println ("signal "+instance.pout1+" : std_logic_vector(31 downto 0);");
								stackvhdl.push(instance.pout1);
								onlining.push(instance.pout1.concat(" <= (others=> \'1') when ").concat(instance.pin2).concat(" = 0 else (others=> \'0');"));
							}
							else if (currentname.equals("minus16")) {
								instance.pin1= stackvhdl.pop();
								instance.pin2 =stackvhdl.pop();
								instance.pout1 = "Hasm".concat(hex(nextsignal++).substring(2,6));
								vhdl.println ("signal "+instance.pout1+" : std_logic_vector(31 downto 0);");
								stackvhdl.push(instance.pout1);
								onlining.push(instance.pout1.concat("(31 downto 16) <= x\"0000\";"));
								onlining.push(instance.pout1.concat("(15 downto 0) <= ").concat(instance.pin2).concat("(15 downto 0) - ").concat(instance.pin1).concat("(15 downto 0) ;"));
							}							
							else if (currentname.equals("dec")||currentname.equals("1-")||currentname.equals("--") ) {
								instance.pin1= stackvhdl.pop();
								instance.pout1 = "Hasm".concat(hex(nextsignal++).substring(2,6));
								vhdl.println ("signal "+instance.pout1+" : std_logic_vector(31 downto 0);");
								stackvhdl.push(instance.pout1);
								onlining.push(instance.pout1.concat(" <= ").concat(instance.pin1).concat(" - x\"00000001\" ;"));
							} 
							else if (currentname.equals("invert")||currentname.equals("!") ) {
								instance.pin1= stackvhdl.pop();
								instance.pout1 = "Hasm".concat(hex(nextsignal++).substring(2,6));
								vhdl.println ("signal "+instance.pout1+" : std_logic_vector(31 downto 0);");
								stackvhdl.push(instance.pout1);
								onlining.push(instance.pout1.concat(" <= ").concat(" NOT ").concat(instance.pin1).concat(" ;"));
							} 
							else if (currentname.equals("or") || currentname.equals("||")) {
								instance.pin1= stackvhdl.pop();
								instance.pin2 =stackvhdl.pop();
								instance.pout1 = "Hasm".concat(hex(nextsignal++).substring(2,6));
								vhdl.println ("signal "+instance.pout1+" : std_logic_vector(31 downto 0);");
								stackvhdl.push(instance.pout1);
								onlining.push(instance.pout1.concat(" <= ").concat(instance.pin2).concat(" OR ").concat(instance.pin1).concat(" ;"));
							} 
							else if (currentname.equals("and") || currentname.equals("&&")) {
								instance.pin1= stackvhdl.pop();
								instance.pin2 =stackvhdl.pop();
								instance.pout1 = "Hasm".concat(hex(nextsignal++).substring(2,6));
								vhdl.println ("signal "+instance.pout1+" : std_logic_vector(31 downto 0);");
								stackvhdl.push(instance.pout1);
								onlining.push(instance.pout1.concat(" <= ").concat(instance.pin2).concat(" AND ").concat(instance.pin1).concat(" ;"));
							} 
							else if (currentname.equals("xor") ) {
								instance.pin1= stackvhdl.pop();
								instance.pin2 =stackvhdl.pop();
								instance.pout1 = "Hasm".concat(hex(nextsignal++).substring(2,6));
								vhdl.println ("signal "+instance.pout1+" : std_logic_vector(31 downto 0);");
								stackvhdl.push(instance.pout1);
								onlining.push(instance.pout1.concat(" <= ").concat(instance.pin2).concat(" XOR ").concat(instance.pin1).concat(" ;"));
							} 
							else if (currentname.equals("or2") ) {
								instance.pin1= stackvhdl.pop();
								instance.pin2 =stackvhdl.pop();
								instance.pout1 = "Hasm".concat(hex(nextsignal++).substring(2,6));
								vhdl.println ("signal "+instance.pout1+" : std_logic_vector(31 downto 0);");
								stackvhdl.push(instance.pout1);
								onlining.push(instance.pout1.concat(" <= (others =>".concat(instance.pin2).concat("(0) OR ").concat(instance.pin1).concat("(0)) ;")));
							} 
							else if (currentname.equals("and2") ) {
								instance.pin1= stackvhdl.pop();
								instance.pin2 =stackvhdl.pop();
								instance.pout1 = "Hasm".concat(hex(nextsignal++).substring(2,6));
								vhdl.println ("signal "+instance.pout1+" : std_logic_vector(31 downto 0);");
								stackvhdl.push(instance.pout1);
								onlining.push(instance.pout1.concat(" <= (others =>".concat(instance.pin2).concat("(0) AND ").concat(instance.pin1).concat("(0)) ;")));
							} 
							else if (currentname.equals("xor2") ) {
								instance.pin1= stackvhdl.pop();
								instance.pin2 =stackvhdl.pop();
								instance.pout1 = "Hasm".concat(hex(nextsignal++).substring(2,6));
								vhdl.println ("signal "+instance.pout1+" : std_logic_vector(31 downto 0);");
								stackvhdl.push(instance.pout1);
								onlining.push(instance.pout1.concat(" <= (others =>".concat(instance.pin2).concat("(0) XOR ").concat(instance.pin1).concat("(0)) ;")));
							} 
							else if (currentname.equals("2*") ) {
								instance.pin1= stackvhdl.pop();
								instance.pout1 = "Hasm".concat(hex(nextsignal++).substring(2,6));
								vhdl.println ("signal "+instance.pout1+" : std_logic_vector(31 downto 0);");
								stackvhdl.push(instance.pout1);
								onlining.push(instance.pout1.concat(" <= ").concat(instance.pin1).concat("(30 downto 0) & '0' ;"));
							} 
							else if (currentname.equals("u2/") ) {
								instance.pin1= stackvhdl.pop();
								instance.pout1 = "Hasm".concat(hex(nextsignal++).substring(2,6));
								vhdl.println ("signal "+instance.pout1+" : std_logic_vector(31 downto 0);");
								stackvhdl.push(instance.pout1);
								onlining.push(instance.pout1.concat(" <= '0' & ").concat(instance.pin1).concat("(31 downto 1) ;"));
							} 
							else if (currentname.equals("2/") ) {
								instance.pin1= stackvhdl.pop();
								instance.pout1 = "Hasm".concat(hex(nextsignal++).substring(2,6));
								vhdl.println ("signal "+instance.pout1+" : std_logic_vector(31 downto 0);");
								stackvhdl.push(instance.pout1);
								onlining.push(instance.pout1.concat(" <= ").concat(instance.pin1).concat("(31) & ").concat(instance.pin1).concat("(31 downto 1) ;"));
							} 
							else if (currentname.equals("->") ) {
								instance.pin1= stackvhdl.pop();
								instance.pin2= stackvhdl.pop();
								instance.pout1 = "Hasm".concat(hex(nextsignal++).substring(2,6));
								vhdl.println ("signal "+instance.pout1+" : std_logic_vector(31 downto 0);");
								stackvhdl.push(instance.pout1);
								onlining.push(instance.pout1.concat(" <= SHR ( ").concat(instance.pin2).concat(",").concat(instance.pin1).concat(") ;"));
							} 
							else if (currentname.equals("<-") ) {
								instance.pin1= stackvhdl.pop();
								instance.pin2= stackvhdl.pop();
								instance.pout1 = "Hasm".concat(hex(nextsignal++).substring(2,6));
								vhdl.println ("signal "+instance.pout1+" : std_logic_vector(31 downto 0);");
								stackvhdl.push(instance.pout1);
								onlining.push(instance.pout1.concat(" <= SHL ( ").concat(instance.pin2).concat(",").concat(instance.pin1).concat(") ;"));
							} 
							else if (currentname.equals("true") ) {
								instance.pout1 = "Hasm".concat(hex(nextsignal++).substring(2,6));
								vhdl.println ("signal "+instance.pout1+" : std_logic_vector(31 downto 0) :=x\"FFFFFFFF\";");
								stackvhdl.push(instance.pout1);
							} 
							else if (currentname.equals("false") ) {
								instance.pout1 = "Hasm".concat(hex(nextsignal++).substring(2,6));
								vhdl.println ("signal "+instance.pout1+" : std_logic_vector(31 downto 0) :=x\"00000000\";");
								stackvhdl.push(instance.pout1);
							
								
						
							}else {
								int x = (symbol.get(currentname).adresse % 0x8000) / 0x2000;
								int y = (symbol.get(currentname).adresse % 0x2000) / 0x0800;
								if (!listcomponent.contains(currentname)){
									if (symbol.get(currentname).register ) warning(" usage of user defined IP  with local register is NOT good practices "); 
									vhdl.println (" -- sub component");
									vhdl.println ("COMPONENT IP"+ vhdlise(currentname));
									vhdl.println ("generic ( mycode : STD_LOGIC_VECTOR (10 downto 0):= \""+ Integer.toString(symbol.get(currentname).adresse , 2).substring(5,16) +"\");");
									vhdl.println ("PORT(");
									vhdl.println ("    clk : IN std_logic; ");
									if (x!=0)vhdl.println ("    Tin : IN std_logic_vector(31 downto 0);");
									if (x>=2)vhdl.println ("    Nin : IN std_logic_vector(31 downto 0);");
									if (x==3)vhdl.println ("    N2in : IN std_logic_vector(31 downto 0);");
									if (y!=0) vhdl.println ("    Tout : OUT std_logic_vector(31 downto 0);");
									if (y>=2) vhdl.println ("    Nout : OUT std_logic_vector(31 downto 0);");
									if (y==3) vhdl.println ("    N2out : OUT std_logic_vector(31 downto 0);");
									vhdl.println ("    ipcode : IN std_logic_vector(10 downto 0));");
									vhdl.println ("END COMPONENT;");
									listcomponent.add(currentname);
								}
								instance.name=currentname;
								instance.userdefined=true;
								instance.nbin=x;
								instance.nbout=y;
								if (x!=0) instance.pin1= stackvhdl.pop();
								if (x>=2)instance.pin2 =stackvhdl.pop();
								if (x==3)instance.pin3 =stackvhdl.pop();	
								if (y!=0) {
									instance.pout1 = "Hasm".concat(hex(nextsignal++).substring(2,6));
									stackvhdl.push(instance.pout1);
									vhdl.println ("signal "+instance.pout1+" : std_logic_vector(31 downto 0);");
								}
								if (y>=2) {
									instance.pout2 = "Hasm".concat(hex(nextsignal++).substring(2,6));
									stackvhdl.push(instance.pout2);
									vhdl.println ("signal "+instance.pout2+" : std_logic_vector(31 downto 0);");
								}
								if (y==3) {
									instance.pout3 = "Hasm".concat(hex(nextsignal++).substring(2,6));
									stackvhdl.push(instance.pout3);
									vhdl.println ("signal "+instance.pout3+" : std_logic_vector(31 downto 0);");
								}
								stackinstance.push(instance);
								
							} 
							
						}else if(symbol.get($Name.text).idType == ENTRY){
							int entry = symbol.get(currentname).entry;
							currentname = symbol.get(currentname).fathername;
							warning(" Usage of 2 ENTRYs of the same IP will produce 2 disctinct instanciations of this IP!!");                                                                 
							
							int x = (symbol.get(currentname).adresse % 0x8000) / 0x2000;
							int y = (symbol.get(currentname).adresse % 0x2000) / 0x0800;
							if (!listcomponent.contains(currentname)){
								vhdl.println (" -- sub component");
								vhdl.println ("COMPONENT "+ currentname);
								vhdl.println ("generic ( mycode : STD_LOGIC_VECTOR (10 downto 0):= \""+ Integer.toString(symbol.get(currentname).adresse , 2).substring(5,16) +"\");");
								vhdl.println ("PORT(");
								vhdl.println ("    clk : IN std_logic; ");
								vhdl.println ("    reset : IN std_logic := '0'; ");
								if (x!=0)vhdl.println ("    Tin : IN std_logic_vector(31 downto 0);");
								if (x>=2)vhdl.println ("    Nin : IN std_logic_vector(31 downto 0);");
								if (x==3)vhdl.println ("    N3in : IN std_logic_vector(31 downto 0);");
								if (y!=0) vhdl.println ("    Tout : OUT std_logic_vector(31 downto 0);");
								if (y>=2) vhdl.println ("    Nout : OUT std_logic_vector(31 downto 0);");
								if (y==3) vhdl.println ("    Tout : OUT std_logic_vector(31 downto 0);");
								vhdl.println ("    ipcode : IN std_logic_vector(10 downto 0));");
								vhdl.println ("END COMPONENT;");
								listcomponent.add(currentname);
							}
							instance.name=currentname;
							instance.userdefined=true;
							instance.nbin=x;
							instance.nbout=y;
							instance.entry= entry;
							if (x!=0) instance.pin1= stackvhdl.pop();
							if (x>=2)instance.pin2 =stackvhdl.pop();
							if (x==3)instance.pin3 =stackvhdl.pop();	
							if (y!=0) {
								instance.pout1 = "Hasm".concat(hex(nextsignal++).substring(2,6));
								stackvhdl.push(instance.pout1);
								vhdl.println ("signal "+instance.pout1+" : std_logic_vector(31 downto 0);");
							}
							if (y>=2) {
								instance.pout2 = "Hasm".concat(hex(nextsignal++).substring(2,6));
								stackvhdl.push(instance.pout2);
								vhdl.println ("signal "+instance.pout2+" : std_logic_vector(31 downto 0);");
							}
							if (y==3) {
								instance.pout3 = "Hasm".concat(hex(nextsignal++).substring(2,6));
								stackvhdl.push(instance.pout3);
								vhdl.println ("signal "+instance.pout3+" : std_logic_vector(31 downto 0);");
							}
							stackinstance.push(instance);
						
						
						
						}
						else if(symbol.get($Name.text).idType == REG){
							if ($Name.text.charAt(0)=='>'){
								if (!multiplexeur) {
									if (!short_long) {  // long
										if(symbol.get($Name.text).adresse == -1 ){ //output
											long_onlining.push ("		"+$Name.text.substring(1,$Name.text.length())+" <= "+stackvhdl.pop()+" ;");
											long_onlining.push ("		"+$Name.text.substring(1,$Name.text.length()).concat("_enable")+" <= \'1\' ;");
										}else{
										String ls =stackvhdl.pop();
											long_onlining.push ("		"+$Name.text.substring(1,$Name.text.length())+"_i <= "+ls+" ;");
											if (ls.charAt(1)!='\"')stacksensivity.push(ls);
										}
										restorenamereg.push($Name.text);				// empile le registre pour restauration  sur le state suivant
										restoresymbolreg.push(symbol.get($Name.text));
										symbol.remove($Name.text);
									} else {   // short
										if(symbol.get($Name.text).adresse == -1 ){ //output
											onlining.push ($Name.text.substring(1,$Name.text.length())+" <= "+stackvhdl.pop()+" when mycode(10 downto "
															+ (mylog2(nb_entry-1)+1) +") =ipcode(10 downto "+ (mylog2(nb_entry-1)+1)+")  else "+symbol.get($Name.text).fathername+" ;");
											onlining.push ($Name.text.substring(1,$Name.text.length()).concat("_enable")+" <= \'1\'  when mycode(10 downto "
															+ (mylog2(nb_entry-1)+1) +") =ipcode(10 downto "+ (mylog2(nb_entry-1)+1)+")  else \'0\' ;");
										}else{
											onlining.push ($Name.text.substring(1,$Name.text.length())+"_i <= "+stackvhdl.pop()+" when mycode(10 downto "
															+ (mylog2(nb_entry-1)+1) +") =ipcode(10 downto "+ (mylog2(nb_entry-1)+1)+")  else "+$Name.text.substring(1,$Name.text.length())+" ;");
										}							
										symbol.remove($Name.text);
									}
								} else {
									error(" store in register or Ouput not allowed here ", nbline); 
								}
							}else {
								if(symbol.get($Name.text).adresse == -1 ){ //Input 
									stackvhdl.push($Name.text.substring(0,$Name.text.length()-1));
								}else{ 
									stackvhdl.push($Name.text.substring(0,$Name.text.length()-1));
								}
							}
						}	
						else if(symbol.get($Name.text).idType == STATE){
							//stackvhdl.push(String.format("x\"%8s", symbol.get($Name.text).adresse).replace(' ', '0'));
							stackvhdl.push($Name.text);
						} 
						else 
							error (" "+ currentname +" is not IP nor register nor IO port !!!", nbline);
					} else
						error (" "+ currentname +" does not exist anymore !!!", nbline);
					}
				|
				literal 
				{			String signalname =String.format("x\"%8s", lit_string.substring(1,lit_string.length())).concat("\"").replace(' ', '0');
							stackvhdl.push(signalname);
				}
				| 
				 ThisT {String signalname = "Hasm".concat(hex(nextsignal++).substring(2,6));
					stackvhdl.push(" (ipcode - mycode) ");
					}
				|
				(
				OpencaseT {
				nbline = $OpencaseT.line;
				if (multiplexeur) {
						error (" |- -| not allowed here #", nbline);
					} else {
						multiplexeur = true ; 
						nbCase = 0;
						selecteur = stackvhdl.pop();
						savestack.clear();
						savestack.addAll(stackvhdl);
						}
					} 
				homadeCodeIP+ 
					{
					Stack<String> tempstack = new Stack<String>();
					// new stack ds la list
					tempstack.clear();
					nbCase++;
					sizestack = stackvhdl.size();
					tempstack.addAll(stackvhdl);
					listOfStack.add(tempstack);
					if ( stackvhdl.empty()) {
						last_idType = 0;
					}else{
						String local ="";
						local= stackvhdl.pop();stackvhdl.push(local);
						if (symbol.containsKey(local) ) {
							last_idType= symbol.get(stackvhdl.pop()).idType;
						} else { 
							last_idType = 0;
						}
					}
					stackvhdl.clear();
					stackvhdl.addAll(savestack);
					}
				(CaseT {nbline = $CaseT.line;}(homadeCodeIP
						{
						tempstack = new Stack<String>();
						// new stack ds la list
						tempstack.clear();
						nbCase ++;
						if(sizestack!= stackvhdl.size()) {
							error("size of branch  different for this case : "+sizestack+" expected but "+stackvhdl.size()+" processed", nbline);
						}
						tempstack.addAll(stackvhdl);
						listOfStack.add(tempstack);
						stackvhdl.clear();
						stackvhdl.addAll(savestack);
						}
					)+)* ClosecaseT {
						nbline = $ClosecaseT.line;
						tempstack = new Stack<String>();
						// new stack ds la list
						tempstack.clear();
						for (int i =0; i< sizestack  ; i++)
						{
							String dest ="Hasm".concat(hex(nextsignal++).substring(2,6));
							tempstack.push(dest);
							if (last_idType == STATE) {
								vhdl.println ("signal "+dest+" : state_type ;");
								stacksensivity.push(dest);
								last_idType = IPonly;
							}else{
								vhdl.println ("signal "+dest+" : std_logic_vector(31 downto 0) ;");
							}
							onlining.push("    "+listOfStack.get(nbCase-1).pop()+"; ");
							for (int j = nbCase-2 ; j>=0; j--){
								//  optimisation qd un seul case sur un this cad aucune entry
								if ((selecteur == " (ipcode - mycode) ") && (nbCase == 2 )) {
									onlining.push("    "+listOfStack.get(j).pop()+" when ((mycode(10 downto 1) = ipcode(10 downto 1)) and (mycode(0) = ipcode(0)))  else");
								}
								else
									onlining.push("    "+listOfStack.get(j).pop()+" when "+selecteur +" = "+(j)+" else");
							}
							onlining.push(dest.concat(" <= ") );
						}
						// replace la stack dans l ordre
						stackvhdl.clear();
						for(int k =0; k<sizestack; k++){
							stackvhdl.push(tempstack.pop());
						}
						multiplexeur = false ;
						for (int l =0; l<nbCase;l++){
							listOfStack.get(l).clear();
						}
						listOfStack.clear();
												}
				) 
			 ) 
			(homadeCodeIP)*;
				
vcpcName  : Name ;			
	





// lexer
AgainT  : 'again' | 'AGAIN' ;
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
ret 			: 'ret' ;
halt 			: 'hlt' ;

OpencaseT		: '-|' ;
CaseT			: '|' ;
ClosecaseT		: '|-' ;

 


HEXA: '\u0024'[0-9A-Fa-f_]+ ;
BOOL : '%'[0-1_]+ ;
INT : ('-')?[0-9_]+  ;

LINE_COMMENT : '//' .*? '\r'? '\n' -> skip ;
Name : ('+'|'>'|'-'|'<'|'*'|'='|'&'|'!'|'|'|'/'|'?'|'$'|'%'|[0-1a-zA-Z0-9_])+ ;

WS : [ ','\t\r\n\r]+ -> skip ; // skip spaces, tabs, newlines 


 





