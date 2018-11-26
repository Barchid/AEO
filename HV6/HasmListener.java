// Generated from Hasm.g4 by ANTLR 4.5


import java.util.*;	
import java.io.*;


import org.antlr.v4.runtime.misc.NotNull;
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link HasmParser}.
 */
public interface HasmListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link HasmParser#ipName}.
	 * @param ctx the parse tree
	 */
	void enterIpName(HasmParser.IpNameContext ctx);
	/**
	 * Exit a parse tree produced by {@link HasmParser#ipName}.
	 * @param ctx the parse tree
	 */
	void exitIpName(HasmParser.IpNameContext ctx);
	/**
	 * Enter a parse tree produced by {@link HasmParser#root}.
	 * @param ctx the parse tree
	 */
	void enterRoot(HasmParser.RootContext ctx);
	/**
	 * Exit a parse tree produced by {@link HasmParser#root}.
	 * @param ctx the parse tree
	 */
	void exitRoot(HasmParser.RootContext ctx);
	/**
	 * Enter a parse tree produced by {@link HasmParser#iPDeclare}.
	 * @param ctx the parse tree
	 */
	void enterIPDeclare(HasmParser.IPDeclareContext ctx);
	/**
	 * Exit a parse tree produced by {@link HasmParser#iPDeclare}.
	 * @param ctx the parse tree
	 */
	void exitIPDeclare(HasmParser.IPDeclareContext ctx);
	/**
	 * Enter a parse tree produced by {@link HasmParser#pcDeclare}.
	 * @param ctx the parse tree
	 */
	void enterPcDeclare(HasmParser.PcDeclareContext ctx);
	/**
	 * Exit a parse tree produced by {@link HasmParser#pcDeclare}.
	 * @param ctx the parse tree
	 */
	void exitPcDeclare(HasmParser.PcDeclareContext ctx);
	/**
	 * Enter a parse tree produced by {@link HasmParser#vcDeclare}.
	 * @param ctx the parse tree
	 */
	void enterVcDeclare(HasmParser.VcDeclareContext ctx);
	/**
	 * Exit a parse tree produced by {@link HasmParser#vcDeclare}.
	 * @param ctx the parse tree
	 */
	void exitVcDeclare(HasmParser.VcDeclareContext ctx);
	/**
	 * Enter a parse tree produced by {@link HasmParser#vcpcvalue}.
	 * @param ctx the parse tree
	 */
	void enterVcpcvalue(HasmParser.VcpcvalueContext ctx);
	/**
	 * Exit a parse tree produced by {@link HasmParser#vcpcvalue}.
	 * @param ctx the parse tree
	 */
	void exitVcpcvalue(HasmParser.VcpcvalueContext ctx);
	/**
	 * Enter a parse tree produced by {@link HasmParser#iPextend}.
	 * @param ctx the parse tree
	 */
	void enterIPextend(HasmParser.IPextendContext ctx);
	/**
	 * Exit a parse tree produced by {@link HasmParser#iPextend}.
	 * @param ctx the parse tree
	 */
	void exitIPextend(HasmParser.IPextendContext ctx);
	/**
	 * Enter a parse tree produced by {@link HasmParser#wordDeclare}.
	 * @param ctx the parse tree
	 */
	void enterWordDeclare(HasmParser.WordDeclareContext ctx);
	/**
	 * Exit a parse tree produced by {@link HasmParser#wordDeclare}.
	 * @param ctx the parse tree
	 */
	void exitWordDeclare(HasmParser.WordDeclareContext ctx);
	/**
	 * Enter a parse tree produced by {@link HasmParser#staticDeclare}.
	 * @param ctx the parse tree
	 */
	void enterStaticDeclare(HasmParser.StaticDeclareContext ctx);
	/**
	 * Exit a parse tree produced by {@link HasmParser#staticDeclare}.
	 * @param ctx the parse tree
	 */
	void exitStaticDeclare(HasmParser.StaticDeclareContext ctx);
	/**
	 * Enter a parse tree produced by {@link HasmParser#literal}.
	 * @param ctx the parse tree
	 */
	void enterLiteral(HasmParser.LiteralContext ctx);
	/**
	 * Exit a parse tree produced by {@link HasmParser#literal}.
	 * @param ctx the parse tree
	 */
	void exitLiteral(HasmParser.LiteralContext ctx);
	/**
	 * Enter a parse tree produced by {@link HasmParser#word16}.
	 * @param ctx the parse tree
	 */
	void enterWord16(HasmParser.Word16Context ctx);
	/**
	 * Exit a parse tree produced by {@link HasmParser#word16}.
	 * @param ctx the parse tree
	 */
	void exitWord16(HasmParser.Word16Context ctx);
	/**
	 * Enter a parse tree produced by {@link HasmParser#homadeCode}.
	 * @param ctx the parse tree
	 */
	void enterHomadeCode(HasmParser.HomadeCodeContext ctx);
	/**
	 * Exit a parse tree produced by {@link HasmParser#homadeCode}.
	 * @param ctx the parse tree
	 */
	void exitHomadeCode(HasmParser.HomadeCodeContext ctx);
	/**
	 * Enter a parse tree produced by {@link HasmParser#homadeCodeIP}.
	 * @param ctx the parse tree
	 */
	void enterHomadeCodeIP(HasmParser.HomadeCodeIPContext ctx);
	/**
	 * Exit a parse tree produced by {@link HasmParser#homadeCodeIP}.
	 * @param ctx the parse tree
	 */
	void exitHomadeCodeIP(HasmParser.HomadeCodeIPContext ctx);
	/**
	 * Enter a parse tree produced by {@link HasmParser#vcpcName}.
	 * @param ctx the parse tree
	 */
	void enterVcpcName(HasmParser.VcpcNameContext ctx);
	/**
	 * Exit a parse tree produced by {@link HasmParser#vcpcName}.
	 * @param ctx the parse tree
	 */
	void exitVcpcName(HasmParser.VcpcNameContext ctx);
	/**
	 * Enter a parse tree produced by {@link HasmParser#ret}.
	 * @param ctx the parse tree
	 */
	void enterRet(HasmParser.RetContext ctx);
	/**
	 * Exit a parse tree produced by {@link HasmParser#ret}.
	 * @param ctx the parse tree
	 */
	void exitRet(HasmParser.RetContext ctx);
	/**
	 * Enter a parse tree produced by {@link HasmParser#halt}.
	 * @param ctx the parse tree
	 */
	void enterHalt(HasmParser.HaltContext ctx);
	/**
	 * Exit a parse tree produced by {@link HasmParser#halt}.
	 * @param ctx the parse tree
	 */
	void exitHalt(HasmParser.HaltContext ctx);
}