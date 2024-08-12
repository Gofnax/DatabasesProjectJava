package Gilad_faibish;

public class OpenQuestion extends Questions{
	private Answers answer;

	public OpenQuestion(String question, eDifficulty difficulty, Answers answer) {
		super(question, difficulty);
		this.setAnswer(answer);

	}

	public void setAnswer(Answers answer) {
		this.answer = answer;
	}

	public Answers getAnswer() {
		return answer;
	}

	@Override
	public String toString() {
		return answer.toString();
	}

	@Override
	public boolean equals(Object obj) {
		if (!(obj instanceof OpenQuestion)) {
			return false;
		}
		if (!(super.equals(obj))) {
			return false;
		}

		OpenQuestion temp = (OpenQuestion) obj;
		return (this.answer == temp.answer);
	}

}
