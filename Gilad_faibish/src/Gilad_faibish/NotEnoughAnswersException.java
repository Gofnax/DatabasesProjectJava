package Gilad_faibish;

@SuppressWarnings("serial")
public class NotEnoughAnswersException extends Exception {
	public NotEnoughAnswersException() {
		super("You chose a question with less than 4 answers!");
	}

}
