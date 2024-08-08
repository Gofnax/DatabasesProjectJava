package Gilad_faibish;

import java.io.Serializable;

@SuppressWarnings("serial")
public abstract class Questions implements Serializable{
	protected String question;
	protected static int counter;
	protected int serialNum;

	public enum eDifficulty {
		Easy, Regular, Hard
	};

	protected eDifficulty difficulty;

	public Questions(String question, eDifficulty difficulty) {
		this.question = question;
		this.difficulty = difficulty;
		serialNum = ++counter;
	}

	public int setSerialNum(int num) {
		this.serialNum = num;
		return this.serialNum;
	}

	public static void setCounter(int numOfQuestions) {
		counter = numOfQuestions;
	}

	public String getQuestion() {
		return question;
	}

	public Answers getAnswer() {
		return this.getAnswer();
	}

	public String toString() {
		return question;
	}

	@Override
	public boolean equals(Object obj) {
		if (!(obj instanceof Questions)) {
			return false;
		}
		Questions temp = (Questions) obj;
		return ((this.question.equals(temp.question)) && (this.difficulty == temp.difficulty)
				&& (this.serialNum == temp.serialNum));
	}

}
