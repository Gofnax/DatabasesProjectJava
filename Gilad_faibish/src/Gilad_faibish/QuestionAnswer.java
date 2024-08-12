package Gilad_faibish;

public class QuestionAnswer {
	private Answers answer;
	private boolean isCorrect;

	public QuestionAnswer(Answers answer, boolean isCorrect) {
		this.setAnswer(answer);
		this.setIsCorrect(isCorrect);
	}

	public Answers getQAnswer() { // get question answer
		return answer;
	}

	public boolean getIsCorrect() {
		return isCorrect;
	}

	public void setAnswer(Answers answer) {
		this.answer = answer;
	}

	public void setIsCorrect(boolean isCorrect) {
		this.isCorrect = isCorrect;
	}

	public String toString() {
		return answer + " is " + isCorrect;
	}

	@Override
	public boolean equals(Object obj) {
		if (!(obj instanceof QuestionAnswer)) {
			return false;
		}
		QuestionAnswer temp = (QuestionAnswer) obj;
		return ((this.answer.equals(temp.answer)) && (this.isCorrect == temp.isCorrect));
	}

}
