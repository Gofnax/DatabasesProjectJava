package Gilad_faibish;

public class Answers{
	private String answer;

	public Answers(String answer) {
		this.setAnswer(answer);
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public String toString() {
		return answer;
	}
	
	@Override
	public boolean equals(Object obj) {
		if (!(obj instanceof Answers)) {
			return false;
		}
		Answers temp = (Answers) obj;
		return (this.answer.equals(temp.answer));
	}

}
