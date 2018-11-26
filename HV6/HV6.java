import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.File;

public class HV6 {
	public static void main(String[] args) throws Exception {
		// create a CharStream that reads from standard input
		// ANTLRInputStream input = new ANTLRInputStream(System.in);
		// input depuis un fichier en argument
		
		// compilation fsh to hmd
		
		String inputFile = null;
		if( args.length>0 ) inputFile = args[0];
			InputStream	is = System.in;
		if( inputFile!=null ) 
				is = new FileInputStream(inputFile);
		ANTLRInputStream input = new ANTLRInputStream(is);

		// create a lexer that feeds off of input CharStream
		HasmLexer lexer = new HasmLexer(input);
		// create a buffer of tokens pulled from the lexer
		CommonTokenStream tokens = new CommonTokenStream(lexer);
		// create a parser that feeds off the tokens buffer
		HasmParser parser = new HasmParser(tokens);
		ParseTree tree = parser.root(); // begin parsing at init rule
		// System.out.println(tree.toStringTree(parser)); // print LISP-style tree
		
		// rename homade.hmd  en xxx.hmd
		File ancien_nom = new File("homade.hmd");
		String nom = inputFile;
		int i = nom.lastIndexOf (".");
		if ( i != -1 )
		{
			nom = nom.substring (0, i);
		}
		nom += ".hmd";
		File nouveau_nom = new File(nom);
		nouveau_nom.delete();
		if (ancien_nom.renameTo(nouveau_nom))
		{
			System.out.println("File "+nom+" created");
		}else{
			System.out.println("ERROR : impossible to create "+  nom);
		}
		// rename homade.isim  en xxx.ism
		File ancien_nom2 = new File("Homade.isim");
		nom = inputFile;
		i = nom.lastIndexOf (".");
		if ( i != -1 )
		{
			nom = nom.substring (0, i);
		}
		nom += ".isim";
		File nouveau_nom2 = new File(nom);
		nouveau_nom2.delete();
		if (ancien_nom2.renameTo(nouveau_nom2))
		{
			System.out.println("File "+nom+" created");
		}else{
			System.out.println("ERROR : impossible to create "+  nom);
		}
		
		// compilation IP to vhd
				
		String inputFilebis = null;
		if( args.length>0 ) inputFilebis = args[0];
			InputStream	isbis = System.in;
		if( inputFile!=null ) 
				isbis = new FileInputStream(inputFile);
		ANTLRInputStream inputbis = new ANTLRInputStream(isbis);

		// create a lexer that feeds off of input CharStream
		H2VLexer lexerbis = new H2VLexer(inputbis);
		// create a buffer of tokens pulled from the lexer
		CommonTokenStream tokensbis = new CommonTokenStream(lexerbis);
		// create a parser that feeds off the tokens buffer
		H2VParser parserbis = new H2VParser(tokensbis);
		ParseTree treebis = parserbis.root(); // begin parsing at init rule
		// System.out.println(tree.toStringTree(parser)); // print LISP-style tree
		
		// rename homade.vhd  en xxx.vhd
		File ancien_nombis = new File("Homade.vhd");
		String nombis = inputFile;
		i = nombis.lastIndexOf (".");
		if ( i != -1 )
		{
			nombis = nombis.substring (0, i);
		}
		nombis += ".vhd";
		File nouveau_nombis = new File(nombis);
		nouveau_nombis.delete();
		if (ancien_nombis.renameTo(nouveau_nombis))
		{
			System.out.println("File "+nombis+" created");
		}else{
			System.out.println("ERROR : impossible to create "+  nom);
		}

	}
}

