// Generated from H2V.g4 by ANTLR 4.5


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
public class H2VParser extends Parser {
	static { RuntimeMetaData.checkVersion("4.5", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		T__0=1, T__1=2, T__2=3, T__3=4, T__4=5, T__5=6, T__6=7, T__7=8, AgainT=9, 
		BeginT=10, ColonT=11, DoT=12, ElseT=13, EndifT=14, EndprogramT=15, EntryT=16, 
		IpdoneT=17, StateT=18, InputT=19, OutputT=20, ForT=21, IfT=22, IndiceIT=23, 
		IndiceJT=24, IndiceKT=25, ThisT=26, IpT=27, LongT=28, LoopplusT=29, LoopT=30, 
		MasterT=31, NextT=32, PcT=33, ProgramT=34, RegisterT=35, AffectVCPC=36, 
		ShortT=37, SlaveT=38, StartT=39, SemiT=40, UntilT=41, VcT=42, WaitT=43, 
		OpencaseT=44, CaseT=45, ClosecaseT=46, HEXA=47, BOOL=48, INT=49, LINE_COMMENT=50, 
		Name=51, WS=52;
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
		null, "'slave'", "'('", "')'", "'{'", "'}'", "'^^'", "'ret'", "'hlt'", 
		null, null, "':'", null, null, null, null, null, null, null, null, null, 
		null, null, "'I()'", "'J()'", "'K()'", null, null, null, null, null, null, 
		null, null, null, null, "':='", null, null, null, "';'", null, null, null, 
		"'-|'", "'|'", "'|-'"
	};
	private static final String[] _SYMBOLIC_NAMES = {
		null, null, null, null, null, null, null, null, null, "AgainT", "BeginT", 
		"ColonT", "DoT", "ElseT", "EndifT", "EndprogramT", "EntryT", "IpdoneT", 
		"StateT", "InputT", "OutputT", "ForT", "IfT", "IndiceIT", "IndiceJT", 
		"IndiceKT", "ThisT", "IpT", "LongT", "LoopplusT", "LoopT", "MasterT", 
		"NextT", "PcT", "ProgramT", "RegisterT", "AffectVCPC", "ShortT", "SlaveT", 
		"StartT", "SemiT", "UntilT", "VcT", "WaitT", "OpencaseT", "CaseT", "ClosecaseT", 
		"HEXA", "BOOL", "INT", "LINE_COMMENT", "Name", "WS"
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
	public String getGrammarFileName() { return "H2V.g4"; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public String getSerializedATN() { return _serializedATN; }

	@Override
	public ATN getATN() { return _ATN; }


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




	public H2VParser(TokenStream input) {
		super(input);
		_interp = new ParserATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}
	public static class IpNameContext extends ParserRuleContext {
		public Token Name;
		public TerminalNode Name() { return getToken(H2VParser.Name, 0); }
		public IpNameContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_ipName; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof H2VListener ) ((H2VListener)listener).enterIpName(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof H2VListener ) ((H2VListener)listener).exitIpName(this);
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
		public TerminalNode EndprogramT() { return getToken(H2VParser.EndprogramT, 0); }
		public List<TerminalNode> StartT() { return getTokens(H2VParser.StartT); }
		public TerminalNode StartT(int i) {
			return getToken(H2VParser.StartT, i);
		}
		public TerminalNode MasterT() { return getToken(H2VParser.MasterT, 0); }
		public TerminalNode ProgramT() { return getToken(H2VParser.ProgramT, 0); }
		public List<TerminalNode> IpT() { return getTokens(H2VParser.IpT); }
		public TerminalNode IpT(int i) {
			return getToken(H2VParser.IpT, i);
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
			if ( listener instanceof H2VListener ) ((H2VListener)listener).enterRoot(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof H2VListener ) ((H2VListener)listener).exitRoot(this);
		}
	}

	public final RootContext root() throws RecognitionException {
		RootContext _localctx = new RootContext(_ctx, getState());
		enterRule(_localctx, 2, RULE_root);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
				initIppredef();try {
													vhdl =  new PrintWriter(new BufferedWriter (new FileWriter("Homade.vhd")))	;		
													}catch ( IOException e) {}
							System.out.println (version + " : begin ");
							 
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
			setState(89);
			switch (_input.LA(1)) {
			case T__0:
				{
				setState(46);
				match(T__0);
				setState(55);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << ColonT) | (1L << IpT) | (1L << PcT) | (1L << VcT) | (1L << Name))) != 0)) {
					{
					setState(53);
					switch (_input.LA(1)) {
					case IpT:
						{
						setState(47);
						match(IpT);
						setState(48);
						iPDeclare();
						}
						break;
					case PcT:
						{
						setState(49);
						pcDeclare();
						}
						break;
					case VcT:
						{
						setState(50);
						vcDeclare();
						}
						break;
					case ColonT:
						{
						setState(51);
						wordDeclare();
						}
						break;
					case Name:
						{
						setState(52);
						staticDeclare();
						}
						break;
					default:
						throw new NoViableAltException(this);
					}
					}
					setState(57);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				setState(58);
				match(StartT);
				setState(62);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << BeginT) | (1L << DoT) | (1L << ForT) | (1L << IfT) | (1L << IndiceIT) | (1L << IndiceJT) | (1L << IndiceKT) | (1L << WaitT) | (1L << HEXA) | (1L << BOOL) | (1L << INT) | (1L << Name))) != 0)) {
					{
					{
					setState(59);
					homadeCode();
					}
					}
					setState(64);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				setState(65);
				match(MasterT);
				setState(73);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << ColonT) | (1L << IpT) | (1L << VcT) | (1L << Name))) != 0)) {
					{
					setState(71);
					switch (_input.LA(1)) {
					case IpT:
						{
						setState(66);
						match(IpT);
						setState(67);
						iPDeclare();
						}
						break;
					case VcT:
						{
						{
						setState(68);
						vcDeclare();
						}
						}
						break;
					case ColonT:
						{
						{
						setState(69);
						wordDeclare();
						}
						}
						break;
					case Name:
						{
						{
						setState(70);
						staticDeclare();
						}
						}
						break;
					default:
						throw new NoViableAltException(this);
					}
					}
					setState(75);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				setState(76);
				match(StartT);
				}
				break;
			case ProgramT:
				{
				setState(77);
				match(ProgramT);
				setState(85);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << ColonT) | (1L << IpT) | (1L << VcT) | (1L << Name))) != 0)) {
					{
					setState(83);
					switch (_input.LA(1)) {
					case IpT:
						{
						setState(78);
						match(IpT);
						setState(79);
						iPDeclare();
						}
						break;
					case VcT:
						{
						{
						setState(80);
						vcDeclare();
						}
						}
						break;
					case ColonT:
						{
						{
						setState(81);
						wordDeclare();
						}
						}
						break;
					case Name:
						{
						{
						setState(82);
						staticDeclare();
						}
						}
						break;
					default:
						throw new NoViableAltException(this);
					}
					}
					setState(87);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				setState(88);
				match(StartT);
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
			setState(94);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << BeginT) | (1L << DoT) | (1L << ForT) | (1L << IfT) | (1L << IndiceIT) | (1L << IndiceJT) | (1L << IndiceKT) | (1L << WaitT) | (1L << HEXA) | (1L << BOOL) | (1L << INT) | (1L << Name))) != 0)) {
				{
				{
				setState(91);
				homadeCode();
				}
				}
				setState(96);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(97);
			match(EndprogramT);
				vhdl.close(); System.out.println (version + " : end ");
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
		public Token SemiT;
		public IpNameContext ipName() {
			return getRuleContext(IpNameContext.class,0);
		}
		public TerminalNode SemiT() { return getToken(H2VParser.SemiT, 0); }
		public Word16Context word16() {
			return getRuleContext(Word16Context.class,0);
		}
		public TerminalNode HEXA() { return getToken(H2VParser.HEXA, 0); }
		public List<TerminalNode> EntryT() { return getTokens(H2VParser.EntryT); }
		public TerminalNode EntryT(int i) {
			return getToken(H2VParser.EntryT, i);
		}
		public List<TerminalNode> Name() { return getTokens(H2VParser.Name); }
		public TerminalNode Name(int i) {
			return getToken(H2VParser.Name, i);
		}
		public List<TerminalNode> RegisterT() { return getTokens(H2VParser.RegisterT); }
		public TerminalNode RegisterT(int i) {
			return getToken(H2VParser.RegisterT, i);
		}
		public List<TerminalNode> InputT() { return getTokens(H2VParser.InputT); }
		public TerminalNode InputT(int i) {
			return getToken(H2VParser.InputT, i);
		}
		public List<TerminalNode> OutputT() { return getTokens(H2VParser.OutputT); }
		public TerminalNode OutputT(int i) {
			return getToken(H2VParser.OutputT, i);
		}
		public List<TerminalNode> AffectVCPC() { return getTokens(H2VParser.AffectVCPC); }
		public TerminalNode AffectVCPC(int i) {
			return getToken(H2VParser.AffectVCPC, i);
		}
		public List<LiteralContext> literal() {
			return getRuleContexts(LiteralContext.class);
		}
		public LiteralContext literal(int i) {
			return getRuleContext(LiteralContext.class,i);
		}
		public TerminalNode ShortT() { return getToken(H2VParser.ShortT, 0); }
		public TerminalNode LongT() { return getToken(H2VParser.LongT, 0); }
		public List<HomadeCodeIPContext> homadeCodeIP() {
			return getRuleContexts(HomadeCodeIPContext.class);
		}
		public HomadeCodeIPContext homadeCodeIP(int i) {
			return getRuleContext(HomadeCodeIPContext.class,i);
		}
		public List<TerminalNode> IpdoneT() { return getTokens(H2VParser.IpdoneT); }
		public TerminalNode IpdoneT(int i) {
			return getToken(H2VParser.IpdoneT, i);
		}
		public List<TerminalNode> StateT() { return getTokens(H2VParser.StateT); }
		public TerminalNode StateT(int i) {
			return getToken(H2VParser.StateT, i);
		}
		public IPDeclareContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_iPDeclare; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof H2VListener ) ((H2VListener)listener).enterIPDeclare(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof H2VListener ) ((H2VListener)listener).exitIPDeclare(this);
		}
	}

	public final IPDeclareContext iPDeclare() throws RecognitionException {
		IPDeclareContext _localctx = new IPDeclareContext(_ctx, getState());
		enterRule(_localctx, 4, RULE_iPDeclare);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(100);
			((IPDeclareContext)_localctx).ipName = ipName();
			  boolean short_or_long = false;
										System.out.println ("compiling Ip :  "+(((IPDeclareContext)_localctx).ipName!=null?_input.getText(((IPDeclareContext)_localctx).ipName.start,((IPDeclareContext)_localctx).ipName.stop):null));
										nextsignal = 0; 
										nextinstance = 0; 
										nb_entry=0;
										String state_start = "hasm hasm ";
										ipreconfigurable="(others=> \'Z\')";
										stackvhdl.clear();
										
			{
			setState(102);
			word16();
			}

									SymbolElement currentIP ; currentIP = new SymbolElement(0,0,0,0 );	
									currentIP.idType = IPonly ; currentIP.slave = in_slave; 
									currentIP.adresse = ipword ; currentIP.adresse_reconfig = -1;  // type IPonly si pas de spec adresse contient le code  de l IP
									vhdl.println (" -- ================= new IP ================");
										vhdl.println ("library IEEE;");
										vhdl.println ("use IEEE.STD_LOGIC_1164.ALL;");
										vhdl.println ("use ieee.std_logic_unsigned.all;");	
										vhdl.println ("entity IP"+vhdlise((((IPDeclareContext)_localctx).ipName!=null?_input.getText(((IPDeclareContext)_localctx).ipName.start,((IPDeclareContext)_localctx).ipName.stop):null))+" is");
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
									
			setState(111);
			_la = _input.LA(1);
			if (_la==T__1) {
				{
				setState(104);
				match(T__1);
				ipreconfigurable="(others=> \'0\')";; currentIP.adresse_reconfig = 0;
				setState(108);
				_la = _input.LA(1);
				if (_la==HEXA) {
					{
					setState(106);
					((IPDeclareContext)_localctx).HEXA = match(HEXA);
					 /// reconfigration dynamique '()' suffit si pas de valeur dispo tout  ZZZ ou 000 si reconfigurable
											int length = (((IPDeclareContext)_localctx).HEXA!=null?((IPDeclareContext)_localctx).HEXA.getText():null).length(); 
											currentIP.adresse_reconfig =Integer.parseInt((((IPDeclareContext)_localctx).HEXA!=null?((IPDeclareContext)_localctx).HEXA.getText():null).substring(1,length) ,16) ;
											
											
					}
				}

				setState(110);
				match(T__2);
				}
			}

			symbol.put((((IPDeclareContext)_localctx).ipName!=null?_input.getText(((IPDeclareContext)_localctx).ipName.start,((IPDeclareContext)_localctx).ipName.stop):null), currentIP);
			setState(195);
			_la = _input.LA(1);
			if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << EntryT) | (1L << InputT) | (1L << OutputT) | (1L << LongT) | (1L << RegisterT) | (1L << ShortT))) != 0)) {
				{
				{
				setState(119);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while (_la==EntryT) {
					{
					{
					setState(114);
					match(EntryT);
					setState(115);
					((IPDeclareContext)_localctx).Name = match(Name);

												nbline = (((IPDeclareContext)_localctx).Name!=null?((IPDeclareContext)_localctx).Name.getLine():0);
												currentIP = new SymbolElement(0,0,0,0 );	
												currentIP.idType = ENTRY ; currentIP.slave = in_slave; currentIP.adresse = ipword+nb_entry; ; currentIP.adresse_reconfig = -1;currentIP.register = false;
												currentIP.fathername = (((IPDeclareContext)_localctx).ipName!=null?_input.getText(((IPDeclareContext)_localctx).ipName.start,((IPDeclareContext)_localctx).ipName.stop):null);currentIP.entry = nb_entry;
												nb_entry++;
												symbol.put((((IPDeclareContext)_localctx).Name!=null?((IPDeclareContext)_localctx).Name.getText():null), currentIP);
												
					}
					}
					setState(121);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				if (nb_entry> 0) {warning (" "+(mylog2(nb_entry)  )+" bits are used for the IP codes associated to the "+nb_entry +" entries !!");}
											
				 register_declare = false;
				setState(150);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << InputT) | (1L << OutputT) | (1L << RegisterT))) != 0)) {
					{
					setState(148);
					switch (_input.LA(1)) {
					case RegisterT:
						{
						{
						setState(124);
						match(RegisterT);
						setState(125);
						((IPDeclareContext)_localctx).Name = match(Name);
							String valueinit = new String("0");nbline = (((IPDeclareContext)_localctx).Name!=null?((IPDeclareContext)_localctx).Name.getLine():0);	
						setState(131);
						_la = _input.LA(1);
						if (_la==AffectVCPC) {
							{
							setState(127);
							match(AffectVCPC);
							setState(128);
							literal();
								valueinit = lit_string;
							}
						}


															InstanceRegister instreg = new InstanceRegister();
															instreg.name=(((IPDeclareContext)_localctx).Name!=null?((IPDeclareContext)_localctx).Name.getText():null);
															instreg.valueinit= valueinit;
															stackreg.push(instreg);
															register_declare = true;
															currentIP = new SymbolElement(0,0,0,0 );	// mise a jour  boolean register ds le symbol IP
															currentIP = symbol.get((((IPDeclareContext)_localctx).ipName!=null?_input.getText(((IPDeclareContext)_localctx).ipName.start,((IPDeclareContext)_localctx).ipName.stop):null));
															currentIP.register = true;
															symbol.put((((IPDeclareContext)_localctx).ipName!=null?_input.getText(((IPDeclareContext)_localctx).ipName.start,((IPDeclareContext)_localctx).ipName.stop):null), currentIP);
															currentIP = new SymbolElement(0,0,0,0 );	
															currentIP.idType = REG ; currentIP.slave = in_slave; currentIP.adresse = 0 ; currentIP.adresse_reconfig = -1;  // type IPonly si pas de spec adresse contient le code  de l IP
															symbol.put(">"+(((IPDeclareContext)_localctx).Name!=null?((IPDeclareContext)_localctx).Name.getText():null), currentIP);
															symbol.put((((IPDeclareContext)_localctx).Name!=null?((IPDeclareContext)_localctx).Name.getText():null)+">", currentIP);
														
						}
						}
						break;
					case InputT:
					case OutputT:
						{
						setState(138);
						switch (_input.LA(1)) {
						case InputT:
							{
							setState(134);
							match(InputT);
							 inout=true;
							}
							break;
						case OutputT:
							{
							setState(136);
							match(OutputT);
							inout=false;
							}
							break;
						default:
							throw new NoViableAltException(this);
						}
						setState(140);
						((IPDeclareContext)_localctx).Name = match(Name);
						setState(145);
						_la = _input.LA(1);
						if (_la==AffectVCPC) {
							{
							setState(141);
							match(AffectVCPC);
							setState(142);
							literal();
								valueinit = lit_string;nbline = (((IPDeclareContext)_localctx).Name!=null?((IPDeclareContext)_localctx).Name.getLine():0);
							}
						}

						currentIP = new SymbolElement(0,0,0,0 );	
															currentIP.idType = REG ; currentIP.slave = in_slave; currentIP.adresse = -1 ; currentIP.adresse_reconfig = -1;  // type IPonly si pas de spec adresse contient le code  de l IP
															
															currentIP.fathername = String.format("x\"%8s", valueinit.substring(1,valueinit.length())).replace(' ', '0').concat("\"");
															
															if ( inout ) {
																vhdl.println ("   ;"+(((IPDeclareContext)_localctx).Name!=null?((IPDeclareContext)_localctx).Name.getText():null)+" : in  STD_LOGIC_VECTOR (31 downto 0) := "+String.format("x\"%8s", valueinit.substring(1,valueinit.length())).replace(' ', '0')+"\"");
																symbol.put((((IPDeclareContext)_localctx).Name!=null?((IPDeclareContext)_localctx).Name.getText():null)+">", currentIP);
															}else{ 
																vhdl.println ("   ;"+(((IPDeclareContext)_localctx).Name!=null?((IPDeclareContext)_localctx).Name.getText():null)+" : out  STD_LOGIC_VECTOR (31 downto 0)");
																vhdl.println ("   ;"+(((IPDeclareContext)_localctx).Name!=null?((IPDeclareContext)_localctx).Name.getText():null)+"_enable : out  STD_LOGIC");
																symbol.put(">"+(((IPDeclareContext)_localctx).Name!=null?((IPDeclareContext)_localctx).Name.getText():null), currentIP);
																outputstack.push( (((IPDeclareContext)_localctx).Name!=null?((IPDeclareContext)_localctx).Name.getText():null)+" <= "+String.format("x\"%8s", valueinit.substring(1,valueinit.length())).replace(' ', '0')+"\" ;");
																outputstack.push( (((IPDeclareContext)_localctx).Name!=null?((IPDeclareContext)_localctx).Name.getText():null)+"_enable <= \'0\' ;");
															}
															
						}
						break;
					default:
						throw new NoViableAltException(this);
					}
					}
					setState(152);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				{
				setState(192);
				switch (_input.LA(1)) {
				case ShortT:
					{
					{
					setState(153);
					((IPDeclareContext)_localctx).ShortT = match(ShortT);
						
												nbline = (((IPDeclareContext)_localctx).ShortT!=null?((IPDeclareContext)_localctx).ShortT.getLine():0);
												short_or_long = true;
												vhdl.println (");");
												vhdl.println ("end IP"+vhdlise((((IPDeclareContext)_localctx).ipName!=null?_input.getText(((IPDeclareContext)_localctx).ipName.start,((IPDeclareContext)_localctx).ipName.stop):null))+";");
												vhdl.println ("architecture archi_IP"+vhdlise((((IPDeclareContext)_localctx).ipName!=null?_input.getText(((IPDeclareContext)_localctx).ipName.start,((IPDeclareContext)_localctx).ipName.stop):null))+" of  IP"+vhdlise((((IPDeclareContext)_localctx).ipName!=null?_input.getText(((IPDeclareContext)_localctx).ipName.start,((IPDeclareContext)_localctx).ipName.stop):null))+" is");

												savereg.clear();
												savereg.addAll(stackreg);
												stackreg.clear();
												stackreg.addAll(savereg);
												if ( x==3 ) stackvhdl.push(new String("N2in"));
												if ( x==2 || x==3) stackvhdl.push(new String("Nin"));
												if ( x!=0 ) stackvhdl.push(new String("Tin"));
											
					setState(156);
					_la = _input.LA(1);
					if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << ThisT) | (1L << OpencaseT) | (1L << HEXA) | (1L << BOOL) | (1L << INT) | (1L << Name))) != 0)) {
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
												short_long = false;
												short_or_long = true;
												restoresymbolreg.clear();
												vhdl.println (" ; IPdone : out STD_LOGIC);");
												vhdl.println ("end IP"+vhdlise((((IPDeclareContext)_localctx).ipName!=null?_input.getText(((IPDeclareContext)_localctx).ipName.start,((IPDeclareContext)_localctx).ipName.stop):null))+";");
												vhdl.println ("architecture archi_IP"+vhdlise((((IPDeclareContext)_localctx).ipName!=null?_input.getText(((IPDeclareContext)_localctx).ipName.start,((IPDeclareContext)_localctx).ipName.stop):null))+" of  IP"+vhdlise((((IPDeclareContext)_localctx).ipName!=null?_input.getText(((IPDeclareContext)_localctx).ipName.start,((IPDeclareContext)_localctx).ipName.stop):null))+" is");


												if ( x==3 ) stackvhdl.push(new String("N2in"));
												if ( x==2 || x==3) stackvhdl.push(new String("Nin"));
												if ( x!=0 ) stackvhdl.push(new String("Tin"));
													longstack.clear();
													longstack.addAll(stackvhdl);
													
													vhdl.println ("signal   IPdone_i : std_logic;");
													vhdl.println ("signal go : std_logic := '0';");
													onlining.push("go <= \'1\' when  mycode(10 downto "+ (mylog2(nb_entry-1)+1) +") =ipcode(10 downto "+ (mylog2(nb_entry-1)+1)+")  else \'0\';");
													vhdl.println ("type state_type is (");
					setState(162); 
					_errHandler.sync(this);
					_la = _input.LA(1);
					do {
						{
						{
						setState(160);
						((IPDeclareContext)_localctx).Name = match(Name);
						 nbline = (((IPDeclareContext)_localctx).Name!=null?((IPDeclareContext)_localctx).Name.getLine():0);
														if (state_start=="hasm hasm ")
														{ state_start = (((IPDeclareContext)_localctx).Name!=null?((IPDeclareContext)_localctx).Name.getText():null);
															long_onlining.push("end process;");
															long_onlining.push("    end case;");
															long_onlining.push("        next_state <= "+(((IPDeclareContext)_localctx).Name!=null?((IPDeclareContext)_localctx).Name.getText():null)+";");
															long_onlining.push("    when others =>");
															vhdl.println ("                  "+(((IPDeclareContext)_localctx).Name!=null?((IPDeclareContext)_localctx).Name.getText():null));
														} else {vhdl.println ("                  , "+(((IPDeclareContext)_localctx).Name!=null?((IPDeclareContext)_localctx).Name.getText():null));}
														
														currentIP = new SymbolElement(0,0,0,0 );	
														currentIP.idType = STATE ; currentIP.slave = in_slave; currentIP.adresse = nb_state++; ; currentIP.adresse_reconfig = -1;currentIP.register = false;
														currentIP.fathername = "";currentIP.entry = -1;
														symbol.put((((IPDeclareContext)_localctx).Name!=null?((IPDeclareContext)_localctx).Name.getText():null), currentIP);
														
													
						}
						}
						setState(164); 
						_errHandler.sync(this);
						_la = _input.LA(1);
					} while ( _la==Name );
					vhdl.println ("                  );");
														vhdl.println ("signal state, next_state : state_type := "+ state_start+" ;");
														
					setState(188);
					_errHandler.sync(this);
					_la = _input.LA(1);
					while (_la==T__3) {
						{
						{
						setState(167);
						match(T__3);
						setState(168);
						((IPDeclareContext)_localctx).Name = match(Name);
						nbline = (((IPDeclareContext)_localctx).Name!=null?((IPDeclareContext)_localctx).Name.getLine():0);
															stackvhdl.clear();
															stackvhdl.addAll(longstack);
															while (!restoresymbolreg.empty()){
																symbol.put(restorenamereg.pop(),restoresymbolreg.pop());
															}
															
						setState(170);
						match(T__4);
						setState(183);
						_la = _input.LA(1);
						if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << IpdoneT) | (1L << StateT) | (1L << ThisT) | (1L << OpencaseT) | (1L << HEXA) | (1L << BOOL) | (1L << INT) | (1L << Name))) != 0)) {
							{
							setState(172);
							_la = _input.LA(1);
							if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << ThisT) | (1L << OpencaseT) | (1L << HEXA) | (1L << BOOL) | (1L << INT) | (1L << Name))) != 0)) {
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
								match(IpdoneT);
								long_onlining.push("        IPdone_i <= '1'; ");
																	 long_onlining.push("        next_state<= "+state_start+"; ");
																	 onlining.push ("IPdone <= \'1\' when IPdone_i=\'1\' else \'0\' ; ");
																	 if (y!=0) onlining.push ("Tout <="+stackvhdl.pop()+" when IPdone_i=\'1\' else "+ipreconfigurable+"; ");
																	if (y>=2) onlining.push ("Nout <="+stackvhdl.pop()+" when IPdone_i=\'1\' else "+ipreconfigurable+"; ");
																	if (y==3) onlining.push ("N2out <="+stackvhdl.pop()+" when IPdone_i=\'1\' else "+ipreconfigurable+"; ");
								}
								break;
							case StateT:
								{
								setState(176);
								match(StateT);
								 long_onlining.push("      next_state<= "+stackvhdl.pop()+"; ");
								}
								break;
							default:
								throw new NoViableAltException(this);
							}
							setState(181);
							_la = _input.LA(1);
							if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << ThisT) | (1L << OpencaseT) | (1L << HEXA) | (1L << BOOL) | (1L << INT) | (1L << Name))) != 0)) {
								{
								setState(180);
								homadeCodeIP();
								}
							}

							}
						}


														long_onlining.push("    when "+(((IPDeclareContext)_localctx).Name!=null?((IPDeclareContext)_localctx).Name.getText():null)+" => ");							
														
						}
						}
						setState(190);
						_errHandler.sync(this);
						_la = _input.LA(1);
					}

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
					}
					break;
				default:
					throw new NoViableAltException(this);
				}
				}
				}
					
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
										 ipcode = symbol.get((((IPDeclareContext)_localctx).ipName!=null?_input.getText(((IPDeclareContext)_localctx).ipName.start,((IPDeclareContext)_localctx).ipName.stop):null)).adresse;
										 y = (ipcode % 0x2000) / 0x0800;
										 if (short_long) {
											vhdl.println (" --  OUPUT  ");
											if ( y> 0 ) vhdl.println ("Tout <= "+ stackvhdl.pop() +" when mycode(10 downto "+ (mylog2(nb_entry-1)+1) +") =ipcode(10 downto "+ (mylog2(nb_entry-1)+1)+") else "+ipreconfigurable+" ;");
											if ( y> 1 ) vhdl.println ("Nout <= "+ stackvhdl.pop() +" when mycode(10 downto "+ (mylog2(nb_entry-1)+1) +") =ipcode(10 downto "+ (mylog2(nb_entry-1)+1)+") else "+ipreconfigurable+" ;");
											if ( y> 2 ) vhdl.println ("N2out <= "+ stackvhdl.pop() +" when mycode(10 downto "+ (mylog2(nb_entry-1)+1) +") =ipcode(10 downto "+ (mylog2(nb_entry-1)+1)+") else "+ipreconfigurable+" ;");
										}
											
										vhdl.println ("end archi_IP"+vhdlise((((IPDeclareContext)_localctx).ipName!=null?_input.getText(((IPDeclareContext)_localctx).ipName.start,((IPDeclareContext)_localctx).ipName.stop):null))+" ;");	
									
									
				}
			}

			setState(197);
			((IPDeclareContext)_localctx).SemiT = match(SemiT);

									nbline = (((IPDeclareContext)_localctx).SemiT!=null?((IPDeclareContext)_localctx).SemiT.getLine():0);
									listcomponent.clear(); 
									if (! short_or_long)
										vhdl.println ("end IP"+vhdlise((((IPDeclareContext)_localctx).ipName!=null?_input.getText(((IPDeclareContext)_localctx).ipName.start,((IPDeclareContext)_localctx).ipName.stop):null))+";");
									
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
		public TerminalNode PcT() { return getToken(H2VParser.PcT, 0); }
		public TerminalNode Name() { return getToken(H2VParser.Name, 0); }
		public VcpcvalueContext vcpcvalue() {
			return getRuleContext(VcpcvalueContext.class,0);
		}
		public PcDeclareContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_pcDeclare; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof H2VListener ) ((H2VListener)listener).enterPcDeclare(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof H2VListener ) ((H2VListener)listener).exitPcDeclare(this);
		}
	}

	public final PcDeclareContext pcDeclare() throws RecognitionException {
		PcDeclareContext _localctx = new PcDeclareContext(_ctx, getState());
		enterRule(_localctx, 6, RULE_pcDeclare);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(200);
			match(PcT);
			setState(201);
			match(Name);
			setState(203);
			_la = _input.LA(1);
			if (_la==AffectVCPC) {
				{
				setState(202);
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
		public TerminalNode VcT() { return getToken(H2VParser.VcT, 0); }
		public TerminalNode Name() { return getToken(H2VParser.Name, 0); }
		public VcpcvalueContext vcpcvalue() {
			return getRuleContext(VcpcvalueContext.class,0);
		}
		public VcDeclareContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_vcDeclare; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof H2VListener ) ((H2VListener)listener).enterVcDeclare(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof H2VListener ) ((H2VListener)listener).exitVcDeclare(this);
		}
	}

	public final VcDeclareContext vcDeclare() throws RecognitionException {
		VcDeclareContext _localctx = new VcDeclareContext(_ctx, getState());
		enterRule(_localctx, 8, RULE_vcDeclare);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(205);
			match(VcT);
			setState(206);
			match(Name);
			setState(208);
			_la = _input.LA(1);
			if (_la==AffectVCPC) {
				{
				setState(207);
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
		public TerminalNode AffectVCPC() { return getToken(H2VParser.AffectVCPC, 0); }
		public TerminalNode Name() { return getToken(H2VParser.Name, 0); }
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
			if ( listener instanceof H2VListener ) ((H2VListener)listener).enterVcpcvalue(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof H2VListener ) ((H2VListener)listener).exitVcpcvalue(this);
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
			setState(210);
			match(AffectVCPC);
			setState(221);
			switch (_input.LA(1)) {
			case Name:
				{
				setState(211);
				match(Name);
				}
				break;
			case HEXA:
			case BOOL:
			case INT:
				{
				setState(212);
				literal();
				}
				break;
			case T__3:
				{
				setState(213);
				match(T__3);
				setState(214);
				iPextend();
				setState(215);
				iPextend();
				setState(217);
				_la = _input.LA(1);
				if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << HEXA) | (1L << BOOL) | (1L << INT) | (1L << Name))) != 0)) {
					{
					setState(216);
					iPextend();
					}
				}

				setState(219);
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
		public TerminalNode Name() { return getToken(H2VParser.Name, 0); }
		public LiteralContext literal() {
			return getRuleContext(LiteralContext.class,0);
		}
		public IPextendContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_iPextend; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof H2VListener ) ((H2VListener)listener).enterIPextend(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof H2VListener ) ((H2VListener)listener).exitIPextend(this);
		}
	}

	public final IPextendContext iPextend() throws RecognitionException {
		IPextendContext _localctx = new IPextendContext(_ctx, getState());
		enterRule(_localctx, 12, RULE_iPextend);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(225);
			switch (_input.LA(1)) {
			case Name:
				{
				setState(223);
				match(Name);
				}
				break;
			case HEXA:
			case BOOL:
			case INT:
				{
				setState(224);
				literal();
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
		public TerminalNode ColonT() { return getToken(H2VParser.ColonT, 0); }
		public IpNameContext ipName() {
			return getRuleContext(IpNameContext.class,0);
		}
		public TerminalNode SemiT() { return getToken(H2VParser.SemiT, 0); }
		public HomadeCodeContext homadeCode() {
			return getRuleContext(HomadeCodeContext.class,0);
		}
		public WordDeclareContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_wordDeclare; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof H2VListener ) ((H2VListener)listener).enterWordDeclare(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof H2VListener ) ((H2VListener)listener).exitWordDeclare(this);
		}
	}

	public final WordDeclareContext wordDeclare() throws RecognitionException {
		WordDeclareContext _localctx = new WordDeclareContext(_ctx, getState());
		enterRule(_localctx, 14, RULE_wordDeclare);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(227);
			match(ColonT);
			setState(228);
			ipName();
			setState(230);
			_la = _input.LA(1);
			if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << BeginT) | (1L << DoT) | (1L << ForT) | (1L << IfT) | (1L << IndiceIT) | (1L << IndiceJT) | (1L << IndiceKT) | (1L << WaitT) | (1L << HEXA) | (1L << BOOL) | (1L << INT) | (1L << Name))) != 0)) {
				{
				setState(229);
				homadeCode();
				}
			}

			setState(232);
			match(SemiT);
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
			if ( listener instanceof H2VListener ) ((H2VListener)listener).enterStaticDeclare(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof H2VListener ) ((H2VListener)listener).exitStaticDeclare(this);
		}
	}

	public final StaticDeclareContext staticDeclare() throws RecognitionException {
		StaticDeclareContext _localctx = new StaticDeclareContext(_ctx, getState());
		enterRule(_localctx, 16, RULE_staticDeclare);
		try {
			enterOuterAlt(_localctx, 1);
			{
			{
			setState(234);
			vcpcName();
			setState(235);
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
		public TerminalNode HEXA() { return getToken(H2VParser.HEXA, 0); }
		public TerminalNode BOOL() { return getToken(H2VParser.BOOL, 0); }
		public TerminalNode INT() { return getToken(H2VParser.INT, 0); }
		public LiteralContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_literal; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof H2VListener ) ((H2VListener)listener).enterLiteral(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof H2VListener ) ((H2VListener)listener).exitLiteral(this);
		}
	}

	public final LiteralContext literal() throws RecognitionException {
		LiteralContext _localctx = new LiteralContext(_ctx, getState());
		enterRule(_localctx, 18, RULE_literal);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(243);
			switch (_input.LA(1)) {
			case HEXA:
				{
				setState(237);
				((LiteralContext)_localctx).HEXA = match(HEXA);
				 lit_string= (((LiteralContext)_localctx).HEXA!=null?((LiteralContext)_localctx).HEXA.getText():null);
				}
				break;
			case BOOL:
				{
				setState(239);
				((LiteralContext)_localctx).BOOL = match(BOOL);
				 lit_string= hex8((int)(long)Long.parseLong( (((LiteralContext)_localctx).BOOL!=null?((LiteralContext)_localctx).BOOL.getText():null).substring(1,(((LiteralContext)_localctx).BOOL!=null?((LiteralContext)_localctx).BOOL.getText():null).length()), 2));
				}
				break;
			case INT:
				{
				setState(241);
				((LiteralContext)_localctx).INT = match(INT);
				 lit_string= hex8((((LiteralContext)_localctx).INT!=null?Integer.valueOf(((LiteralContext)_localctx).INT.getText()):0));
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

	public static class Word16Context extends ParserRuleContext {
		public Token HEXA;
		public TerminalNode HEXA() { return getToken(H2VParser.HEXA, 0); }
		public Word16Context(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_word16; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof H2VListener ) ((H2VListener)listener).enterWord16(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof H2VListener ) ((H2VListener)listener).exitWord16(this);
		}
	}

	public final Word16Context word16() throws RecognitionException {
		Word16Context _localctx = new Word16Context(_ctx, getState());
		enterRule(_localctx, 20, RULE_word16);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(245);
			((Word16Context)_localctx).HEXA = match(HEXA);
				int length = (((Word16Context)_localctx).HEXA!=null?((Word16Context)_localctx).HEXA.getText():null).length(); 
									if (length != 5 ){
										warning("value out of range 16 bits fixed");
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
		public TerminalNode BeginT() { return getToken(H2VParser.BeginT, 0); }
		public TerminalNode ForT() { return getToken(H2VParser.ForT, 0); }
		public TerminalNode NextT() { return getToken(H2VParser.NextT, 0); }
		public TerminalNode DoT() { return getToken(H2VParser.DoT, 0); }
		public TerminalNode IfT() { return getToken(H2VParser.IfT, 0); }
		public TerminalNode WaitT() { return getToken(H2VParser.WaitT, 0); }
		public TerminalNode IndiceIT() { return getToken(H2VParser.IndiceIT, 0); }
		public TerminalNode IndiceJT() { return getToken(H2VParser.IndiceJT, 0); }
		public TerminalNode IndiceKT() { return getToken(H2VParser.IndiceKT, 0); }
		public TerminalNode Name() { return getToken(H2VParser.Name, 0); }
		public LiteralContext literal() {
			return getRuleContext(LiteralContext.class,0);
		}
		public TerminalNode AgainT() { return getToken(H2VParser.AgainT, 0); }
		public TerminalNode UntilT() { return getToken(H2VParser.UntilT, 0); }
		public TerminalNode LoopT() { return getToken(H2VParser.LoopT, 0); }
		public TerminalNode LoopplusT() { return getToken(H2VParser.LoopplusT, 0); }
		public List<HomadeCodeContext> homadeCode() {
			return getRuleContexts(HomadeCodeContext.class);
		}
		public HomadeCodeContext homadeCode(int i) {
			return getRuleContext(HomadeCodeContext.class,i);
		}
		public TerminalNode EndifT() { return getToken(H2VParser.EndifT, 0); }
		public TerminalNode ElseT() { return getToken(H2VParser.ElseT, 0); }
		public List<TerminalNode> INT() { return getTokens(H2VParser.INT); }
		public TerminalNode INT(int i) {
			return getToken(H2VParser.INT, i);
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
			if ( listener instanceof H2VListener ) ((H2VListener)listener).enterHomadeCode(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof H2VListener ) ((H2VListener)listener).exitHomadeCode(this);
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
			setState(289);
			switch (_input.LA(1)) {
			case BeginT:
				{
				setState(248);
				match(BeginT);
				setState(250);
				_la = _input.LA(1);
				if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << BeginT) | (1L << DoT) | (1L << ForT) | (1L << IfT) | (1L << IndiceIT) | (1L << IndiceJT) | (1L << IndiceKT) | (1L << WaitT) | (1L << HEXA) | (1L << BOOL) | (1L << INT) | (1L << Name))) != 0)) {
					{
					setState(249);
					homadeCode();
					}
				}

				setState(252);
				_la = _input.LA(1);
				if ( !(_la==AgainT || _la==UntilT) ) {
				_errHandler.recoverInline(this);
				} else {
					consume();
				}
				}
				break;
			case ForT:
				{
				setState(253);
				match(ForT);
				setState(255);
				_la = _input.LA(1);
				if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << BeginT) | (1L << DoT) | (1L << ForT) | (1L << IfT) | (1L << IndiceIT) | (1L << IndiceJT) | (1L << IndiceKT) | (1L << WaitT) | (1L << HEXA) | (1L << BOOL) | (1L << INT) | (1L << Name))) != 0)) {
					{
					setState(254);
					homadeCode();
					}
				}

				setState(257);
				match(NextT);
				}
				break;
			case DoT:
				{
				setState(258);
				match(DoT);
				setState(260);
				_la = _input.LA(1);
				if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << BeginT) | (1L << DoT) | (1L << ForT) | (1L << IfT) | (1L << IndiceIT) | (1L << IndiceJT) | (1L << IndiceKT) | (1L << WaitT) | (1L << HEXA) | (1L << BOOL) | (1L << INT) | (1L << Name))) != 0)) {
					{
					setState(259);
					homadeCode();
					}
				}

				setState(262);
				_la = _input.LA(1);
				if ( !(_la==LoopplusT || _la==LoopT) ) {
				_errHandler.recoverInline(this);
				} else {
					consume();
				}
				}
				break;
			case IfT:
				{
				setState(263);
				match(IfT);
				setState(265);
				_la = _input.LA(1);
				if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << BeginT) | (1L << DoT) | (1L << ForT) | (1L << IfT) | (1L << IndiceIT) | (1L << IndiceJT) | (1L << IndiceKT) | (1L << WaitT) | (1L << HEXA) | (1L << BOOL) | (1L << INT) | (1L << Name))) != 0)) {
					{
					setState(264);
					homadeCode();
					}
				}

				setState(273);
				switch (_input.LA(1)) {
				case ElseT:
					{
					{
					setState(267);
					match(ElseT);
					setState(269);
					_la = _input.LA(1);
					if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << BeginT) | (1L << DoT) | (1L << ForT) | (1L << IfT) | (1L << IndiceIT) | (1L << IndiceJT) | (1L << IndiceKT) | (1L << WaitT) | (1L << HEXA) | (1L << BOOL) | (1L << INT) | (1L << Name))) != 0)) {
						{
						setState(268);
						homadeCode();
						}
					}

					setState(271);
					match(EndifT);
					}
					}
					break;
				case EndifT:
					{
					setState(272);
					match(EndifT);
					}
					break;
				default:
					throw new NoViableAltException(this);
				}
				}
				break;
			case WaitT:
				{
				setState(275);
				match(WaitT);
				}
				break;
			case IndiceIT:
				{
				setState(276);
				match(IndiceIT);
				}
				break;
			case IndiceJT:
				{
				setState(277);
				match(IndiceJT);
				}
				break;
			case IndiceKT:
				{
				setState(278);
				match(IndiceKT);
				}
				break;
			case Name:
				{
				setState(279);
				match(Name);
				setState(286);
				switch (_input.LA(1)) {
				case T__3:
					{
					{
					setState(280);
					match(T__3);
					setState(281);
					match(INT);
					setState(282);
					match(INT);
					setState(283);
					match(T__4);
					}
					}
					break;
				case AffectVCPC:
					{
					{
					setState(284);
					vcpcvalue();
					}
					}
					break;
				case T__5:
					{
					{
					setState(285);
					match(T__5);
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
				setState(288);
				literal();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
			setState(294);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,43,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					{
					{
					setState(291);
					homadeCode();
					}
					} 
				}
				setState(296);
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
		public Token OpencaseT;
		public Token CaseT;
		public Token ClosecaseT;
		public TerminalNode Name() { return getToken(H2VParser.Name, 0); }
		public LiteralContext literal() {
			return getRuleContext(LiteralContext.class,0);
		}
		public TerminalNode ThisT() { return getToken(H2VParser.ThisT, 0); }
		public List<HomadeCodeIPContext> homadeCodeIP() {
			return getRuleContexts(HomadeCodeIPContext.class);
		}
		public HomadeCodeIPContext homadeCodeIP(int i) {
			return getRuleContext(HomadeCodeIPContext.class,i);
		}
		public TerminalNode OpencaseT() { return getToken(H2VParser.OpencaseT, 0); }
		public TerminalNode ClosecaseT() { return getToken(H2VParser.ClosecaseT, 0); }
		public List<TerminalNode> CaseT() { return getTokens(H2VParser.CaseT); }
		public TerminalNode CaseT(int i) {
			return getToken(H2VParser.CaseT, i);
		}
		public HomadeCodeIPContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_homadeCodeIP; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof H2VListener ) ((H2VListener)listener).enterHomadeCodeIP(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof H2VListener ) ((H2VListener)listener).exitHomadeCodeIP(this);
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
			setState(329);
			switch (_input.LA(1)) {
			case Name:
				{
				setState(297);
				((HomadeCodeIPContext)_localctx).Name = match(Name);
				String currentname = (((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null), s1, s2, s3, s4 ;
										nbline = (((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getLine():0);
										InstanceElement instance = new InstanceElement ();
										instance.userdefined = false;
									if(symbol.containsKey((((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null))){
										if(symbol.get((((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null)).idType == IPonly){
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
											
										}else if(symbol.get((((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null)).idType == ENTRY){
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
										else if(symbol.get((((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null)).idType == REG){
											if ((((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null).charAt(0)=='>'){
												if (!multiplexeur) {
													if (!short_long) {  // long
														if(symbol.get((((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null)).adresse == -1 ){ //output
															long_onlining.push ("		"+(((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null).substring(1,(((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null).length())+" <= "+stackvhdl.pop()+" ;");
															long_onlining.push ("		"+(((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null).substring(1,(((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null).length()).concat("_enable")+" <= \'1\' ;");
														}else{
														String ls =stackvhdl.pop();
															long_onlining.push ("		"+(((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null).substring(1,(((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null).length())+"_i <= "+ls+" ;");
															if (ls.charAt(1)!='\"')stacksensivity.push(ls);
														}
														restorenamereg.push((((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null));				// empile le registre pour restauration  sur le state suivant
														restoresymbolreg.push(symbol.get((((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null)));
														symbol.remove((((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null));
													} else {   // short
														if(symbol.get((((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null)).adresse == -1 ){ //output
															onlining.push ((((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null).substring(1,(((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null).length())+" <= "+stackvhdl.pop()+" when mycode(10 downto "
																			+ (mylog2(nb_entry-1)+1) +") =ipcode(10 downto "+ (mylog2(nb_entry-1)+1)+")  else "+symbol.get((((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null)).fathername+" ;");
															onlining.push ((((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null).substring(1,(((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null).length()).concat("_enable")+" <= \'1\'  when mycode(10 downto "
																			+ (mylog2(nb_entry-1)+1) +") =ipcode(10 downto "+ (mylog2(nb_entry-1)+1)+")  else \'0\' ;");
														}else{
															onlining.push ((((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null).substring(1,(((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null).length())+"_i <= "+stackvhdl.pop()+" when mycode(10 downto "
																			+ (mylog2(nb_entry-1)+1) +") =ipcode(10 downto "+ (mylog2(nb_entry-1)+1)+")  else "+(((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null).substring(1,(((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null).length())+" ;");
														}							
														symbol.remove((((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null));
													}
												} else {
													error(" store in register or Ouput not allowed here ", nbline); 
												}
											}else {
												if(symbol.get((((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null)).adresse == -1 ){ //Input 
													stackvhdl.push((((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null).substring(0,(((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null).length()-1));
												}else{ 
													stackvhdl.push((((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null).substring(0,(((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null).length()-1));
												}
											}
										}	
										else if(symbol.get((((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null)).idType == STATE){
											//stackvhdl.push(String.format("x\"%8s", symbol.get((((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null)).adresse).replace(' ', '0'));
											stackvhdl.push((((HomadeCodeIPContext)_localctx).Name!=null?((HomadeCodeIPContext)_localctx).Name.getText():null));
										} 
										else 
											error (" "+ currentname +" is not IP nor register nor IO port !!!", nbline);
									} else
										error (" "+ currentname +" does not exist anymore !!!", nbline);
									
				}
				break;
			case HEXA:
			case BOOL:
			case INT:
				{
				setState(299);
				literal();
							String signalname =String.format("x\"%8s", lit_string.substring(1,lit_string.length())).concat("\"").replace(' ', '0');
											stackvhdl.push(signalname);
								
				}
				break;
			case ThisT:
				{
				setState(302);
				match(ThisT);
				String signalname = "Hasm".concat(hex(nextsignal++).substring(2,6));
									stackvhdl.push(" (ipcode - mycode) ");
									
				}
				break;
			case OpencaseT:
				{
				{
				setState(304);
				((HomadeCodeIPContext)_localctx).OpencaseT = match(OpencaseT);

								nbline = (((HomadeCodeIPContext)_localctx).OpencaseT!=null?((HomadeCodeIPContext)_localctx).OpencaseT.getLine():0);
								if (multiplexeur) {
										error (" |- -| not allowed here #", nbline);
									} else {
										multiplexeur = true ; 
										nbCase = 0;
										selecteur = stackvhdl.pop();
										savestack.clear();
										savestack.addAll(stackvhdl);
										}
									
				setState(307); 
				_errHandler.sync(this);
				_la = _input.LA(1);
				do {
					{
					{
					setState(306);
					homadeCodeIP();
					}
					}
					setState(309); 
					_errHandler.sync(this);
					_la = _input.LA(1);
				} while ( (((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << ThisT) | (1L << OpencaseT) | (1L << HEXA) | (1L << BOOL) | (1L << INT) | (1L << Name))) != 0) );

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
									
				setState(323);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while (_la==CaseT) {
					{
					{
					setState(312);
					((HomadeCodeIPContext)_localctx).CaseT = match(CaseT);
					nbline = (((HomadeCodeIPContext)_localctx).CaseT!=null?((HomadeCodeIPContext)_localctx).CaseT.getLine():0);
					setState(317); 
					_errHandler.sync(this);
					_la = _input.LA(1);
					do {
						{
						{
						setState(314);
						homadeCodeIP();

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
						}
						setState(319); 
						_errHandler.sync(this);
						_la = _input.LA(1);
					} while ( (((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << ThisT) | (1L << OpencaseT) | (1L << HEXA) | (1L << BOOL) | (1L << INT) | (1L << Name))) != 0) );
					}
					}
					setState(325);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				setState(326);
				((HomadeCodeIPContext)_localctx).ClosecaseT = match(ClosecaseT);

										nbline = (((HomadeCodeIPContext)_localctx).ClosecaseT!=null?((HomadeCodeIPContext)_localctx).ClosecaseT.getLine():0);
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
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
			setState(334);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,48,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					{
					{
					setState(331);
					homadeCodeIP();
					}
					} 
				}
				setState(336);
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
		public TerminalNode Name() { return getToken(H2VParser.Name, 0); }
		public VcpcNameContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_vcpcName; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof H2VListener ) ((H2VListener)listener).enterVcpcName(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof H2VListener ) ((H2VListener)listener).exitVcpcName(this);
		}
	}

	public final VcpcNameContext vcpcName() throws RecognitionException {
		VcpcNameContext _localctx = new VcpcNameContext(_ctx, getState());
		enterRule(_localctx, 26, RULE_vcpcName);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(337);
			match(Name);
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
			if ( listener instanceof H2VListener ) ((H2VListener)listener).enterRet(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof H2VListener ) ((H2VListener)listener).exitRet(this);
		}
	}

	public final RetContext ret() throws RecognitionException {
		RetContext _localctx = new RetContext(_ctx, getState());
		enterRule(_localctx, 28, RULE_ret);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(339);
			match(T__6);
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
			if ( listener instanceof H2VListener ) ((H2VListener)listener).enterHalt(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof H2VListener ) ((H2VListener)listener).exitHalt(this);
		}
	}

	public final HaltContext halt() throws RecognitionException {
		HaltContext _localctx = new HaltContext(_ctx, getState());
		enterRule(_localctx, 30, RULE_halt);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(341);
			match(T__7);
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
		"\3\u0430\ud6d1\u8206\uad2d\u4417\uaef1\u8d80\uaadd\3\66\u015a\4\2\t\2"+
		"\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4\13"+
		"\t\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\3\2\3\2"+
		"\3\2\3\3\3\3\3\3\3\3\3\3\3\3\7\3,\n\3\f\3\16\3/\13\3\3\3\3\3\3\3\3\3\3"+
		"\3\3\3\3\3\7\38\n\3\f\3\16\3;\13\3\3\3\3\3\7\3?\n\3\f\3\16\3B\13\3\3\3"+
		"\3\3\3\3\3\3\3\3\3\3\7\3J\n\3\f\3\16\3M\13\3\3\3\3\3\3\3\3\3\3\3\3\3\3"+
		"\3\7\3V\n\3\f\3\16\3Y\13\3\3\3\5\3\\\n\3\3\3\7\3_\n\3\f\3\16\3b\13\3\3"+
		"\3\3\3\3\3\3\4\3\4\3\4\3\4\3\4\3\4\3\4\3\4\5\4o\n\4\3\4\5\4r\n\4\3\4\3"+
		"\4\3\4\3\4\7\4x\n\4\f\4\16\4{\13\4\3\4\3\4\3\4\3\4\3\4\3\4\3\4\3\4\3\4"+
		"\5\4\u0086\n\4\3\4\3\4\3\4\3\4\3\4\5\4\u008d\n\4\3\4\3\4\3\4\3\4\3\4\5"+
		"\4\u0094\n\4\3\4\7\4\u0097\n\4\f\4\16\4\u009a\13\4\3\4\3\4\3\4\5\4\u009f"+
		"\n\4\3\4\3\4\3\4\3\4\6\4\u00a5\n\4\r\4\16\4\u00a6\3\4\3\4\3\4\3\4\3\4"+
		"\3\4\5\4\u00af\n\4\3\4\3\4\3\4\3\4\5\4\u00b5\n\4\3\4\5\4\u00b8\n\4\5\4"+
		"\u00ba\n\4\3\4\7\4\u00bd\n\4\f\4\16\4\u00c0\13\4\3\4\5\4\u00c3\n\4\3\4"+
		"\5\4\u00c6\n\4\3\4\3\4\3\4\3\5\3\5\3\5\5\5\u00ce\n\5\3\6\3\6\3\6\5\6\u00d3"+
		"\n\6\3\7\3\7\3\7\3\7\3\7\3\7\3\7\5\7\u00dc\n\7\3\7\3\7\5\7\u00e0\n\7\3"+
		"\b\3\b\5\b\u00e4\n\b\3\t\3\t\3\t\5\t\u00e9\n\t\3\t\3\t\3\n\3\n\3\n\3\13"+
		"\3\13\3\13\3\13\3\13\3\13\5\13\u00f6\n\13\3\f\3\f\3\f\3\r\3\r\5\r\u00fd"+
		"\n\r\3\r\3\r\3\r\5\r\u0102\n\r\3\r\3\r\3\r\5\r\u0107\n\r\3\r\3\r\3\r\5"+
		"\r\u010c\n\r\3\r\3\r\5\r\u0110\n\r\3\r\3\r\5\r\u0114\n\r\3\r\3\r\3\r\3"+
		"\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\5\r\u0121\n\r\3\r\5\r\u0124\n\r\3\r\7\r"+
		"\u0127\n\r\f\r\16\r\u012a\13\r\3\16\3\16\3\16\3\16\3\16\3\16\3\16\3\16"+
		"\3\16\3\16\6\16\u0136\n\16\r\16\16\16\u0137\3\16\3\16\3\16\3\16\3\16\3"+
		"\16\6\16\u0140\n\16\r\16\16\16\u0141\7\16\u0144\n\16\f\16\16\16\u0147"+
		"\13\16\3\16\3\16\3\16\5\16\u014c\n\16\3\16\7\16\u014f\n\16\f\16\16\16"+
		"\u0152\13\16\3\17\3\17\3\20\3\20\3\21\3\21\3\21\2\2\22\2\4\6\b\n\f\16"+
		"\20\22\24\26\30\32\34\36 \2\4\4\2\13\13++\3\2\37 \u0191\2\"\3\2\2\2\4"+
		"%\3\2\2\2\6f\3\2\2\2\b\u00ca\3\2\2\2\n\u00cf\3\2\2\2\f\u00d4\3\2\2\2\16"+
		"\u00e3\3\2\2\2\20\u00e5\3\2\2\2\22\u00ec\3\2\2\2\24\u00f5\3\2\2\2\26\u00f7"+
		"\3\2\2\2\30\u0123\3\2\2\2\32\u014b\3\2\2\2\34\u0153\3\2\2\2\36\u0155\3"+
		"\2\2\2 \u0157\3\2\2\2\"#\7\65\2\2#$\b\2\1\2$\3\3\2\2\2%-\b\3\1\2&\'\7"+
		"\35\2\2\',\5\6\4\2(,\5\n\6\2),\5\20\t\2*,\5\22\n\2+&\3\2\2\2+(\3\2\2\2"+
		"+)\3\2\2\2+*\3\2\2\2,/\3\2\2\2-+\3\2\2\2-.\3\2\2\2.[\3\2\2\2/-\3\2\2\2"+
		"\609\7\3\2\2\61\62\7\35\2\2\628\5\6\4\2\638\5\b\5\2\648\5\n\6\2\658\5"+
		"\20\t\2\668\5\22\n\2\67\61\3\2\2\2\67\63\3\2\2\2\67\64\3\2\2\2\67\65\3"+
		"\2\2\2\67\66\3\2\2\28;\3\2\2\29\67\3\2\2\29:\3\2\2\2:<\3\2\2\2;9\3\2\2"+
		"\2<@\7)\2\2=?\5\30\r\2>=\3\2\2\2?B\3\2\2\2@>\3\2\2\2@A\3\2\2\2AC\3\2\2"+
		"\2B@\3\2\2\2CK\7!\2\2DE\7\35\2\2EJ\5\6\4\2FJ\5\n\6\2GJ\5\20\t\2HJ\5\22"+
		"\n\2ID\3\2\2\2IF\3\2\2\2IG\3\2\2\2IH\3\2\2\2JM\3\2\2\2KI\3\2\2\2KL\3\2"+
		"\2\2LN\3\2\2\2MK\3\2\2\2N\\\7)\2\2OW\7$\2\2PQ\7\35\2\2QV\5\6\4\2RV\5\n"+
		"\6\2SV\5\20\t\2TV\5\22\n\2UP\3\2\2\2UR\3\2\2\2US\3\2\2\2UT\3\2\2\2VY\3"+
		"\2\2\2WU\3\2\2\2WX\3\2\2\2XZ\3\2\2\2YW\3\2\2\2Z\\\7)\2\2[\60\3\2\2\2["+
		"O\3\2\2\2\\`\3\2\2\2]_\5\30\r\2^]\3\2\2\2_b\3\2\2\2`^\3\2\2\2`a\3\2\2"+
		"\2ac\3\2\2\2b`\3\2\2\2cd\7\21\2\2de\b\3\1\2e\5\3\2\2\2fg\5\2\2\2gh\b\4"+
		"\1\2hi\5\26\f\2iq\b\4\1\2jk\7\4\2\2kn\b\4\1\2lm\7\61\2\2mo\b\4\1\2nl\3"+
		"\2\2\2no\3\2\2\2op\3\2\2\2pr\7\5\2\2qj\3\2\2\2qr\3\2\2\2rs\3\2\2\2s\u00c5"+
		"\b\4\1\2tu\7\22\2\2uv\7\65\2\2vx\b\4\1\2wt\3\2\2\2x{\3\2\2\2yw\3\2\2\2"+
		"yz\3\2\2\2z|\3\2\2\2{y\3\2\2\2|}\b\4\1\2}\u0098\b\4\1\2~\177\7%\2\2\177"+
		"\u0080\7\65\2\2\u0080\u0085\b\4\1\2\u0081\u0082\7&\2\2\u0082\u0083\5\24"+
		"\13\2\u0083\u0084\b\4\1\2\u0084\u0086\3\2\2\2\u0085\u0081\3\2\2\2\u0085"+
		"\u0086\3\2\2\2\u0086\u0087\3\2\2\2\u0087\u0097\b\4\1\2\u0088\u0089\7\25"+
		"\2\2\u0089\u008d\b\4\1\2\u008a\u008b\7\26\2\2\u008b\u008d\b\4\1\2\u008c"+
		"\u0088\3\2\2\2\u008c\u008a\3\2\2\2\u008d\u008e\3\2\2\2\u008e\u0093\7\65"+
		"\2\2\u008f\u0090\7&\2\2\u0090\u0091\5\24\13\2\u0091\u0092\b\4\1\2\u0092"+
		"\u0094\3\2\2\2\u0093\u008f\3\2\2\2\u0093\u0094\3\2\2\2\u0094\u0095\3\2"+
		"\2\2\u0095\u0097\b\4\1\2\u0096~\3\2\2\2\u0096\u008c\3\2\2\2\u0097\u009a"+
		"\3\2\2\2\u0098\u0096\3\2\2\2\u0098\u0099\3\2\2\2\u0099\u00c2\3\2\2\2\u009a"+
		"\u0098\3\2\2\2\u009b\u009c\7\'\2\2\u009c\u009e\b\4\1\2\u009d\u009f\5\32"+
		"\16\2\u009e\u009d\3\2\2\2\u009e\u009f\3\2\2\2\u009f\u00c3\3\2\2\2\u00a0"+
		"\u00a1\7\36\2\2\u00a1\u00a4\b\4\1\2\u00a2\u00a3\7\65\2\2\u00a3\u00a5\b"+
		"\4\1\2\u00a4\u00a2\3\2\2\2\u00a5\u00a6\3\2\2\2\u00a6\u00a4\3\2\2\2\u00a6"+
		"\u00a7\3\2\2\2\u00a7\u00a8\3\2\2\2\u00a8\u00be\b\4\1\2\u00a9\u00aa\7\6"+
		"\2\2\u00aa\u00ab\7\65\2\2\u00ab\u00ac\b\4\1\2\u00ac\u00b9\7\7\2\2\u00ad"+
		"\u00af\5\32\16\2\u00ae\u00ad\3\2\2\2\u00ae\u00af\3\2\2\2\u00af\u00b4\3"+
		"\2\2\2\u00b0\u00b1\7\23\2\2\u00b1\u00b5\b\4\1\2\u00b2\u00b3\7\24\2\2\u00b3"+
		"\u00b5\b\4\1\2\u00b4\u00b0\3\2\2\2\u00b4\u00b2\3\2\2\2\u00b5\u00b7\3\2"+
		"\2\2\u00b6\u00b8\5\32\16\2\u00b7\u00b6\3\2\2\2\u00b7\u00b8\3\2\2\2\u00b8"+
		"\u00ba\3\2\2\2\u00b9\u00ae\3\2\2\2\u00b9\u00ba\3\2\2\2\u00ba\u00bb\3\2"+
		"\2\2\u00bb\u00bd\b\4\1\2\u00bc\u00a9\3\2\2\2\u00bd\u00c0\3\2\2\2\u00be"+
		"\u00bc\3\2\2\2\u00be\u00bf\3\2\2\2\u00bf\u00c1\3\2\2\2\u00c0\u00be\3\2"+
		"\2\2\u00c1\u00c3\b\4\1\2\u00c2\u009b\3\2\2\2\u00c2\u00a0\3\2\2\2\u00c3"+
		"\u00c4\3\2\2\2\u00c4\u00c6\b\4\1\2\u00c5y\3\2\2\2\u00c5\u00c6\3\2\2\2"+
		"\u00c6\u00c7\3\2\2\2\u00c7\u00c8\7*\2\2\u00c8\u00c9\b\4\1\2\u00c9\7\3"+
		"\2\2\2\u00ca\u00cb\7#\2\2\u00cb\u00cd\7\65\2\2\u00cc\u00ce\5\f\7\2\u00cd"+
		"\u00cc\3\2\2\2\u00cd\u00ce\3\2\2\2\u00ce\t\3\2\2\2\u00cf\u00d0\7,\2\2"+
		"\u00d0\u00d2\7\65\2\2\u00d1\u00d3\5\f\7\2\u00d2\u00d1\3\2\2\2\u00d2\u00d3"+
		"\3\2\2\2\u00d3\13\3\2\2\2\u00d4\u00df\7&\2\2\u00d5\u00e0\7\65\2\2\u00d6"+
		"\u00e0\5\24\13\2\u00d7\u00d8\7\6\2\2\u00d8\u00d9\5\16\b\2\u00d9\u00db"+
		"\5\16\b\2\u00da\u00dc\5\16\b\2\u00db\u00da\3\2\2\2\u00db\u00dc\3\2\2\2"+
		"\u00dc\u00dd\3\2\2\2\u00dd\u00de\7\7\2\2\u00de\u00e0\3\2\2\2\u00df\u00d5"+
		"\3\2\2\2\u00df\u00d6\3\2\2\2\u00df\u00d7\3\2\2\2\u00e0\r\3\2\2\2\u00e1"+
		"\u00e4\7\65\2\2\u00e2\u00e4\5\24\13\2\u00e3\u00e1\3\2\2\2\u00e3\u00e2"+
		"\3\2\2\2\u00e4\17\3\2\2\2\u00e5\u00e6\7\r\2\2\u00e6\u00e8\5\2\2\2\u00e7"+
		"\u00e9\5\30\r\2\u00e8\u00e7\3\2\2\2\u00e8\u00e9\3\2\2\2\u00e9\u00ea\3"+
		"\2\2\2\u00ea\u00eb\7*\2\2\u00eb\21\3\2\2\2\u00ec\u00ed\5\34\17\2\u00ed"+
		"\u00ee\5\f\7\2\u00ee\23\3\2\2\2\u00ef\u00f0\7\61\2\2\u00f0\u00f6\b\13"+
		"\1\2\u00f1\u00f2\7\62\2\2\u00f2\u00f6\b\13\1\2\u00f3\u00f4\7\63\2\2\u00f4"+
		"\u00f6\b\13\1\2\u00f5\u00ef\3\2\2\2\u00f5\u00f1\3\2\2\2\u00f5\u00f3\3"+
		"\2\2\2\u00f6\25\3\2\2\2\u00f7\u00f8\7\61\2\2\u00f8\u00f9\b\f\1\2\u00f9"+
		"\27\3\2\2\2\u00fa\u00fc\7\f\2\2\u00fb\u00fd\5\30\r\2\u00fc\u00fb\3\2\2"+
		"\2\u00fc\u00fd\3\2\2\2\u00fd\u00fe\3\2\2\2\u00fe\u0124\t\2\2\2\u00ff\u0101"+
		"\7\27\2\2\u0100\u0102\5\30\r\2\u0101\u0100\3\2\2\2\u0101\u0102\3\2\2\2"+
		"\u0102\u0103\3\2\2\2\u0103\u0124\7\"\2\2\u0104\u0106\7\16\2\2\u0105\u0107"+
		"\5\30\r\2\u0106\u0105\3\2\2\2\u0106\u0107\3\2\2\2\u0107\u0108\3\2\2\2"+
		"\u0108\u0124\t\3\2\2\u0109\u010b\7\30\2\2\u010a\u010c\5\30\r\2\u010b\u010a"+
		"\3\2\2\2\u010b\u010c\3\2\2\2\u010c\u0113\3\2\2\2\u010d\u010f\7\17\2\2"+
		"\u010e\u0110\5\30\r\2\u010f\u010e\3\2\2\2\u010f\u0110\3\2\2\2\u0110\u0111"+
		"\3\2\2\2\u0111\u0114\7\20\2\2\u0112\u0114\7\20\2\2\u0113\u010d\3\2\2\2"+
		"\u0113\u0112\3\2\2\2\u0114\u0124\3\2\2\2\u0115\u0124\7-\2\2\u0116\u0124"+
		"\7\31\2\2\u0117\u0124\7\32\2\2\u0118\u0124\7\33\2\2\u0119\u0120\7\65\2"+
		"\2\u011a\u011b\7\6\2\2\u011b\u011c\7\63\2\2\u011c\u011d\7\63\2\2\u011d"+
		"\u0121\7\7\2\2\u011e\u0121\5\f\7\2\u011f\u0121\7\b\2\2\u0120\u011a\3\2"+
		"\2\2\u0120\u011e\3\2\2\2\u0120\u011f\3\2\2\2\u0120\u0121\3\2\2\2\u0121"+
		"\u0124\3\2\2\2\u0122\u0124\5\24\13\2\u0123\u00fa\3\2\2\2\u0123\u00ff\3"+
		"\2\2\2\u0123\u0104\3\2\2\2\u0123\u0109\3\2\2\2\u0123\u0115\3\2\2\2\u0123"+
		"\u0116\3\2\2\2\u0123\u0117\3\2\2\2\u0123\u0118\3\2\2\2\u0123\u0119\3\2"+
		"\2\2\u0123\u0122\3\2\2\2\u0124\u0128\3\2\2\2\u0125\u0127\5\30\r\2\u0126"+
		"\u0125\3\2\2\2\u0127\u012a\3\2\2\2\u0128\u0126\3\2\2\2\u0128\u0129\3\2"+
		"\2\2\u0129\31\3\2\2\2\u012a\u0128\3\2\2\2\u012b\u012c\7\65\2\2\u012c\u014c"+
		"\b\16\1\2\u012d\u012e\5\24\13\2\u012e\u012f\b\16\1\2\u012f\u014c\3\2\2"+
		"\2\u0130\u0131\7\34\2\2\u0131\u014c\b\16\1\2\u0132\u0133\7.\2\2\u0133"+
		"\u0135\b\16\1\2\u0134\u0136\5\32\16\2\u0135\u0134\3\2\2\2\u0136\u0137"+
		"\3\2\2\2\u0137\u0135\3\2\2\2\u0137\u0138\3\2\2\2\u0138\u0139\3\2\2\2\u0139"+
		"\u0145\b\16\1\2\u013a\u013b\7/\2\2\u013b\u013f\b\16\1\2\u013c\u013d\5"+
		"\32\16\2\u013d\u013e\b\16\1\2\u013e\u0140\3\2\2\2\u013f\u013c\3\2\2\2"+
		"\u0140\u0141\3\2\2\2\u0141\u013f\3\2\2\2\u0141\u0142\3\2\2\2\u0142\u0144"+
		"\3\2\2\2\u0143\u013a\3\2\2\2\u0144\u0147\3\2\2\2\u0145\u0143\3\2\2\2\u0145"+
		"\u0146\3\2\2\2\u0146\u0148\3\2\2\2\u0147\u0145\3\2\2\2\u0148\u0149\7\60"+
		"\2\2\u0149\u014a\b\16\1\2\u014a\u014c\3\2\2\2\u014b\u012b\3\2\2\2\u014b"+
		"\u012d\3\2\2\2\u014b\u0130\3\2\2\2\u014b\u0132\3\2\2\2\u014c\u0150\3\2"+
		"\2\2\u014d\u014f\5\32\16\2\u014e\u014d\3\2\2\2\u014f\u0152\3\2\2\2\u0150"+
		"\u014e\3\2\2\2\u0150\u0151\3\2\2\2\u0151\33\3\2\2\2\u0152\u0150\3\2\2"+
		"\2\u0153\u0154\7\65\2\2\u0154\35\3\2\2\2\u0155\u0156\7\t\2\2\u0156\37"+
		"\3\2\2\2\u0157\u0158\7\n\2\2\u0158!\3\2\2\2\63+-\679@IKUW[`nqy\u0085\u008c"+
		"\u0093\u0096\u0098\u009e\u00a6\u00ae\u00b4\u00b7\u00b9\u00be\u00c2\u00c5"+
		"\u00cd\u00d2\u00db\u00df\u00e3\u00e8\u00f5\u00fc\u0101\u0106\u010b\u010f"+
		"\u0113\u0120\u0123\u0128\u0137\u0141\u0145\u014b\u0150";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}