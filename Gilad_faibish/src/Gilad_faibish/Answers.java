package Gilad_faibish;

import java.io.Serializable;

@SuppressWarnings("serial")
public class Answers implements Serializable{
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
