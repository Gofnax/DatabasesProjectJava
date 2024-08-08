package Gilad_faibish;

@SuppressWarnings("serial")
public class TooManyQuestionException extends Exception {
	public TooManyQuestionException() {
		super("The exam can have 1-10 questions.");
	}

}
