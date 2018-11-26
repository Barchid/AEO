// Generated from H2V.g4 by ANTLR 4.5


import java.util.*;	
import java.io.*;


import org.antlr.v4.runtime.misc.NotNull;
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link H2VParser}.
 */
public interface H2VListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link H2VParser#ipName}.
	 * @param ctx the parse tree
	 */
	void enterIpName(H2VParser.IpNameContext ctx);
	/**
	 * Exit a parse tree produced by {@link H2VParser#ipName}.
	 * @param ctx the parse tree
	 */
	void exitIpName(H2VParser.IpNameContext ctx);
	/**
	 * Enter a parse tree produced by {@link H2VParser#root}.
	 * @param ctx the parse tree
	 */
	void enterRoot(H2VParser.RootContext ctx);
	/**
	 * Exit a parse tree produced by {@link H2VParser#root}.
	 * @param ctx the parse tree
	 */
	void exitRoot(H2VParser.RootContext ctx);
	/**
	 * Enter a parse tree produced by {@link H2VParser#iPDeclare}.
	 * @param ctx the parse tree
	 */
	void enterIPDeclare(H2VParser.IPDeclareContext ctx);
	/**
	 * Exit a parse tree produced by {@link H2VParser#iPDeclare}.
	 * @param ctx the parse tree
	 */
	void exitIPDeclare(H2VParser.IPDeclareContext ctx);
	/**
	 * Enter a parse tree produced by {@link H2VParser#pcDeclare}.
	 * @param ctx the parse tree
	 */
	void enterPcDeclare(H2VParser.PcDeclareContext ctx);
	/**
	 * Exit a parse tree produced by {@link H2VParser#pcDeclare}.
	 * @param ctx the parse tree
	 */
	void exitPcDeclare(H2VParser.PcDeclareContext ctx);
	/**
	 * Enter a parse tree produced by {@link H2VParser#vcDeclare}.
	 * @param ctx the parse tree
	 */
	void enterVcDeclare(H2VParser.VcDeclareContext ctx);
	/**
	 * Exit a parse tree produced by {@link H2VParser#vcDeclare}.
	 * @param ctx the parse tree
	 */
	void exitVcDeclare(H2VParser.VcDeclareContext ctx);
	/**
	 * Enter a parse tree produced by {@link H2VParser#vcpcvalue}.
	 * @param ctx the parse tree
	 */
	void enterVcpcvalue(H2VParser.VcpcvalueContext ctx);
	/**
	 * Exit a parse tree produced by {@link H2VParser#vcpcvalue}.
	 * @param ctx the parse tree
	 */
	void exitVcpcvalue(H2VParser.VcpcvalueContext ctx);
	/**
	 * Enter a parse tree produced by {@link H2VParser#iPextend}.
	 * @param ctx the parse tree
	 */
	void enterIPextend(H2VParser.IPextendContext ctx);
	/**
	 * Exit a parse tree produced by {@link H2VParser#iPextend}.
	 * @param ctx the parse tree
	 */
	void exitIPextend(H2VParser.IPextendContext ctx);
	/**
	 * Enter a parse tree produced by {@link H2VParser#wordDeclare}.
	 * @param ctx the parse tree
	 */
	void enterWordDeclare(H2VParser.WordDeclareContext ctx);
	/**
	 * Exit a parse tree produced by {@link H2VParser#wordDeclare}.
	 * @param ctx the parse tree
	 */
	void exitWordDeclare(H2VParser.WordDeclareContext ctx);
	/**
	 * Enter a parse tree produced by {@link H2VParser#staticDeclare}.
	 * @param ctx the parse tree
	 */
	void enterStaticDeclare(H2VParser.StaticDeclareContext ctx);
	/**
	 * Exit a parse tree produced by {@link H2VParser#staticDeclare}.
	 * @param ctx the parse tree
	 */
	void exitStaticDeclare(H2VParser.StaticDeclareContext ctx);
	/**
	 * Enter a parse tree produced by {@link H2VParser#literal}.
	 * @param ctx the parse tree
	 */
	void enterLiteral(H2VParser.LiteralContext ctx);
	/**
	 * Exit a parse tree produced by {@link H2VParser#literal}.
	 * @param ctx the parse tree
	 */
	void exitLiteral(H2VParser.LiteralContext ctx);
	/**
	 * Enter a parse tree produced by {@link H2VParser#word16}.
	 * @param ctx the parse tree
	 */
	void enterWord16(H2VParser.Word16Context ctx);
	/**
	 * Exit a parse tree produced by {@link H2VParser#word16}.
	 * @param ctx the parse tree
	 */
	void exitWord16(H2VParser.Word16Context ctx);
	/**
	 * Enter a parse tree produced by {@link H2VParser#homadeCode}.
	 * @param ctx the parse tree
	 */
	void enterHomadeCode(H2VParser.HomadeCodeContext ctx);
	/**
	 * Exit a parse tree produced by {@link H2VParser#homadeCode}.
	 * @param ctx the parse tree
	 */
	void exitHomadeCode(H2VParser.HomadeCodeContext ctx);
	/**
	 * Enter a parse tree produced by {@link H2VParser#homadeCodeIP}.
	 * @param ctx the parse tree
	 */
	void enterHomadeCodeIP(H2VParser.HomadeCodeIPContext ctx);
	/**
	 * Exit a parse tree produced by {@link H2VParser#homadeCodeIP}.
	 * @param ctx the parse tree
	 */
	void exitHomadeCodeIP(H2VParser.HomadeCodeIPContext ctx);
	/**
	 * Enter a parse tree produced by {@link H2VParser#vcpcName}.
	 * @param ctx the parse tree
	 */
	void enterVcpcName(H2VParser.VcpcNameContext ctx);
	/**
	 * Exit a parse tree produced by {@link H2VParser#vcpcName}.
	 * @param ctx the parse tree
	 */
	void exitVcpcName(H2VParser.VcpcNameContext ctx);
	/**
	 * Enter a parse tree produced by {@link H2VParser#ret}.
	 * @param ctx the parse tree
	 */
	void enterRet(H2VParser.RetContext ctx);
	/**
	 * Exit a parse tree produced by {@link H2VParser#ret}.
	 * @param ctx the parse tree
	 */
	void exitRet(H2VParser.RetContext ctx);
	/**
	 * Enter a parse tree produced by {@link H2VParser#halt}.
	 * @param ctx the parse tree
	 */
	void enterHalt(H2VParser.HaltContext ctx);
	/**
	 * Exit a parse tree produced by {@link H2VParser#halt}.
	 * @param ctx the parse tree
	 */
	void exitHalt(H2VParser.HaltContext ctx);
}