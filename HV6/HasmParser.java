// Generated from Hasm.g4 by ANTLR 4.5


import java.util.*;	
import java.io.*;


import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.misc.*;
import org.antlr.v4.runtime.tree.*;
import java.util.List;
import java.util.Iterator;
import java.util.ArrayList;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast"})
public class HasmParser extends Parser {
	static { RuntimeMetaData.checkVersion("4.5", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		T__0=1, T__1=2, T__2=3, T__3=4, T__4=5, T__5=6, T__6=7, T__7=8, T__8=9, 
		T__9=10, T__10=11, AgainT=12, BeginT=13, ColonT=14, DoT=15, ElseT=16, 
		EndifT=17, EndprogramT=18, EntryT=19, IpdoneT=20, StateT=21, InputT=22, 
		OutputT=23, ForT=24, IfT=25, IndiceIT=26, IndiceJT=27, IndiceKT=28, ThisT=29, 
		IpT=30, LongT=31, LoopplusT=32, LoopT=33, ShareT=34, MasterT=35, NextT=36, 
		PcT=37, ProgramT=38, RegisterT=39, AffectVCPC=40, ShortT=41, SlaveT=42, 
		StartT=43, SemiT=44, UntilT=45, VcT=46, WaitT=47, HEXA=48, BOOL=49, INT=50, 
		LINE_COMMENT=51, Name=52, WS=53;
	public static final int
		RULE_ipName = 0, RULE_root = 1, RULE_iPDeclare = 2, RULE_pcDeclare = 3, 
		RULE_vcDeclare = 4, RULE_vcpcvalue = 5, RULE_iPextend = 6, RULE_wordDeclare = 7, 
		RULE_staticDeclare = 8, RULE_literal = 9, RULE_word16 = 10, RULE_homadeCode = 11, 
		RULE_homadeCodeIP = 12, RULE_vcpcName = 13, RULE_ret = 14, RULE_halt = 15;
	public static final String[] ruleNames = {
		"ipName", "root", "iPDeclare", "pcDeclare", "vcDeclare", "vcpcvalue", 
		"iPextend", "wordDeclare", "staticDeclare", "literal", "word16", "homadeCode", 
		"homadeCodeIP", "vcpcName", "ret", "halt"
	};

	private static final String[] _LITERAL_NAMES = {
		null, "'slave'", "'('", "')'", "'{'", "'}'", "'^^'", "'-|'", "'|'", "'|-'", 
		"'ret'", "'hlt'", null, null, "':'", null, null, null, null, null, null, 
		null, null, null, null, null, "'I()'", "'J()'", "'K()'", null, null, null, 
		null, null, null, null, null, null, null, null, "':='", null, null, null, 
		"';'"
	};
	private static final String[] _SYMBOLIC_NAMES = {
		null, null, null, null, null, null, null, null, null, null, null, null, 
		"AgainT", "BeginT", "ColonT", "DoT", "ElseT", "EndifT", "EndprogramT", 
		"EntryT", "IpdoneT", "StateT", "InputT", "OutputT", "ForT", "IfT", "IndiceIT", 
		"IndiceJT", "IndiceKT", "ThisT", "IpT", "LongT", "LoopplusT", "LoopT", 
		"ShareT", "MasterT", "NextT", "PcT", "ProgramT", "RegisterT", "AffectVCPC", 
		"ShortT", "SlaveT", "StartT", "SemiT", "UntilT", "VcT", "WaitT", "HEXA", 
		"BOOL", "INT", "LINE_COMMENT", "Name", "WS"
	};
	public static final Vocabulary VOCABULARY = new VocabularyImpl(_LITERAL_NAMES, _SYMBOLIC_NAMES);

	/**
	 * @deprecated Use {@link #VOCABULARY} instead.
	 */
	@Deprecated
	public static final String[] tokenNames;
	static {
		tokenNames = new String[_SYMBOLIC_NAMES.length];
		for (int i = 0; i < tokenNames.length; i++) {
			tokenNames[i] = VOCABULARY.getLiteralName(i);
			if (tokenNames[i] == null) {
				tokenNames[i] = VOCABULARY.getSymbolicName(i);
			}

			if (tokenNames[i] == null) {
				tokenNames[i] = "<INVALID>";
			}
		}
	}

	@Override
	@Deprecated
	public String[] getTokenNames() {
		return tokenNames;
	}

	@Override

	public Vocabulary getVocabulary() {
		return VOCABULARY;
	}

	@Override
	public String getGrammarFileName() { return "Hasm.g4"; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public String getSerializedATN() { return _serializedATN; }

	@Override
	public ATN getATN() { return _ATN; }


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




	public HasmParser(TokenStream input) {
		super(input);
		_interp = new ParserATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}
	public static class IpNameContext extends ParserRuleContext {
		public Token Name;
		public TerminalNode Name() { return getToken(HasmParser.Name, 0); }
		public IpNameContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_ipName; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof HasmListener ) ((HasmListener)listener).enterIpName(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof HasmListener ) ((HasmListener)listener).exitIpName(this);
		}
	}

	public final IpNameContext ipName() throws RecognitionException {
		IpNameContext _localctx = new IpNameContext(_ctx, getState());
		enterRule(_localctx, 0, RULE_ipName);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(32);
			((IpNameContext)_localctx).Name = match(Name);
			nbline = (((IpNameContext)_localctx).Name!=null?((IpNameContext)_localctx).Name.getLine():0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class RootContext extends ParserRuleContext {
		public Token StartT;
		public Token MasterT;
		public Token ProgramT;
		public Token EndprogramT;
		public TerminalNode EndprogramT() { return getToken(HasmParser.EndprogramT, 0); }
		public List<TerminalNode> StartT() { return getTokens(HasmParser.StartT); }
		public TerminalNode StartT(int i) {
			return getToken(HasmParser.StartT, i);
		}
		public TerminalNode MasterT() { return getToken(HasmParser.MasterT, 0); }
		public TerminalNode ProgramT() { return getToken(HasmParser.ProgramT, 0); }
		public List<TerminalNode> IpT() { return getTokens(HasmParser.IpT); }
		public TerminalNode IpT(int i) {
			return getToken(HasmParser.IpT, i);
		}
		public List<IPDeclareContext> iPDeclare() {
			return getRuleContexts(IPDeclareContext.class);
		}
		public IPDeclareContext iPDeclare(int i) {
			return getRuleContext(IPDeclareContext.class,i);
		}
		public List<VcDeclareContext> vcDeclare() {
			return getRuleContexts(VcDeclareContext.class);
		}
		public VcDeclareContext vcDeclare(int i) {
			return getRuleContext(VcDeclareContext.class,i);
		}
		public List<WordDeclareContext> wordDeclare() {
			return getRuleContexts(WordDeclareContext.class);
		}
		public WordDeclareContext wordDeclare(int i) {
			return getRuleContext(WordDeclareContext.class,i);
		}
		public List<StaticDeclareContext> staticDeclare() {
			return getRuleContexts(StaticDeclareContext.class);
		}
		public StaticDeclareContext staticDeclare(int i) {
			return getRuleContext(StaticDeclareContext.class,i);
		}
		public List<HomadeCodeContext> homadeCode() {
			return getRuleContexts(HomadeCodeContext.class);
		}
		public HomadeCodeContext homadeCode(int i) {
			return getRuleContext(HomadeCodeContext.class,i);
		}
		public List<PcDeclareContext> pcDeclare() {
			return getRuleContexts(PcDeclareContext.class);
		}
		public PcDeclareContext pcDeclare(int i) {
			return getRuleContext(PcDeclareContext.class,i);
		}
		public RootContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_root; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof HasmListener ) ((HasmListener)listener).enterRoot(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof HasmListener ) ((HasmListener)listener).exitRoot(this);
		}
	}

	public final RootContext root() throws RecognitionException {
		RootContext _localctx = new RootContext(_ctx, getState());
		enterRule(_localctx, 2, RULE_root);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
				System.out.println (version + " : begin "); code[0] = 0x0C00; code[1] = 0x0000; code[2] = 0x0004; code[3] = code_halt; 
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
							
			setState(43);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << ColonT) | (1L << IpT) | (1L << VcT) | (1L << Name))) != 0)) {
				{
				setState(41);
				switch (_input.LA(1)) {
				case IpT:
					{
					setState(36);
					match(IpT);
					setState(37);
					iPDeclare();
					}
					break;
				case VcT:
					{
					setState(38);
					vcDeclare();
					}
					break;
				case ColonT:
					{
					setState(39);
					wordDeclare();
					}
					break;
				case Name:
					{
					setState(40);
					staticDeclare();
					}
					break;
				default:
					throw new NoViableAltException(this);
				}
				}
				setState(45);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(95);
			switch (_input.LA(1)) {
			case T__0:
				{
				setState(46);
				match(T__0);
				System.out.println (version+" : slave  ");
												in_slave = 1;
												slave_adr = adresse;
												
				setState(56);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << ColonT) | (1L << IpT) | (1L << PcT) | (1L << VcT) | (1L << Name))) != 0)) {
					{
					setState(54);
					switch (_input.LA(1)) {
					case IpT:
						{
						setState(48);
						match(IpT);
						setState(49);
						iPDeclare();
						}
						break;
					case PcT:
						{
						setState(50);
						pcDeclare();
						}
						break;
					case VcT:
						{
						setState(51);
						vcDeclare();
						}
						break;
					case ColonT:
						{
						setState(52);
						wordDeclare();
						}
						break;
					case Name:
						{
						setState(53);
						staticDeclare();
						}
						break;
					default:
						throw new NoViableAltException(this);
					}
					}
					setState(58);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				setState(59);
				((RootContext)_localctx).StartT = match(StartT);
				 nbline = (((RootContext)_localctx).StartT!=null?((RootContext)_localctx).StartT.getLine():0);
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
										
				setState(64);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << BeginT) | (1L << DoT) | (1L << ForT) | (1L << IfT) | (1L << IndiceIT) | (1L << IndiceJT) | (1L << IndiceKT) | (1L << WaitT) | (1L << HEXA) | (1L << BOOL) | (1L << INT) | (1L << Name))) != 0)) {
					{
					{
					setState(61);
					homadeCode();
					}
					}
					setState(66);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				setState(67);
				((RootContext)_localctx).MasterT = match(MasterT);
				nbline = (((RootContext)_localctx).MasterT!=null?((RootContext)_localctx).MasterT.getLine():0);System.out.println (version+" : master  ");
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

												
												
				setState(76);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << ColonT) | (1L << IpT) | (1L << VcT) | (1L << Name))) != 0)) {
					{
					setState(74);
					switch (_input.LA(1)) {
					case IpT:
						{
						setState(69);
						match(IpT);
						setState(70);
						iPDeclare();
						}
						break;
					case VcT:
						{
						{
						setState(71);
						vcDeclare();
						}
						}
						break;
					case ColonT:
						{
						{
						setState(72);
						wordDeclare();
						}
						}
						break;
					case Name:
						{
						{
						setState(73);
						staticDeclare();
						}
						}
						break;
					default:
						throw new NoViableAltException(this);
					}
					}
					setState(78);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				setState(79);
				((RootContext)_localctx).StartT = match(StartT);
				 nbline = (((RootContext)_localctx).StartT!=null?((RootContext)_localctx).StartT.getLine():0);NBnull();																				// mise a jour de la premiere ligne du maitre
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
				break;
			case ProgramT:
				{
				setState(81);
				((RootContext)_localctx).ProgramT = match(ProgramT);
				nbline = (((RootContext)_localctx).ProgramT!=null?((RootContext)_localctx).ProgramT.getLine():0);System.out.println (version+" : program  ");
											in_slave = 2;
											code[0] = 0x1C00; adresse = 1; NBnull();
											code[4] = 0xFFFF; adresse = 5; NBnull();
											code[8] = 0x0C00; code[9] = 0x0000; code[10] = 0x0004; code[11] = 0x1c00;			// premiere ligne du maitre ds ce cas
											adresse = 40;
											master_adr = 8;
											code[24+master_adr]= code_halt;code[27+master_adr]= code_halt;
											code[28+master_adr]= code_halt;code[31+master_adr]= code_halt;
											NBnull();

										
				setState(90);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << ColonT) | (1L << IpT) | (1L << VcT) | (1L << Name))) != 0)) {
					{
					setState(88);
					switch (_input.LA(1)) {
					case IpT:
						{
						setState(83);
						match(IpT);
						setState(84);
						iPDeclare();
						}
						break;
					case VcT:
						{
						{
						setState(85);
						vcDeclare();
						}
						}
						break;
					case ColonT:
						{
						{
						setState(86);
						wordDeclare();
						}
						}
						break;
					case Name:
						{
						{
						setState(87);
						staticDeclare();
						}
						}
						break;
					default:
						throw new NoViableAltException(this);
					}
					}
					setState(92);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				setState(93);
				((RootContext)_localctx).StartT = match(StartT);
				 nbline = (((RootContext)_localctx).StartT!=null?((RootContext)_localctx).StartT.getLine():0);NBnull();
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
				break;
			default:
				throw new NoViableAltException(this);
			}
			setState(100);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << BeginT) | (1L << DoT) | (1L << ForT) | (1L << IfT) | (1L << IndiceIT) | (1L << IndiceJT) | (1L << IndiceKT) | (1L << WaitT) | (1L << HEXA) | (1L << BOOL) | (1L << INT) | (1L << Name))) != 0)) {
				{
				{
				setState(97);
				homadeCode();
				}
				}
				setState(102);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(103);
			((RootContext)_localctx).EndprogramT = match(EndprogramT);
			nbline = (((RootContext)_localctx).EndprogramT!=null?((RootContext)_localctx).EndprogramT.getLine():0);System.out.println (version +" : end "); 									// fin de code  ffffffffff
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
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class IPDeclareContext extends ParserRuleContext {
		public IpNameContext ipName;
		public Token HEXA;
		public Token Name;
		public Token ShortT;
		public Token LongT;
		public Token IpdoneT;
		public Token StateT;
		public Token SemiT;
		public IpNameContext ipName() {
			return getRuleContext(IpNameContext.class,0);
		}
		public TerminalNode SemiT() { return getToken(HasmParser.SemiT, 0); }
		public Word16Context word16() {
			return getRuleContext(Word16Context.class,0);
		}
		public List<TerminalNode> EntryT() { return getTokens(HasmParser.EntryT); }
		public TerminalNode EntryT(int i) {
			return getToken(HasmParser.EntryT, i);
		}
		public List<TerminalNode> Name() { return getTokens(HasmParser.Name); }
		public TerminalNode Name(int i) {
			return getToken(HasmParser.Name, i);
		}
		public List<TerminalNode> RegisterT() { return getTokens(HasmParser.RegisterT); }
		public TerminalNode RegisterT(int i) {
			return getToken(HasmParser.RegisterT, i);
		}
		public TerminalNode ShortT() { return getToken(HasmParser.ShortT, 0); }
		public TerminalNode LongT() { return getToken(HasmParser.LongT, 0); }
		public TerminalNode HEXA() { return getToken(HasmParser.HEXA, 0); }
		public List<TerminalNode> InputT() { return getTokens(HasmParser.InputT); }
		public TerminalNode InputT(int i) {
			return getToken(HasmParser.InputT, i);
		}
		public List<TerminalNode> OutputT() { return getTokens(HasmParser.OutputT); }
		public TerminalNode OutputT(int i) {
			return getToken(HasmParser.OutputT, i);
		}
		public List<TerminalNode> AffectVCPC() { return getTokens(HasmParser.AffectVCPC); }
		public TerminalNode AffectVCPC(int i) {
			return getToken(HasmParser.AffectVCPC, i);
		}
		public List<LiteralContext> literal() {
			return getRuleContexts(LiteralContext.class);
		}
		public LiteralContext literal(int i) {
			return getRuleContext(LiteralContext.class,i);
		}
		public List<HomadeCodeIPContext> homadeCodeIP() {
			return getRuleContexts(HomadeCodeIPContext.class);
		}
		public HomadeCodeIPContext homadeCodeIP(int i) {
			return getRuleContext(HomadeCodeIPContext.class,i);
		}
		public List<TerminalNode> IpdoneT() { return getTokens(HasmParser.IpdoneT); }
		public TerminalNode IpdoneT(int i) {
			return getToken(HasmParser.IpdoneT, i);
		}
		public List<TerminalNode> StateT() { return getTokens(HasmParser.StateT); }
		public TerminalNode StateT(int i) {
			return getToken(HasmParser.StateT, i);
		}
		public IPDeclareContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_iPDeclare; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof HasmListener ) ((HasmListener)listener).enterIPDeclare(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof HasmListener ) ((HasmListener)listener).exitIPDeclare(this);
		}
	}

	public final IPDeclareContext iPDeclare() throws RecognitionException {
		IPDeclareContext _localctx = new IPDeclareContext(_ctx, getState());
		enterRule(_localctx, 4, RULE_iPDeclare);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(106);
			((IPDeclareContext)_localctx).ipName = ipName();
			{
			setState(107);
			word16();
			}

									boolean short_or_long=false;
									SymbolElement currentIP ; currentIP = new SymbolElement(0,0,0,0 );	nb_entry=0;IPadr=adresse;nb_state = 0;
									currentIP.idType = IPonly ; currentIP.slave = in_slave; currentIP.adresse = ipword ; currentIP.adresse_reconfig = -1;  // type IPonly si pas de spec adresse contient le code  de l IP
									
			setState(116);
			_la = _input.LA(1);
			if (_la==T__1) {
				{
				setState(109);
				match(T__1);
				currentIP.adresse_reconfig =0;
				setState(113);
				_la = _input.LA(1);
				if (_la==HEXA) {
					{
					setState(111);
					((IPDeclareContext)_localctx).HEXA = match(HEXA);
					 /// reconfigration dynamique  ()  means 0
											int length = (((IPDeclareContext)_localctx).HEXA!=null?((IPDeclareContext)_localctx).HEXA.getText():null).length(); 
											currentIP.adresse_reconfig =Integer.parseInt((((IPDeclareContext)_localctx).HEXA!=null?((IPDeclareContext)_localctx).HEXA.getText():null).substring(1,length) ,16) ;
											
					}
				}

				setState(115);
				match(T__2);
				}
			}

			symbol.put((((IPDeclareContext)_localctx).ipName!=null?_input.getText(((IPDeclareContext)_localctx).ipName.start,((IPDeclareContext)_localctx).ipName.stop):null), currentIP);
			setState(124);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==EntryT) {
				{
				{
				setState(119);
				match(EntryT);
				setState(120);
				((IPDeclareContext)_localctx).Name = match(Name);

										nbline = (((IPDeclareContext)_localctx).Name!=null?((IPDeclareContext)_localctx).Name.getLine():0);
										currentIP = new SymbolElement(0,0,0,0 );	
										currentIP.idType = IPonly ; currentIP.slave = in_slave; currentIP.adresse = ipword+nb_entry; ; currentIP.adresse_reconfig = -1;
										currentIP.fathername = (((IPDeclareContext)_localctx).ipName!=null?_input.getText(((IPDeclareContext)_localctx).ipName.start,((IPDeclareContext)_localctx).ipName.stop):null);currentIP.entry = nb_entry;
										code[adresse++]= nb_entry+ 0x2000;
										code[adresse++]=symbol.get(">r").adresse;
										adresse++; 
										nb_entry++;
										symbol.put((((IPDeclareContext)_localctx).Name!=null?((IPDeclareContext)_localctx).Name.getText():null), currentIP);
										stackentry.push((((IPDeclareContext)_localctx).Name!=null?((IPDeclareContext)_localctx).Name.getText():null));
										
				}
				}
				setState(126);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			register_declare = false;
			setState(149);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << InputT) | (1L << OutputT) | (1L << RegisterT))) != 0)) {
				{
				setState(147);
				switch (_input.LA(1)) {
				case RegisterT:
					{
					{
					setState(128);
					match(RegisterT);
					setState(129);
					((IPDeclareContext)_localctx).Name = match(Name);
						String valueinit = new String("0");	nbline = (((IPDeclareContext)_localctx).Name!=null?((IPDeclareContext)_localctx).Name.getLine():0);
											
					setState(136);
					_la = _input.LA(1);
					if (_la==AffectVCPC) {
						{
						setState(131);
						match(AffectVCPC);
						 int tempadr = adresse;
						setState(133);
						literal();
						adresse=tempadr; valueinit = lit_string;
						}
					}


												register_declare = true;
												currentIP = new SymbolElement(0,0,0,0 );	
												currentIP.idType = REG ; currentIP.slave = in_slave; currentIP.adresse = next_reg ; currentIP.adresse_reconfig = -1;  // type REG adresse  emplacement memoire
												next_reg =next_reg+2 ;   /// deux emplacement pour un registre lecture ds le premier ecriture ds le second  , recopie en fin d IP
												symbol.put(">"+(((IPDeclareContext)_localctx).Name!=null?((IPDeclareContext)_localctx).Name.getText():null), currentIP);
												symbol.put((((IPDeclareContext)_localctx).Name!=null?((IPDeclareContext)_localctx).Name.getText():null)+">", currentIP);
												Reg regelement = new Reg();
												regelement.adresse =next_reg -2;
												regelement.initvalue = valueinit;
												regelement.slave= in_slave;
												stackreg.push(regelement);
											
					}
					}
					break;
				case InputT:
				case OutputT:
					{
					{
					setState(139);
					_la = _input.LA(1);
					if ( !(_la==InputT || _la==OutputT) ) {
					_errHandler.recoverInline(this);
					} else {
						consume();
					}
					setState(140);
					((IPDeclareContext)_localctx).Name = match(Name);
					nbline = (((IPDeclareContext)_localctx).Name!=null?((IPDeclareContext)_localctx).Name.getLine():0); 
					setState(144);
					_la = _input.LA(1);
					if (_la==AffectVCPC) {
						{
						setState(142);
						match(AffectVCPC);
						setState(143);
						literal();
						}
					}


												warning(" Input or output not supported for soft code generation", nbline);
					}
					}
					break;
				default:
					throw new NoViableAltException(this);
				}
				}
				setState(151);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(190);
			switch (_input.LA(1)) {
			case ShortT:
				{
				{
				setState(152);
				((IPDeclareContext)_localctx).ShortT = match(ShortT);
				nbline = (((IPDeclareContext)_localctx).ShortT!=null?((IPDeclareContext)_localctx).ShortT.getLine():0);
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

										
										String softname = (((IPDeclareContext)_localctx).ipName!=null?_input.getText(((IPDeclareContext)_localctx).ipName.start,((IPDeclareContext)_localctx).ipName.stop):null).concat("_soft");

										 currentIP = new SymbolElement(0,0,0,0 );
										 currentIP.adresse_reconfig = -1; 
										 currentIP.idType = WORD; 
										 currentIP.slave = in_slave;
										 currentIP.adresse = IPadr-master_adr;
										 if(nb_entry==0) {
											symbol.put(softname, currentIP);
										} else {
											symbol.remove((((IPDeclareContext)_localctx).ipName!=null?_input.getText(((IPDeclareContext)_localctx).ipName.start,((IPDeclareContext)_localctx).ipName.stop):null));
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
										 
				setState(156);
				_la = _input.LA(1);
				if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__6) | (1L << ThisT) | (1L << HEXA) | (1L << BOOL) | (1L << INT) | (1L << Name))) != 0)) {
					{
					setState(155);
					homadeCodeIP();
					}
				}

				}
				}
				break;
			case LongT:
				{
				{
				setState(158);
				((IPDeclareContext)_localctx).LongT = match(LongT);
				nbline = (((IPDeclareContext)_localctx).LongT!=null?((IPDeclareContext)_localctx).LongT.getLine():0);
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

										String softname = (((IPDeclareContext)_localctx).ipName!=null?_input.getText(((IPDeclareContext)_localctx).ipName.start,((IPDeclareContext)_localctx).ipName.stop):null).concat("_soft"); lastadr = 0;

										 currentIP = new SymbolElement(0,0,0,0 );
										 currentIP.adresse_reconfig = -1; 
										 currentIP.idType = WORD; 
										 currentIP.slave = in_slave;
										 currentIP.adresse = IPadr-master_adr;
										 if(nb_entry==0) {
											symbol.put(softname, currentIP);
										} else {
											symbol.remove((((IPDeclareContext)_localctx).ipName!=null?_input.getText(((IPDeclareContext)_localctx).ipName.start,((IPDeclareContext)_localctx).ipName.stop):null));
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
										 
				setState(163); 
				_errHandler.sync(this);
				_la = _input.LA(1);
				do {
					{
					{
					setState(161);
					((IPDeclareContext)_localctx).Name = match(Name);
					nbline = (((IPDeclareContext)_localctx).Name!=null?((IPDeclareContext)_localctx).Name.getLine():0);currentIP = new SymbolElement(0,0,0,0 );	nbline = (((IPDeclareContext)_localctx).Name!=null?((IPDeclareContext)_localctx).Name.getLine():0);
													currentIP.idType = STATE ; currentIP.slave = in_slave; currentIP.adresse = nb_state++; ; currentIP.adresse_reconfig = -1;
													currentIP.fathername = "";currentIP.entry = -1;
													symbol.put((((IPDeclareContext)_localctx).Name!=null?((IPDeclareContext)_localctx).Name.getText():null), currentIP);
													
					}
					}
					setState(165); 
					_errHandler.sync(this);
					_la = _input.LA(1);
				} while ( _la==Name );
				setState(187);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while (_la==T__3) {
					{
					{
					setState(167);
					match(T__3);
					setState(168);
					((IPDeclareContext)_localctx).Name = match(Name);
						nbline = (((IPDeclareContext)_localctx).Name!=null?((IPDeclareContext)_localctx).Name.getLine():0); while (!writereg.empty())  {
													String namereg = writereg.pop();
													code[adresse++]= symbol.get(namereg).adresse +0x2001;
													code[adresse++] = symbol.get("read").adresse;
													code[adresse++]= symbol.get(namereg).adresse +0x2000;
													code[adresse++] = symbol.get("write").adresse;				
												} 
												if (symbol.containsKey((((IPDeclareContext)_localctx).Name!=null?((IPDeclareContext)_localctx).Name.getText():null)) ) {  														// verficication de la déclaration du mot ds la table des symboles
													if (symbol.get((((IPDeclareContext)_localctx).Name!=null?((IPDeclareContext)_localctx).Name.getText():null)).slave == in_slave || symbol.get((((IPDeclareContext)_localctx).Name!=null?((IPDeclareContext)_localctx).Name.getText():null)).slave == 0){  	// verification de la portée
														if (symbol.get((((IPDeclareContext)_localctx).Name!=null?((IPDeclareContext)_localctx).Name.getText():null)).idType  == STATE ){
															code[adresse++] = lastadr; 
															lastadr = adresse -1;				/// emplacement pour bra
															currentIP = new SymbolElement(0,0,0,0 );
															currentIP = symbol.get((((IPDeclareContext)_localctx).Name!=null?((IPDeclareContext)_localctx).Name.getText():null));
															currentIP.entry = adresse;
															symbol.put((((IPDeclareContext)_localctx).Name!=null?((IPDeclareContext)_localctx).Name.getText():null), currentIP);										
														} else {
															error(" "+ (((IPDeclareContext)_localctx).Name!=null?((IPDeclareContext)_localctx).Name.getText():null) +"  is not a state name !!!", nbline);
														}
													}
												} else {
													error(" "+ (((IPDeclareContext)_localctx).Name!=null?((IPDeclareContext)_localctx).Name.getText():null) +" does not exist", nbline);  
												}	
											
					setState(170);
					match(T__4);
					setState(183);
					_la = _input.LA(1);
					if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__6) | (1L << IpdoneT) | (1L << StateT) | (1L << ThisT) | (1L << HEXA) | (1L << BOOL) | (1L << INT) | (1L << Name))) != 0)) {
						{
						setState(172);
						_la = _input.LA(1);
						if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__6) | (1L << ThisT) | (1L << HEXA) | (1L << BOOL) | (1L << INT) | (1L << Name))) != 0)) {
							{
							setState(171);
							homadeCodeIP();
							}
						}

						setState(178);
						switch (_input.LA(1)) {
						case IpdoneT:
							{
							setState(174);
							((IPDeclareContext)_localctx).IpdoneT = match(IpdoneT);
							nbline = (((IPDeclareContext)_localctx).IpdoneT!=null?((IPDeclareContext)_localctx).IpdoneT.getLine():0); 
															code[adresse++]=0x2FFF;
															code[adresse++]=0x2000;
															code[adresse++]=symbol.get("write").adresse;	
															
							}
							break;
						case StateT:
							{
							setState(176);
							((IPDeclareContext)_localctx).StateT = match(StateT);
							nbline = (((IPDeclareContext)_localctx).StateT!=null?((IPDeclareContext)_localctx).StateT.getLine():0); 
															code[adresse++]=0x2000;
															code[adresse++]=symbol.get("write").adresse;	
															
							}
							break;
						default:
							throw new NoViableAltException(this);
						}
						setState(181);
						_la = _input.LA(1);
						if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__6) | (1L << ThisT) | (1L << HEXA) | (1L << BOOL) | (1L << INT) | (1L << Name))) != 0)) {
							{
							setState(180);
							homadeCodeIP();
							}
						}

						}
					}

					}
					}
					setState(189);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				}
				}
				break;
			case SemiT:
				break;
			default:
				throw new NoViableAltException(this);
			}
			setState(192);
			((IPDeclareContext)_localctx).SemiT = match(SemiT);
			nbline = (((IPDeclareContext)_localctx).SemiT!=null?((IPDeclareContext)_localctx).SemiT.getLine():0);String namereg = "";
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
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class PcDeclareContext extends ParserRuleContext {
		public Token Name;
		public TerminalNode PcT() { return getToken(HasmParser.PcT, 0); }
		public TerminalNode Name() { return getToken(HasmParser.Name, 0); }
		public VcpcvalueContext vcpcvalue() {
			return getRuleContext(VcpcvalueContext.class,0);
		}
		public PcDeclareContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_pcDeclare; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof HasmListener ) ((HasmListener)listener).enterPcDeclare(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof HasmListener ) ((HasmListener)listener).exitPcDeclare(this);
		}
	}

	public final PcDeclareContext pcDeclare() throws RecognitionException {
		PcDeclareContext _localctx = new PcDeclareContext(_ctx, getState());
		enterRule(_localctx, 6, RULE_pcDeclare);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(195);
			match(PcT);
			setState(196);
			((PcDeclareContext)_localctx).Name = match(Name);
			 nbline = (((PcDeclareContext)_localctx).Name!=null?((PcDeclareContext)_localctx).Name.getLine():0);
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
									symbol.put((((PcDeclareContext)_localctx).Name!=null?((PcDeclareContext)_localctx).Name.getText():null), currentPC);
								
			setState(199);
			_la = _input.LA(1);
			if (_la==AffectVCPC) {
				{
				setState(198);
				vcpcvalue();
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class VcDeclareContext extends ParserRuleContext {
		public Token Name;
		public TerminalNode VcT() { return getToken(HasmParser.VcT, 0); }
		public TerminalNode Name() { return getToken(HasmParser.Name, 0); }
		public VcpcvalueContext vcpcvalue() {
			return getRuleContext(VcpcvalueContext.class,0);
		}
		public VcDeclareContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_vcDeclare; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof HasmListener ) ((HasmListener)listener).enterVcDeclare(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof HasmListener ) ((HasmListener)listener).exitVcDeclare(this);
		}
	}

	public final VcDeclareContext vcDeclare() throws RecognitionException {
		VcDeclareContext _localctx = new VcDeclareContext(_ctx, getState());
		enterRule(_localctx, 8, RULE_vcDeclare);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(201);
			match(VcT);
			setState(202);
			((VcDeclareContext)_localctx).Name = match(Name);
			 nbline = (((VcDeclareContext)_localctx).Name!=null?((VcDeclareContext)_localctx).Name.getLine():0);
									SymbolElement currentVC ; currentVC = new SymbolElement(0,0,0,0 );	
									VCorPC = true;
									NBnull();
									currentVC.idType = VC ; currentVC.slave = in_slave; currentVC.adresse = adresse - master_adr; currentVC.adresse_reconfig = 0;    // mise a jour de la table des symboles
									symbol.put((((VcDeclareContext)_localctx).Name!=null?((VcDeclareContext)_localctx).Name.getText():null), currentVC);
									VCPCadresse = adresse;
									code[adresse++]= code_return;
									code[adresse++]= 0x0000;
									code[adresse++]= 0x0000;
									code[adresse++]= code_return;
								
			setState(205);
			_la = _input.LA(1);
			if (_la==AffectVCPC) {
				{
				setState(204);
				vcpcvalue();
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class VcpcvalueContext extends ParserRuleContext {
		public Token Name;
		public TerminalNode AffectVCPC() { return getToken(HasmParser.AffectVCPC, 0); }
		public TerminalNode Name() { return getToken(HasmParser.Name, 0); }
		public LiteralContext literal() {
			return getRuleContext(LiteralContext.class,0);
		}
		public List<IPextendContext> iPextend() {
			return getRuleContexts(IPextendContext.class);
		}
		public IPextendContext iPextend(int i) {
			return getRuleContext(IPextendContext.class,i);
		}
		public VcpcvalueContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_vcpcvalue; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof HasmListener ) ((HasmListener)listener).enterVcpcvalue(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof HasmListener ) ((HasmListener)listener).exitVcpcvalue(this);
		}
	}

	public final VcpcvalueContext vcpcvalue() throws RecognitionException {
		VcpcvalueContext _localctx = new VcpcvalueContext(_ctx, getState());
		enterRule(_localctx, 10, RULE_vcpcvalue);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			{
			setState(207);
			match(AffectVCPC);
			int code_fin = VCorPC ? code_return : code_halt;
			setState(225);
			switch (_input.LA(1)) {
			case Name:
				{
				setState(209);
				((VcpcvalueContext)_localctx).Name = match(Name);
				  nbline = (((VcpcvalueContext)_localctx).Name!=null?((VcpcvalueContext)_localctx).Name.getLine():0);
												if (symbol.containsKey((((VcpcvalueContext)_localctx).Name!=null?((VcpcvalueContext)_localctx).Name.getText():null)) ) {  														// verficication de la déclaration du mot ds la table des symboles
													if (symbol.get((((VcpcvalueContext)_localctx).Name!=null?((VcpcvalueContext)_localctx).Name.getText():null)).slave == in_slave || symbol.get((((VcpcvalueContext)_localctx).Name!=null?((VcpcvalueContext)_localctx).Name.getText():null)).slave == 0){  	// verification de la portée
														if (symbol.get((((VcpcvalueContext)_localctx).Name!=null?((VcpcvalueContext)_localctx).Name.getText():null)).idType  == WORD ){
															code[VCPCadresse]= code_call;
															code[VCPCadresse+1]= (symbol.get((((VcpcvalueContext)_localctx).Name!=null?((VcpcvalueContext)_localctx).Name.getText():null))).adresse / 0x10000;
															code[VCPCadresse+2]= (symbol.get((((VcpcvalueContext)_localctx).Name!=null?((VcpcvalueContext)_localctx).Name.getText():null))).adresse % 0x10000;
														} else if (symbol.get((((VcpcvalueContext)_localctx).Name!=null?((VcpcvalueContext)_localctx).Name.getText():null)).idType  == IPonly ) {
															code[VCPCadresse]= (symbol.get((((VcpcvalueContext)_localctx).Name!=null?((VcpcvalueContext)_localctx).Name.getText():null))).adresse ;
															code[VCPCadresse+1]= code_fin;
														} else {
															error(" "+ (((VcpcvalueContext)_localctx).Name!=null?((VcpcvalueContext)_localctx).Name.getText():null) +"  not allowed in VC/PC value !!!", nbline);
														}
													} else {
														error(" "+ (((VcpcvalueContext)_localctx).Name!=null?((VcpcvalueContext)_localctx).Name.getText():null) +" does not exist here !!!", nbline);
													}
												} else {
													error(" "+ (((VcpcvalueContext)_localctx).Name!=null?((VcpcvalueContext)_localctx).Name.getText():null) +" does not exist", nbline);  
												}
											
				}
				break;
			case HEXA:
			case BOOL:
			case INT:
				{
				setState(211);
				literal();

											if (lit_string.length()>4 ){
												error(" constant too long 12 bits max!!", nbline);  
												} else {
													 code[VCPCadresse]= code [adresse -1] ;  // generé par literal deja
													code[VCPCadresse+1]= code_fin;
													adresse= adresse -1;
												}
											
				}
				break;
			case T__3:
				{
				setState(214);
				match(T__3);
				setState(215);
				iPextend();
				setState(216);
				iPextend();
										
											code[VCPCadresse]= code[adresse-2] ;
											code[VCPCadresse+1]= code[adresse-1];
											code[VCPCadresse+2]= code_fin;
											adresse = adresse -2;
											
				setState(221);
				_la = _input.LA(1);
				if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << HEXA) | (1L << BOOL) | (1L << INT) | (1L << Name))) != 0)) {
					{
					setState(218);
					iPextend();

													code[VCPCadresse+2]= code[adresse-1] ;
													code[VCPCadresse+3]= code_fin;
													adresse--;
													
					}
				}

				setState(223);
				match(T__4);
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class IPextendContext extends ParserRuleContext {
		public Token Name;
		public TerminalNode Name() { return getToken(HasmParser.Name, 0); }
		public LiteralContext literal() {
			return getRuleContext(LiteralContext.class,0);
		}
		public IPextendContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_iPextend; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof HasmListener ) ((HasmListener)listener).enterIPextend(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof HasmListener ) ((HasmListener)listener).exitIPextend(this);
		}
	}

	public final IPextendContext iPextend() throws RecognitionException {
		IPextendContext _localctx = new IPextendContext(_ctx, getState());
		enterRule(_localctx, 12, RULE_iPextend);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(232);
			switch (_input.LA(1)) {
			case Name:
				{
				setState(227);
				((IPextendContext)_localctx).Name = match(Name);
				 nbline = (((IPextendContext)_localctx).Name!=null?((IPextendContext)_localctx).Name.getLine():0);
										if (symbol.containsKey((((IPextendContext)_localctx).Name!=null?((IPextendContext)_localctx).Name.getText():null)) ) {  														// verficication de la déclaration du mot ds la table des symboles
											if (symbol.get((((IPextendContext)_localctx).Name!=null?((IPextendContext)_localctx).Name.getText():null)).slave == in_slave || symbol.get((((IPextendContext)_localctx).Name!=null?((IPextendContext)_localctx).Name.getText():null)).slave == 0){  	// verification de la portée
												if (symbol.get((((IPextendContext)_localctx).Name!=null?((IPextendContext)_localctx).Name.getText():null)).idType  == IPonly ){
														code[adresse++] = (symbol.get((((IPextendContext)_localctx).Name!=null?((IPextendContext)_localctx).Name.getText():null))).adresse ;							
												} else {
													error(" "+ (((IPextendContext)_localctx).Name!=null?((IPextendContext)_localctx).Name.getText():null) +"  not allowed in VC constructor !!!", nbline);
												}
											}
										} else {
											error(" "+ (((IPextendContext)_localctx).Name!=null?((IPextendContext)_localctx).Name.getText():null) +" does not exist", nbline);  
										}							
								
				}
				break;
			case HEXA:
			case BOOL:
			case INT:
				{
				setState(229);
				literal();

											if (lit_string.length()>4 ){
												error(" constant too long 12 bits max!!", nbline);  
												}
											
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class WordDeclareContext extends ParserRuleContext {
		public Token ColonT;
		public IpNameContext ipName;
		public TerminalNode ColonT() { return getToken(HasmParser.ColonT, 0); }
		public IpNameContext ipName() {
			return getRuleContext(IpNameContext.class,0);
		}
		public TerminalNode SemiT() { return getToken(HasmParser.SemiT, 0); }
		public HomadeCodeContext homadeCode() {
			return getRuleContext(HomadeCodeContext.class,0);
		}
		public WordDeclareContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_wordDeclare; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof HasmListener ) ((HasmListener)listener).enterWordDeclare(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof HasmListener ) ((HasmListener)listener).exitWordDeclare(this);
		}
	}

	public final WordDeclareContext wordDeclare() throws RecognitionException {
		WordDeclareContext _localctx = new WordDeclareContext(_ctx, getState());
		enterRule(_localctx, 14, RULE_wordDeclare);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(234);
			((WordDeclareContext)_localctx).ColonT = match(ColonT);
			setState(235);
			((WordDeclareContext)_localctx).ipName = ipName();
			 nbline = (((WordDeclareContext)_localctx).ColonT!=null?((WordDeclareContext)_localctx).ColonT.getLine():0);SymbolElement currentid ; currentid = new SymbolElement( 0,0,0,0);						// declare un mot a la forth
											NBnull();
											currentid.idType = WORD ; currentid.slave = in_slave; currentid.adresse = adresse - master_adr;   // mise a kour de la table des symboles
											symbol.put((((WordDeclareContext)_localctx).ipName!=null?_input.getText(((WordDeclareContext)_localctx).ipName.start,((WordDeclareContext)_localctx).ipName.stop):null), currentid);
										
			setState(238);
			_la = _input.LA(1);
			if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << BeginT) | (1L << DoT) | (1L << ForT) | (1L << IfT) | (1L << IndiceIT) | (1L << IndiceJT) | (1L << IndiceKT) | (1L << WaitT) | (1L << HEXA) | (1L << BOOL) | (1L << INT) | (1L << Name))) != 0)) {
				{
				setState(237);
				homadeCode();
				}
			}

			setState(240);
			match(SemiT);
			 code[adresse++] = code_return; 
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class StaticDeclareContext extends ParserRuleContext {
		public VcpcNameContext vcpcName;
		public VcpcNameContext vcpcName() {
			return getRuleContext(VcpcNameContext.class,0);
		}
		public VcpcvalueContext vcpcvalue() {
			return getRuleContext(VcpcvalueContext.class,0);
		}
		public StaticDeclareContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_staticDeclare; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof HasmListener ) ((HasmListener)listener).enterStaticDeclare(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof HasmListener ) ((HasmListener)listener).exitStaticDeclare(this);
		}
	}

	public final StaticDeclareContext staticDeclare() throws RecognitionException {
		StaticDeclareContext _localctx = new StaticDeclareContext(_ctx, getState());
		enterRule(_localctx, 16, RULE_staticDeclare);
		try {
			enterOuterAlt(_localctx, 1);
			{
			{
			setState(243);
			((StaticDeclareContext)_localctx).vcpcName = vcpcName();

									if (symbol.containsKey((((StaticDeclareContext)_localctx).vcpcName!=null?_input.getText(((StaticDeclareContext)_localctx).vcpcName.start,((StaticDeclareContext)_localctx).vcpcName.stop):null)) ) {  														// verficication de la déclaration du mot ds la table des symboles
										if (symbol.get((((StaticDeclareContext)_localctx).vcpcName!=null?_input.getText(((StaticDeclareContext)_localctx).vcpcName.start,((StaticDeclareContext)_localctx).vcpcName.stop):null)).slave == in_slave || symbol.get((((StaticDeclareContext)_localctx).vcpcName!=null?_input.getText(((StaticDeclareContext)_localctx).vcpcName.start,((StaticDeclareContext)_localctx).vcpcName.stop):null)).slave == 0){  	// verification de la portée
											if (symbol.get((((StaticDeclareContext)_localctx).vcpcName!=null?_input.getText(((StaticDeclareContext)_localctx).vcpcName.start,((StaticDeclareContext)_localctx).vcpcName.stop):null)).idType != VC && symbol.get((((StaticDeclareContext)_localctx).vcpcName!=null?_input.getText(((StaticDeclareContext)_localctx).vcpcName.start,((StaticDeclareContext)_localctx).vcpcName.stop):null)).idType != PC ){
												error(" "+ (((StaticDeclareContext)_localctx).vcpcName!=null?_input.getText(((StaticDeclareContext)_localctx).vcpcName.start,((StaticDeclareContext)_localctx).vcpcName.stop):null) +" is not PC or VC !!!", nbline);
											} else {
												VCPCadresse = (symbol.get((((StaticDeclareContext)_localctx).vcpcName!=null?_input.getText(((StaticDeclareContext)_localctx).vcpcName.start,((StaticDeclareContext)_localctx).vcpcName.stop):null))).adresse + master_adr;
												VCorPC = (symbol.get((((StaticDeclareContext)_localctx).vcpcName!=null?_input.getText(((StaticDeclareContext)_localctx).vcpcName.start,((StaticDeclareContext)_localctx).vcpcName.stop):null)).idType == VC) && (symbol.get((((StaticDeclareContext)_localctx).vcpcName!=null?_input.getText(((StaticDeclareContext)_localctx).vcpcName.start,((StaticDeclareContext)_localctx).vcpcName.stop):null)).adresse_reconfig != -1);
											}
											
										} else {
											error(" "+ (((StaticDeclareContext)_localctx).vcpcName!=null?_input.getText(((StaticDeclareContext)_localctx).vcpcName.start,((StaticDeclareContext)_localctx).vcpcName.stop):null) +" does not exist here !!!", nbline);
										}
									} else {
										error(" "+ (((StaticDeclareContext)_localctx).vcpcName!=null?_input.getText(((StaticDeclareContext)_localctx).vcpcName.start,((StaticDeclareContext)_localctx).vcpcName.stop):null) +" does not exist", nbline);  
									} 
								
			setState(245);
			vcpcvalue();
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class LiteralContext extends ParserRuleContext {
		public Token HEXA;
		public Token BOOL;
		public Token INT;
		public TerminalNode HEXA() { return getToken(HasmParser.HEXA, 0); }
		public TerminalNode BOOL() { return getToken(HasmParser.BOOL, 0); }
		public TerminalNode INT() { return getToken(HasmParser.INT, 0); }
		public LiteralContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_literal; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof HasmListener ) ((HasmListener)listener).enterLiteral(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof HasmListener ) ((HasmListener)listener).exitLiteral(this);
		}
	}

	public final LiteralContext literal() throws RecognitionException {
		LiteralContext _localctx = new LiteralContext(_ctx, getState());
		enterRule(_localctx, 18, RULE_literal);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(253);
			switch (_input.LA(1)) {
			case HEXA:
				{
				setState(247);
				((LiteralContext)_localctx).HEXA = match(HEXA);
				 lit_string= (((LiteralContext)_localctx).HEXA!=null?((LiteralContext)_localctx).HEXA.getText():null);
				}
				break;
			case BOOL:
				{
				setState(249);
				((LiteralContext)_localctx).BOOL = match(BOOL);
				 lit_string= hex8((int)(long)Long.parseLong( (((LiteralContext)_localctx).BOOL!=null?((LiteralContext)_localctx).BOOL.getText():null).substring(1,(((LiteralContext)_localctx).BOOL!=null?((LiteralContext)_localctx).BOOL.getText():null).length()), 2));
				}
				break;
			case INT:
				{
				setState(251);
				((LiteralContext)_localctx).INT = match(INT);
				 lit_string= hex8((((LiteralContext)_localctx).INT!=null?Integer.valueOf(((LiteralContext)_localctx).INT.getText()):0));
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
			 literal_generate (lit_string);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Word16Context extends ParserRuleContext {
		public Token HEXA;
		public TerminalNode HEXA() { return getToken(HasmParser.HEXA, 0); }
		public Word16Context(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_word16; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof HasmListener ) ((HasmListener)listener).enterWord16(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof HasmListener ) ((HasmListener)listener).exitWord16(this);
		}
	}

	public final Word16Context word16() throws RecognitionException {
		Word16Context _localctx = new Word16Context(_ctx, getState());
		enterRule(_localctx, 20, RULE_word16);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(257);
			((Word16Context)_localctx).HEXA = match(HEXA);
				int length = (((Word16Context)_localctx).HEXA!=null?((Word16Context)_localctx).HEXA.getText():null).length(); 
									if (length != 5 ){
										System.out.println("value out of range 16 bits fixed");
									} else{
										ipword = Integer.parseInt((((Word16Context)_localctx).HEXA!=null?((Word16Context)_localctx).HEXA.getText():null).substring(1,length) ,16) ;
									}	
							
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class HomadeCodeContext extends ParserRuleContext {
		public Token BeginT;
		public Token AgainT;
		public Token UntilT;
		public Token ForT;
		public Token NextT;
		public Token DoT;
		public Token LoopT;
		public Token LoopplusT;
		public Token IfT;
		public Token ElseT;
		public Token EndifT;
		public Token WaitT;
		public Token IndiceIT;
		public Token IndiceJT;
		public Token IndiceKT;
		public Token Name;
		public Token INT;
		public TerminalNode BeginT() { return getToken(HasmParser.BeginT, 0); }
		public TerminalNode ForT() { return getToken(HasmParser.ForT, 0); }
		public TerminalNode NextT() { return getToken(HasmParser.NextT, 0); }
		public TerminalNode DoT() { return getToken(HasmParser.DoT, 0); }
		public TerminalNode IfT() { return getToken(HasmParser.IfT, 0); }
		public TerminalNode WaitT() { return getToken(HasmParser.WaitT, 0); }
		public TerminalNode IndiceIT() { return getToken(HasmParser.IndiceIT, 0); }
		public TerminalNode IndiceJT() { return getToken(HasmParser.IndiceJT, 0); }
		public TerminalNode IndiceKT() { return getToken(HasmParser.IndiceKT, 0); }
		public TerminalNode Name() { return getToken(HasmParser.Name, 0); }
		public LiteralContext literal() {
			return getRuleContext(LiteralContext.class,0);
		}
		public List<HomadeCodeContext> homadeCode() {
			return getRuleContexts(HomadeCodeContext.class);
		}
		public HomadeCodeContext homadeCode(int i) {
			return getRuleContext(HomadeCodeContext.class,i);
		}
		public TerminalNode AgainT() { return getToken(HasmParser.AgainT, 0); }
		public TerminalNode UntilT() { return getToken(HasmParser.UntilT, 0); }
		public TerminalNode LoopT() { return getToken(HasmParser.LoopT, 0); }
		public TerminalNode LoopplusT() { return getToken(HasmParser.LoopplusT, 0); }
		public TerminalNode EndifT() { return getToken(HasmParser.EndifT, 0); }
		public TerminalNode ElseT() { return getToken(HasmParser.ElseT, 0); }
		public List<TerminalNode> INT() { return getTokens(HasmParser.INT); }
		public TerminalNode INT(int i) {
			return getToken(HasmParser.INT, i);
		}
		public VcpcvalueContext vcpcvalue() {
			return getRuleContext(VcpcvalueContext.class,0);
		}
		public HomadeCodeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_homadeCode; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof HasmListener ) ((HasmListener)listener).enterHomadeCode(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof HasmListener ) ((HasmListener)listener).exitHomadeCode(this);
		}
	}

	public final HomadeCodeContext homadeCode() throws RecognitionException {
		HomadeCodeContext _localctx = new HomadeCodeContext(_ctx, getState());
		enterRule(_localctx, 22, RULE_homadeCode);
		int _la;
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(332);
			switch (_input.LA(1)) {
			case BeginT:
				{
				setState(260);
				((HomadeCodeContext)_localctx).BeginT = match(BeginT);
				 nbline = (((HomadeCodeContext)_localctx).BeginT!=null?((HomadeCodeContext)_localctx).BeginT.getLine():0);NBnull(); pile.push (adresse); 
									
				setState(263);
				_la = _input.LA(1);
				if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << BeginT) | (1L << DoT) | (1L << ForT) | (1L << IfT) | (1L << IndiceIT) | (1L << IndiceJT) | (1L << IndiceKT) | (1L << WaitT) | (1L << HEXA) | (1L << BOOL) | (1L << INT) | (1L << Name))) != 0)) {
					{
					setState(262);
					homadeCode();
					}
				}

				setState(269);
				switch (_input.LA(1)) {
				case AgainT:
					{
					setState(265);
					((HomadeCodeContext)_localctx).AgainT = match(AgainT);
					nbline = (((HomadeCodeContext)_localctx).AgainT!=null?((HomadeCodeContext)_localctx).AgainT.getLine():0);int begin_adr , offset; 
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
					break;
				case UntilT:
					{
					setState(267);
					((HomadeCodeContext)_localctx).UntilT = match(UntilT);
					nbline = (((HomadeCodeContext)_localctx).UntilT!=null?((HomadeCodeContext)_localctx).UntilT.getLine():0);int begin_adr , offset; 
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
					break;
				default:
					throw new NoViableAltException(this);
				}
				}
				break;
			case ForT:
				{
				setState(271);
				((HomadeCodeContext)_localctx).ForT = match(ForT);
				 	nbline = (((HomadeCodeContext)_localctx).ForT!=null?((HomadeCodeContext)_localctx).ForT.getLine():0);
										code [adresse++] = 0x2000;																	// indice a 0
										code[adresse++]=symbol.get(">r").adresse;
										code[adresse++]=symbol.get(">r").adresse;							
										NBnull();
										pile.push(adresse);						
									
				setState(274);
				_la = _input.LA(1);
				if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << BeginT) | (1L << DoT) | (1L << ForT) | (1L << IfT) | (1L << IndiceIT) | (1L << IndiceJT) | (1L << IndiceKT) | (1L << WaitT) | (1L << HEXA) | (1L << BOOL) | (1L << INT) | (1L << Name))) != 0)) {
					{
					setState(273);
					homadeCode();
					}
				}

				setState(276);
				((HomadeCodeContext)_localctx).NextT = match(NextT);
				nbline = (((HomadeCodeContext)_localctx).NextT!=null?((HomadeCodeContext)_localctx).NextT.getLine():0);int for_adr, offset; 
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
				break;
			case DoT:
				{
				setState(278);
				((HomadeCodeContext)_localctx).DoT = match(DoT);
					nbline = (((HomadeCodeContext)_localctx).DoT!=null?((HomadeCodeContext)_localctx).DoT.getLine():0);
										code[adresse++]=symbol.get("swap").adresse;
										code[adresse++]=symbol.get(">r").adresse;
										code[adresse++]=symbol.get(">r").adresse;	
										NBnull();
										pile.push(adresse);	
				setState(281);
				_la = _input.LA(1);
				if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << BeginT) | (1L << DoT) | (1L << ForT) | (1L << IfT) | (1L << IndiceIT) | (1L << IndiceJT) | (1L << IndiceKT) | (1L << WaitT) | (1L << HEXA) | (1L << BOOL) | (1L << INT) | (1L << Name))) != 0)) {
					{
					setState(280);
					homadeCode();
					}
				}

				setState(287);
				switch (_input.LA(1)) {
				case LoopT:
					{
					setState(283);
					((HomadeCodeContext)_localctx).LoopT = match(LoopT);
					 nbline = (((HomadeCodeContext)_localctx).LoopT!=null?((HomadeCodeContext)_localctx).LoopT.getLine():0);loop = true;
					}
					break;
				case LoopplusT:
					{
					setState(285);
					((HomadeCodeContext)_localctx).LoopplusT = match(LoopplusT);
					nbline = (((HomadeCodeContext)_localctx).LoopplusT!=null?((HomadeCodeContext)_localctx).LoopplusT.getLine():0); loop = false;
					}
					break;
				default:
					throw new NoViableAltException(this);
				}
					int for_adr, offset; 
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
				break;
			case IfT:
				{
				setState(290);
				((HomadeCodeContext)_localctx).IfT = match(IfT);
				 nbline = (((HomadeCodeContext)_localctx).IfT!=null?((HomadeCodeContext)_localctx).IfT.getLine():0);
										code[adresse++]=symbol.get("pop1").adresse;
										pile.push(adresse);
										code[adresse++] = 0x0000 ;
									
				setState(293);
				_la = _input.LA(1);
				if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << BeginT) | (1L << DoT) | (1L << ForT) | (1L << IfT) | (1L << IndiceIT) | (1L << IndiceJT) | (1L << IndiceKT) | (1L << WaitT) | (1L << HEXA) | (1L << BOOL) | (1L << INT) | (1L << Name))) != 0)) {
					{
					setState(292);
					homadeCode();
					}
				}

				setState(304);
				switch (_input.LA(1)) {
				case ElseT:
					{
					{
					setState(295);
					((HomadeCodeContext)_localctx).ElseT = match(ElseT);
					 nbline = (((HomadeCodeContext)_localctx).ElseT!=null?((HomadeCodeContext)_localctx).ElseT.getLine():0);
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
										
					setState(298);
					_la = _input.LA(1);
					if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << BeginT) | (1L << DoT) | (1L << ForT) | (1L << IfT) | (1L << IndiceIT) | (1L << IndiceJT) | (1L << IndiceKT) | (1L << WaitT) | (1L << HEXA) | (1L << BOOL) | (1L << INT) | (1L << Name))) != 0)) {
						{
						setState(297);
						homadeCode();
						}
					}

					setState(300);
					((HomadeCodeContext)_localctx).EndifT = match(EndifT);
					nbline = (((HomadeCodeContext)_localctx).EndifT!=null?((HomadeCodeContext)_localctx).EndifT.getLine():0);
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
					}
					break;
				case EndifT:
					{
					setState(302);
					((HomadeCodeContext)_localctx).EndifT = match(EndifT);
					 nbline = (((HomadeCodeContext)_localctx).EndifT!=null?((HomadeCodeContext)_localctx).EndifT.getLine():0);
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
					break;
				default:
					throw new NoViableAltException(this);
				}
				}
				break;
			case WaitT:
				{
				setState(306);
				((HomadeCodeContext)_localctx).WaitT = match(WaitT);
					nbline = (((HomadeCodeContext)_localctx).WaitT!=null?((HomadeCodeContext)_localctx).WaitT.getLine():0);
										if (in_slave== 1){
											error(" WAIT statement not allowed in slave : skipped !!!" , nbline);
										} else {
											code[adresse++] = code_wait;
										}
									 
				}
				break;
			case IndiceIT:
				{
				setState(308);
				((HomadeCodeContext)_localctx).IndiceIT = match(IndiceIT);
				nbline = (((HomadeCodeContext)_localctx).IndiceIT!=null?((HomadeCodeContext)_localctx).IndiceIT.getLine():0);
									code[adresse++]=symbol.get("r>").adresse;
									code[adresse++]=symbol.get(">rdup").adresse;
								
				}
				break;
			case IndiceJT:
				{
				setState(310);
				((HomadeCodeContext)_localctx).IndiceJT = match(IndiceJT);
				nbline = (((HomadeCodeContext)_localctx).IndiceJT!=null?((HomadeCodeContext)_localctx).IndiceJT.getLine():0);
									code[adresse++]=symbol.get("r>").adresse;
									code[adresse++]=symbol.get("r>").adresse;
									code[adresse++]=symbol.get("r>").adresse;
									code[adresse++]=symbol.get(">rdup").adresse;
									code[adresse++]=symbol.get("-rot").adresse;
									code[adresse++]=symbol.get(">r").adresse;
									code[adresse++]=symbol.get(">r").adresse;
								
				}
				break;
			case IndiceKT:
				{
				setState(312);
				((HomadeCodeContext)_localctx).IndiceKT = match(IndiceKT);
				nbline = (((HomadeCodeContext)_localctx).IndiceKT!=null?((HomadeCodeContext)_localctx).IndiceKT.getLine():0);
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
				break;
			case Name:
				{
				setState(314);
				((HomadeCodeContext)_localctx).Name = match(Name);
				 nbline = (((HomadeCodeContext)_localctx).Name!=null?((HomadeCodeContext)_localctx).Name.getLine():0);
										if (symbol.containsKey((((HomadeCodeContext)_localctx).Name!=null?((HomadeCodeContext)_localctx).Name.getText():null)) ) {  														// verficication de la déclaration du mot ds la table des symboles
											if (symbol.get((((HomadeCodeContext)_localctx).Name!=null?((HomadeCodeContext)_localctx).Name.getText():null)).idType == PC ||(symbol.get((((HomadeCodeContext)_localctx).Name!=null?((HomadeCodeContext)_localctx).Name.getText():null)).slave == in_slave || symbol.get((((HomadeCodeContext)_localctx).Name!=null?((HomadeCodeContext)_localctx).Name.getText():null)).slave == 0)){  	// verification de la portée
												call_name(symbol.get((((HomadeCodeContext)_localctx).Name!=null?((HomadeCodeContext)_localctx).Name.getText():null)));	
												last_name = (((HomadeCodeContext)_localctx).Name!=null?((HomadeCodeContext)_localctx).Name.getText():null);
											} else {
												error(" "+ (((HomadeCodeContext)_localctx).Name!=null?((HomadeCodeContext)_localctx).Name.getText():null) +" does not exist here !!!", nbline);
											}
										} else {
											error(" "+ (((HomadeCodeContext)_localctx).Name!=null?((HomadeCodeContext)_localctx).Name.getText():null) +" does not exist", nbline);  
										}
								
									
				setState(329);
				switch (_input.LA(1)) {
				case T__3:
					{
					{
					 int x, y ; if (symbol.get(last_name).idType != IPonly) error (" " +last_name+" is not an IP ", nbline);
					setState(317);
					match(T__3);
					setState(318);
					((HomadeCodeContext)_localctx).INT = match(INT);
					x =(((HomadeCodeContext)_localctx).INT!=null?Integer.valueOf(((HomadeCodeContext)_localctx).INT.getText()):0); 
					setState(320);
					((HomadeCodeContext)_localctx).INT = match(INT);
					y =(((HomadeCodeContext)_localctx).INT!=null?Integer.valueOf(((HomadeCodeContext)_localctx).INT.getText()):0); 
										if (x<0 || x >3) error(" 0, 1, 2 or 3 expected fo X ", nbline);
										else if (y<0 || y >3) error(" 0, 1, 2 or 3 expected for Y ", nbline);
											else  code [adresse -1]= code[adresse-1] % 0x0800+ x * 0x2000 + y * 0x0800 + 0x8000;
										
					setState(322);
					match(T__4);
					}
					}
					break;
				case AffectVCPC:
					{
					{
					 // traitement preparatif pour un dynamic si <= arrive
										
										 														
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
										
										
					setState(324);
					vcpcvalue();
					 adresse --; // on ecrase le dernier return ou halt 
											
					}
					}
					break;
				case T__5:
					{
					{
					setState(327);
					match(T__5);
					   /// reconfiguration d'un IP
											if (symbol.get(last_name).idType == IPonly && symbol.get(last_name).adresse_reconfig != -1 ){
												lit_string= hex8(symbol.get(last_name).adresse_reconfig);
												adresse = adresse -1;
												literal_generate (lit_string);
												code[adresse++] = symbol.get("reconfigure").adresse ; // ajoute l IP reconfigure
											} else {
												error(" "+ last_name +" does not support dynamic reconfiguration!!!", nbline);
											}
										
					}
					}
					break;
				case AgainT:
				case BeginT:
				case DoT:
				case ElseT:
				case EndifT:
				case EndprogramT:
				case ForT:
				case IfT:
				case IndiceIT:
				case IndiceJT:
				case IndiceKT:
				case LoopplusT:
				case LoopT:
				case MasterT:
				case NextT:
				case SemiT:
				case UntilT:
				case WaitT:
				case HEXA:
				case BOOL:
				case INT:
				case Name:
					break;
				default:
					throw new NoViableAltException(this);
				}
				}
				break;
			case HEXA:
			case BOOL:
			case INT:
				{
				setState(331);
				literal();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
			setState(337);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,43,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					{
					{
					setState(334);
					homadeCode();
					}
					} 
				}
				setState(339);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,43,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class HomadeCodeIPContext extends ParserRuleContext {
		public Token Name;
		public Token ThisT;
		public TerminalNode Name() { return getToken(HasmParser.Name, 0); }
		public LiteralContext literal() {
			return getRuleContext(LiteralContext.class,0);
		}
		public TerminalNode ThisT() { return getToken(HasmParser.ThisT, 0); }
		public List<HomadeCodeIPContext> homadeCodeIP() {
			return getRuleContexts(HomadeCodeIPContext.class);
		}
		public HomadeCodeIPContext homadeCodeIP(int i) {
			return getRuleContext(HomadeCodeIPContext.class,i);
		}
		public HomadeCodeIPContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_homadeCodeIP; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof HasmListener ) ((HasmListener)listener).enterHomadeCodeIP(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof HasmListener ) ((HasmListener)listener).exitHomadeCodeIP(this);
		}
	}

	public final HomadeCodeIPContext homadeCodeIP() throws RecognitionException {
		HomadeCodeIPContext _localctx = new HomadeCodeIPContext(_ctx, getState());
		enterRule(_localctx, 24, RULE_homadeCodeIP);
		int _la;
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(367);
			switch (_input.LA(1)) {
			case Name:
				{
				setState(340);
				((HomadeCodeIPContext)_localctx).Name = match(Name);
				 nbline = (((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getLine():0);
										if (symbol.containsKey((((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null)) ) {  														// verficication de la déclaration du mot ds la table des symboles
											if (symbol.get((((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null)).idType == IPonly &&(symbol.get((((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null)).slave == in_slave || symbol.get((((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null)).slave == 0)){  	// verification de la portée
												call_name(symbol.get((((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null)));	
											} else if (symbol.get((((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null)).idType == IPonly){
												error(" "+ (((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null) +" does not exist here !!!", nbline);
											}
											else if (symbol.get((((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null)).idType==REG) {
												if ((((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null).charAt(0) == '>') {
													code[adresse++]= symbol.get((((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null)).adresse +0x2001;
													code[adresse++]= (symbol.get("write")).adresse;
													writereg.push((((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null));
												}else {
													code[adresse++]= symbol.get((((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null)).adresse +0x2000;
													code[adresse++]= (symbol.get("read")).adresse;
												}
											}else if (symbol.get((((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null)).idType==STATE) {
												code[adresse++]= (symbol.get((((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null))).adresse + 0x2000;
											} else {
												error(" "+ (((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null) +" is not an IP!!!", nbline);
											}
										} else {
											error(" "+ (((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null) +" does not exist", nbline);  
										}
								
									
				}
				break;
			case HEXA:
			case BOOL:
			case INT:
				{
				setState(342);
				literal();
				}
				break;
			case ThisT:
				{
				setState(343);
				((HomadeCodeIPContext)_localctx).ThisT = match(ThisT);
				nbline = (((HomadeCodeIPContext)_localctx).ThisT!=null?((HomadeCodeIPContext)_localctx).ThisT.getLine():0);code[adresse++]=symbol.get("r>").adresse;
										code[adresse++]=symbol.get(">rdup").adresse;
				}
				break;
			case T__6:
				{
				{
				setState(345);
				match(T__6);
				if (multiplexeur) {
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
									
				setState(348); 
				_errHandler.sync(this);
				_la = _input.LA(1);
				do {
					{
					{
					setState(347);
					homadeCodeIP();
					}
					}
					setState(350); 
					_errHandler.sync(this);
					_la = _input.LA(1);
				} while ( (((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__6) | (1L << ThisT) | (1L << HEXA) | (1L << BOOL) | (1L << INT) | (1L << Name))) != 0) );
				setState(361);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while (_la==T__7) {
					{
					{
					setState(352);
					match(T__7);

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
										
										
										
					setState(355); 
					_errHandler.sync(this);
					_la = _input.LA(1);
					do {
						{
						{
						setState(354);
						homadeCodeIP();
						}
						}
						setState(357); 
						_errHandler.sync(this);
						_la = _input.LA(1);
					} while ( (((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__6) | (1L << ThisT) | (1L << HEXA) | (1L << BOOL) | (1L << INT) | (1L << Name))) != 0) );
					}
					}
					setState(363);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				setState(364);
				match(T__8);
				int tempadr;
									code [caseadr]=symbol.get("nop").adresse;;
									multiplexeur = false;
									do {
										tempadr = code[braadr];
										code[braadr]=(adresse-braadr) % 1024;
										braadr = tempadr;
									}while ( braadr!= 0);
									code[adresse++] = symbol.get("r>pop").adresse;
									
				}
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
			setState(372);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,48,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					{
					{
					setState(369);
					homadeCodeIP();
					}
					} 
				}
				setState(374);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,48,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class VcpcNameContext extends ParserRuleContext {
		public Token Name;
		public TerminalNode Name() { return getToken(HasmParser.Name, 0); }
		public VcpcNameContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_vcpcName; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof HasmListener ) ((HasmListener)listener).enterVcpcName(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof HasmListener ) ((HasmListener)listener).exitVcpcName(this);
		}
	}

	public final VcpcNameContext vcpcName() throws RecognitionException {
		VcpcNameContext _localctx = new VcpcNameContext(_ctx, getState());
		enterRule(_localctx, 26, RULE_vcpcName);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(375);
			((VcpcNameContext)_localctx).Name = match(Name);
			nbline = (((VcpcNameContext)_localctx).Name!=null?((VcpcNameContext)_localctx).Name.getLine():0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class RetContext extends ParserRuleContext {
		public RetContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_ret; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof HasmListener ) ((HasmListener)listener).enterRet(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof HasmListener ) ((HasmListener)listener).exitRet(this);
		}
	}

	public final RetContext ret() throws RecognitionException {
		RetContext _localctx = new RetContext(_ctx, getState());
		enterRule(_localctx, 28, RULE_ret);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(378);
			match(T__9);
			code[adresse++]=code_return;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class HaltContext extends ParserRuleContext {
		public HaltContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_halt; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof HasmListener ) ((HasmListener)listener).enterHalt(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof HasmListener ) ((HasmListener)listener).exitHalt(this);
		}
	}

	public final HaltContext halt() throws RecognitionException {
		HaltContext _localctx = new HaltContext(_ctx, getState());
		enterRule(_localctx, 30, RULE_halt);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(381);
			match(T__10);
			code[adresse++]=code_halt;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static final String _serializedATN =
		"\3\u0430\ud6d1\u8206\uad2d\u4417\uaef1\u8d80\uaadd\3\67\u0183\4\2\t\2"+
		"\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4\13"+
		"\t\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\3\2\3\2"+
		"\3\2\3\3\3\3\3\3\3\3\3\3\3\3\7\3,\n\3\f\3\16\3/\13\3\3\3\3\3\3\3\3\3\3"+
		"\3\3\3\3\3\3\3\7\39\n\3\f\3\16\3<\13\3\3\3\3\3\3\3\7\3A\n\3\f\3\16\3D"+
		"\13\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\7\3M\n\3\f\3\16\3P\13\3\3\3\3\3\3\3"+
		"\3\3\3\3\3\3\3\3\3\3\3\3\7\3[\n\3\f\3\16\3^\13\3\3\3\3\3\5\3b\n\3\3\3"+
		"\7\3e\n\3\f\3\16\3h\13\3\3\3\3\3\3\3\3\4\3\4\3\4\3\4\3\4\3\4\3\4\5\4t"+
		"\n\4\3\4\5\4w\n\4\3\4\3\4\3\4\3\4\7\4}\n\4\f\4\16\4\u0080\13\4\3\4\3\4"+
		"\3\4\3\4\3\4\3\4\3\4\3\4\3\4\5\4\u008b\n\4\3\4\3\4\3\4\3\4\3\4\3\4\5\4"+
		"\u0093\n\4\3\4\7\4\u0096\n\4\f\4\16\4\u0099\13\4\3\4\3\4\3\4\3\4\5\4\u009f"+
		"\n\4\3\4\3\4\3\4\3\4\3\4\6\4\u00a6\n\4\r\4\16\4\u00a7\3\4\3\4\3\4\3\4"+
		"\3\4\5\4\u00af\n\4\3\4\3\4\3\4\3\4\5\4\u00b5\n\4\3\4\5\4\u00b8\n\4\5\4"+
		"\u00ba\n\4\7\4\u00bc\n\4\f\4\16\4\u00bf\13\4\5\4\u00c1\n\4\3\4\3\4\3\4"+
		"\3\5\3\5\3\5\3\5\5\5\u00ca\n\5\3\6\3\6\3\6\3\6\5\6\u00d0\n\6\3\7\3\7\3"+
		"\7\3\7\3\7\3\7\3\7\3\7\3\7\3\7\3\7\3\7\3\7\3\7\5\7\u00e0\n\7\3\7\3\7\5"+
		"\7\u00e4\n\7\3\b\3\b\3\b\3\b\3\b\5\b\u00eb\n\b\3\t\3\t\3\t\3\t\5\t\u00f1"+
		"\n\t\3\t\3\t\3\t\3\n\3\n\3\n\3\n\3\13\3\13\3\13\3\13\3\13\3\13\5\13\u0100"+
		"\n\13\3\13\3\13\3\f\3\f\3\f\3\r\3\r\3\r\5\r\u010a\n\r\3\r\3\r\3\r\3\r"+
		"\5\r\u0110\n\r\3\r\3\r\3\r\5\r\u0115\n\r\3\r\3\r\3\r\3\r\3\r\5\r\u011c"+
		"\n\r\3\r\3\r\3\r\3\r\5\r\u0122\n\r\3\r\3\r\3\r\3\r\5\r\u0128\n\r\3\r\3"+
		"\r\3\r\5\r\u012d\n\r\3\r\3\r\3\r\3\r\5\r\u0133\n\r\3\r\3\r\3\r\3\r\3\r"+
		"\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3"+
		"\r\5\r\u014c\n\r\3\r\5\r\u014f\n\r\3\r\7\r\u0152\n\r\f\r\16\r\u0155\13"+
		"\r\3\16\3\16\3\16\3\16\3\16\3\16\3\16\3\16\6\16\u015f\n\16\r\16\16\16"+
		"\u0160\3\16\3\16\3\16\6\16\u0166\n\16\r\16\16\16\u0167\7\16\u016a\n\16"+
		"\f\16\16\16\u016d\13\16\3\16\3\16\3\16\5\16\u0172\n\16\3\16\7\16\u0175"+
		"\n\16\f\16\16\16\u0178\13\16\3\17\3\17\3\17\3\20\3\20\3\20\3\21\3\21\3"+
		"\21\3\21\2\2\22\2\4\6\b\n\f\16\20\22\24\26\30\32\34\36 \2\3\3\2\30\31"+
		"\u01bb\2\"\3\2\2\2\4%\3\2\2\2\6l\3\2\2\2\b\u00c5\3\2\2\2\n\u00cb\3\2\2"+
		"\2\f\u00d1\3\2\2\2\16\u00ea\3\2\2\2\20\u00ec\3\2\2\2\22\u00f5\3\2\2\2"+
		"\24\u00ff\3\2\2\2\26\u0103\3\2\2\2\30\u014e\3\2\2\2\32\u0171\3\2\2\2\34"+
		"\u0179\3\2\2\2\36\u017c\3\2\2\2 \u017f\3\2\2\2\"#\7\66\2\2#$\b\2\1\2$"+
		"\3\3\2\2\2%-\b\3\1\2&\'\7 \2\2\',\5\6\4\2(,\5\n\6\2),\5\20\t\2*,\5\22"+
		"\n\2+&\3\2\2\2+(\3\2\2\2+)\3\2\2\2+*\3\2\2\2,/\3\2\2\2-+\3\2\2\2-.\3\2"+
		"\2\2.a\3\2\2\2/-\3\2\2\2\60\61\7\3\2\2\61:\b\3\1\2\62\63\7 \2\2\639\5"+
		"\6\4\2\649\5\b\5\2\659\5\n\6\2\669\5\20\t\2\679\5\22\n\28\62\3\2\2\28"+
		"\64\3\2\2\28\65\3\2\2\28\66\3\2\2\28\67\3\2\2\29<\3\2\2\2:8\3\2\2\2:;"+
		"\3\2\2\2;=\3\2\2\2<:\3\2\2\2=>\7-\2\2>B\b\3\1\2?A\5\30\r\2@?\3\2\2\2A"+
		"D\3\2\2\2B@\3\2\2\2BC\3\2\2\2CE\3\2\2\2DB\3\2\2\2EF\7%\2\2FN\b\3\1\2G"+
		"H\7 \2\2HM\5\6\4\2IM\5\n\6\2JM\5\20\t\2KM\5\22\n\2LG\3\2\2\2LI\3\2\2\2"+
		"LJ\3\2\2\2LK\3\2\2\2MP\3\2\2\2NL\3\2\2\2NO\3\2\2\2OQ\3\2\2\2PN\3\2\2\2"+
		"QR\7-\2\2Rb\b\3\1\2ST\7(\2\2T\\\b\3\1\2UV\7 \2\2V[\5\6\4\2W[\5\n\6\2X"+
		"[\5\20\t\2Y[\5\22\n\2ZU\3\2\2\2ZW\3\2\2\2ZX\3\2\2\2ZY\3\2\2\2[^\3\2\2"+
		"\2\\Z\3\2\2\2\\]\3\2\2\2]_\3\2\2\2^\\\3\2\2\2_`\7-\2\2`b\b\3\1\2a\60\3"+
		"\2\2\2aS\3\2\2\2bf\3\2\2\2ce\5\30\r\2dc\3\2\2\2eh\3\2\2\2fd\3\2\2\2fg"+
		"\3\2\2\2gi\3\2\2\2hf\3\2\2\2ij\7\24\2\2jk\b\3\1\2k\5\3\2\2\2lm\5\2\2\2"+
		"mn\5\26\f\2nv\b\4\1\2op\7\4\2\2ps\b\4\1\2qr\7\62\2\2rt\b\4\1\2sq\3\2\2"+
		"\2st\3\2\2\2tu\3\2\2\2uw\7\5\2\2vo\3\2\2\2vw\3\2\2\2wx\3\2\2\2x~\b\4\1"+
		"\2yz\7\25\2\2z{\7\66\2\2{}\b\4\1\2|y\3\2\2\2}\u0080\3\2\2\2~|\3\2\2\2"+
		"~\177\3\2\2\2\177\u0081\3\2\2\2\u0080~\3\2\2\2\u0081\u0097\b\4\1\2\u0082"+
		"\u0083\7)\2\2\u0083\u0084\7\66\2\2\u0084\u008a\b\4\1\2\u0085\u0086\7*"+
		"\2\2\u0086\u0087\b\4\1\2\u0087\u0088\5\24\13\2\u0088\u0089\b\4\1\2\u0089"+
		"\u008b\3\2\2\2\u008a\u0085\3\2\2\2\u008a\u008b\3\2\2\2\u008b\u008c\3\2"+
		"\2\2\u008c\u0096\b\4\1\2\u008d\u008e\t\2\2\2\u008e\u008f\7\66\2\2\u008f"+
		"\u0092\b\4\1\2\u0090\u0091\7*\2\2\u0091\u0093\5\24\13\2\u0092\u0090\3"+
		"\2\2\2\u0092\u0093\3\2\2\2\u0093\u0094\3\2\2\2\u0094\u0096\b\4\1\2\u0095"+
		"\u0082\3\2\2\2\u0095\u008d\3\2\2\2\u0096\u0099\3\2\2\2\u0097\u0095\3\2"+
		"\2\2\u0097\u0098\3\2\2\2\u0098\u00c0\3\2\2\2\u0099\u0097\3\2\2\2\u009a"+
		"\u009b\7+\2\2\u009b\u009c\b\4\1\2\u009c\u009e\b\4\1\2\u009d\u009f\5\32"+
		"\16\2\u009e\u009d\3\2\2\2\u009e\u009f\3\2\2\2\u009f\u00c1\3\2\2\2\u00a0"+
		"\u00a1\7!\2\2\u00a1\u00a2\b\4\1\2\u00a2\u00a5\b\4\1\2\u00a3\u00a4\7\66"+
		"\2\2\u00a4\u00a6\b\4\1\2\u00a5\u00a3\3\2\2\2\u00a6\u00a7\3\2\2\2\u00a7"+
		"\u00a5\3\2\2\2\u00a7\u00a8\3\2\2\2\u00a8\u00bd\3\2\2\2\u00a9\u00aa\7\6"+
		"\2\2\u00aa\u00ab\7\66\2\2\u00ab\u00ac\b\4\1\2\u00ac\u00b9\7\7\2\2\u00ad"+
		"\u00af\5\32\16\2\u00ae\u00ad\3\2\2\2\u00ae\u00af\3\2\2\2\u00af\u00b4\3"+
		"\2\2\2\u00b0\u00b1\7\26\2\2\u00b1\u00b5\b\4\1\2\u00b2\u00b3\7\27\2\2\u00b3"+
		"\u00b5\b\4\1\2\u00b4\u00b0\3\2\2\2\u00b4\u00b2\3\2\2\2\u00b5\u00b7\3\2"+
		"\2\2\u00b6\u00b8\5\32\16\2\u00b7\u00b6\3\2\2\2\u00b7\u00b8\3\2\2\2\u00b8"+
		"\u00ba\3\2\2\2\u00b9\u00ae\3\2\2\2\u00b9\u00ba\3\2\2\2\u00ba\u00bc\3\2"+
		"\2\2\u00bb\u00a9\3\2\2\2\u00bc\u00bf\3\2\2\2\u00bd\u00bb\3\2\2\2\u00bd"+
		"\u00be\3\2\2\2\u00be\u00c1\3\2\2\2\u00bf\u00bd\3\2\2\2\u00c0\u009a\3\2"+
		"\2\2\u00c0\u00a0\3\2\2\2\u00c0\u00c1\3\2\2\2\u00c1\u00c2\3\2\2\2\u00c2"+
		"\u00c3\7.\2\2\u00c3\u00c4\b\4\1\2\u00c4\7\3\2\2\2\u00c5\u00c6\7\'\2\2"+
		"\u00c6\u00c7\7\66\2\2\u00c7\u00c9\b\5\1\2\u00c8\u00ca\5\f\7\2\u00c9\u00c8"+
		"\3\2\2\2\u00c9\u00ca\3\2\2\2\u00ca\t\3\2\2\2\u00cb\u00cc\7\60\2\2\u00cc"+
		"\u00cd\7\66\2\2\u00cd\u00cf\b\6\1\2\u00ce\u00d0\5\f\7\2\u00cf\u00ce\3"+
		"\2\2\2\u00cf\u00d0\3\2\2\2\u00d0\13\3\2\2\2\u00d1\u00d2\7*\2\2\u00d2\u00e3"+
		"\b\7\1\2\u00d3\u00d4\7\66\2\2\u00d4\u00e4\b\7\1\2\u00d5\u00d6\5\24\13"+
		"\2\u00d6\u00d7\b\7\1\2\u00d7\u00e4\3\2\2\2\u00d8\u00d9\7\6\2\2\u00d9\u00da"+
		"\5\16\b\2\u00da\u00db\5\16\b\2\u00db\u00df\b\7\1\2\u00dc\u00dd\5\16\b"+
		"\2\u00dd\u00de\b\7\1\2\u00de\u00e0\3\2\2\2\u00df\u00dc\3\2\2\2\u00df\u00e0"+
		"\3\2\2\2\u00e0\u00e1\3\2\2\2\u00e1\u00e2\7\7\2\2\u00e2\u00e4\3\2\2\2\u00e3"+
		"\u00d3\3\2\2\2\u00e3\u00d5\3\2\2\2\u00e3\u00d8\3\2\2\2\u00e4\r\3\2\2\2"+
		"\u00e5\u00e6\7\66\2\2\u00e6\u00eb\b\b\1\2\u00e7\u00e8\5\24\13\2\u00e8"+
		"\u00e9\b\b\1\2\u00e9\u00eb\3\2\2\2\u00ea\u00e5\3\2\2\2\u00ea\u00e7\3\2"+
		"\2\2\u00eb\17\3\2\2\2\u00ec\u00ed\7\20\2\2\u00ed\u00ee\5\2\2\2\u00ee\u00f0"+
		"\b\t\1\2\u00ef\u00f1\5\30\r\2\u00f0\u00ef\3\2\2\2\u00f0\u00f1\3\2\2\2"+
		"\u00f1\u00f2\3\2\2\2\u00f2\u00f3\7.\2\2\u00f3\u00f4\b\t\1\2\u00f4\21\3"+
		"\2\2\2\u00f5\u00f6\5\34\17\2\u00f6\u00f7\b\n\1\2\u00f7\u00f8\5\f\7\2\u00f8"+
		"\23\3\2\2\2\u00f9\u00fa\7\62\2\2\u00fa\u0100\b\13\1\2\u00fb\u00fc\7\63"+
		"\2\2\u00fc\u0100\b\13\1\2\u00fd\u00fe\7\64\2\2\u00fe\u0100\b\13\1\2\u00ff"+
		"\u00f9\3\2\2\2\u00ff\u00fb\3\2\2\2\u00ff\u00fd\3\2\2\2\u0100\u0101\3\2"+
		"\2\2\u0101\u0102\b\13\1\2\u0102\25\3\2\2\2\u0103\u0104\7\62\2\2\u0104"+
		"\u0105\b\f\1\2\u0105\27\3\2\2\2\u0106\u0107\7\17\2\2\u0107\u0109\b\r\1"+
		"\2\u0108\u010a\5\30\r\2\u0109\u0108\3\2\2\2\u0109\u010a\3\2\2\2\u010a"+
		"\u010f\3\2\2\2\u010b\u010c\7\16\2\2\u010c\u0110\b\r\1\2\u010d\u010e\7"+
		"/\2\2\u010e\u0110\b\r\1\2\u010f\u010b\3\2\2\2\u010f\u010d\3\2\2\2\u0110"+
		"\u014f\3\2\2\2\u0111\u0112\7\32\2\2\u0112\u0114\b\r\1\2\u0113\u0115\5"+
		"\30\r\2\u0114\u0113\3\2\2\2\u0114\u0115\3\2\2\2\u0115\u0116\3\2\2\2\u0116"+
		"\u0117\7&\2\2\u0117\u014f\b\r\1\2\u0118\u0119\7\21\2\2\u0119\u011b\b\r"+
		"\1\2\u011a\u011c\5\30\r\2\u011b\u011a\3\2\2\2\u011b\u011c\3\2\2\2\u011c"+
		"\u0121\3\2\2\2\u011d\u011e\7#\2\2\u011e\u0122\b\r\1\2\u011f\u0120\7\""+
		"\2\2\u0120\u0122\b\r\1\2\u0121\u011d\3\2\2\2\u0121\u011f\3\2\2\2\u0122"+
		"\u0123\3\2\2\2\u0123\u014f\b\r\1\2\u0124\u0125\7\33\2\2\u0125\u0127\b"+
		"\r\1\2\u0126\u0128\5\30\r\2\u0127\u0126\3\2\2\2\u0127\u0128\3\2\2\2\u0128"+
		"\u0132\3\2\2\2\u0129\u012a\7\22\2\2\u012a\u012c\b\r\1\2\u012b\u012d\5"+
		"\30\r\2\u012c\u012b\3\2\2\2\u012c\u012d\3\2\2\2\u012d\u012e\3\2\2\2\u012e"+
		"\u012f\7\23\2\2\u012f\u0133\b\r\1\2\u0130\u0131\7\23\2\2\u0131\u0133\b"+
		"\r\1\2\u0132\u0129\3\2\2\2\u0132\u0130\3\2\2\2\u0133\u014f\3\2\2\2\u0134"+
		"\u0135\7\61\2\2\u0135\u014f\b\r\1\2\u0136\u0137\7\34\2\2\u0137\u014f\b"+
		"\r\1\2\u0138\u0139\7\35\2\2\u0139\u014f\b\r\1\2\u013a\u013b\7\36\2\2\u013b"+
		"\u014f\b\r\1\2\u013c\u013d\7\66\2\2\u013d\u014b\b\r\1\2\u013e\u013f\b"+
		"\r\1\2\u013f\u0140\7\6\2\2\u0140\u0141\7\64\2\2\u0141\u0142\b\r\1\2\u0142"+
		"\u0143\7\64\2\2\u0143\u0144\b\r\1\2\u0144\u014c\7\7\2\2\u0145\u0146\b"+
		"\r\1\2\u0146\u0147\5\f\7\2\u0147\u0148\b\r\1\2\u0148\u014c\3\2\2\2\u0149"+
		"\u014a\7\b\2\2\u014a\u014c\b\r\1\2\u014b\u013e\3\2\2\2\u014b\u0145\3\2"+
		"\2\2\u014b\u0149\3\2\2\2\u014b\u014c\3\2\2\2\u014c\u014f\3\2\2\2\u014d"+
		"\u014f\5\24\13\2\u014e\u0106\3\2\2\2\u014e\u0111\3\2\2\2\u014e\u0118\3"+
		"\2\2\2\u014e\u0124\3\2\2\2\u014e\u0134\3\2\2\2\u014e\u0136\3\2\2\2\u014e"+
		"\u0138\3\2\2\2\u014e\u013a\3\2\2\2\u014e\u013c\3\2\2\2\u014e\u014d\3\2"+
		"\2\2\u014f\u0153\3\2\2\2\u0150\u0152\5\30\r\2\u0151\u0150\3\2\2\2\u0152"+
		"\u0155\3\2\2\2\u0153\u0151\3\2\2\2\u0153\u0154\3\2\2\2\u0154\31\3\2\2"+
		"\2\u0155\u0153\3\2\2\2\u0156\u0157\7\66\2\2\u0157\u0172\b\16\1\2\u0158"+
		"\u0172\5\24\13\2\u0159\u015a\7\37\2\2\u015a\u0172\b\16\1\2\u015b\u015c"+
		"\7\t\2\2\u015c\u015e\b\16\1\2\u015d\u015f\5\32\16\2\u015e\u015d\3\2\2"+
		"\2\u015f\u0160\3\2\2\2\u0160\u015e\3\2\2\2\u0160\u0161\3\2\2\2\u0161\u016b"+
		"\3\2\2\2\u0162\u0163\7\n\2\2\u0163\u0165\b\16\1\2\u0164\u0166\5\32\16"+
		"\2\u0165\u0164\3\2\2\2\u0166\u0167\3\2\2\2\u0167\u0165\3\2\2\2\u0167\u0168"+
		"\3\2\2\2\u0168\u016a\3\2\2\2\u0169\u0162\3\2\2\2\u016a\u016d\3\2\2\2\u016b"+
		"\u0169\3\2\2\2\u016b\u016c\3\2\2\2\u016c\u016e\3\2\2\2\u016d\u016b\3\2"+
		"\2\2\u016e\u016f\7\13\2\2\u016f\u0170\b\16\1\2\u0170\u0172\3\2\2\2\u0171"+
		"\u0156\3\2\2\2\u0171\u0158\3\2\2\2\u0171\u0159\3\2\2\2\u0171\u015b\3\2"+
		"\2\2\u0172\u0176\3\2\2\2\u0173\u0175\5\32\16\2\u0174\u0173\3\2\2\2\u0175"+
		"\u0178\3\2\2\2\u0176\u0174\3\2\2\2\u0176\u0177\3\2\2\2\u0177\33\3\2\2"+
		"\2\u0178\u0176\3\2\2\2\u0179\u017a\7\66\2\2\u017a\u017b\b\17\1\2\u017b"+
		"\35\3\2\2\2\u017c\u017d\7\f\2\2\u017d\u017e\b\20\1\2\u017e\37\3\2\2\2"+
		"\u017f\u0180\7\r\2\2\u0180\u0181\b\21\1\2\u0181!\3\2\2\2\63+-8:BLNZ\\"+
		"afsv~\u008a\u0092\u0095\u0097\u009e\u00a7\u00ae\u00b4\u00b7\u00b9\u00bd"+
		"\u00c0\u00c9\u00cf\u00df\u00e3\u00ea\u00f0\u00ff\u0109\u010f\u0114\u011b"+
		"\u0121\u0127\u012c\u0132\u014b\u014e\u0153\u0160\u0167\u016b\u0171\u0176";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}