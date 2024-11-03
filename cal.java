import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.misc.ParseCancellationException;

import java.io.FileInputStream;
import java.io.InputStream;

public class cal {
    public static void main(String[] args) throws Exception{
        String inputFile = null;
		if (args.length > 0)
			inputFile = args[0];
		InputStream is = System.in;
		if (inputFile != null)
			is = new FileInputStream (inputFile);

        calLexer lexer = new calLexer(CharStreams.fromStream (is));
		CommonTokenStream tokens = new CommonTokenStream (lexer);

		calParser parser = new calParser (tokens);
		// Remove default error listeners
		parser.removeErrorListeners();
		// Add custom error listener
		parser.addErrorListener(new CustomErrorListener(inputFile));

		try {
			ParseTree tree = parser.program ();
			System.out.println(inputFile + " parsed successfully");
		} catch (ParseCancellationException e) {
			System.err.println(e.getMessage());
		}
    }
}

// Custom Error Listener for throwing error messages
class CustomErrorListener extends BaseErrorListener {
	String fileName;

	public CustomErrorListener(String fileName) {
		this.fileName = fileName;
	}

	@Override
	public void syntaxError(Recognizer<?, ?> recognizer, Object offendingSymbol, int line, int charPositionInLine, String msg, RecognitionException e) throws ParseCancellationException {
		throw new ParseCancellationException(fileName + " has not parsed");
	}
}

/*Resources used:

CSC1098 Loop resources

ParseCancellationException
https://www.antlr.org/api/Java/org/antlr/v4/runtime/misc/ParseCancellationException.html

ANTLRErrorListener (syntaxError)
https://www.antlr.org/api/Java/org/antlr/v4/runtime/ANTLRErrorListener.html
*/