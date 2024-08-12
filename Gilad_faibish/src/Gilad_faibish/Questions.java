package Gilad_faibish;

public abstract class Questions {
	protected String question;

	public enum eDifficulty {
		Easy, Regular, Hard
	};

	protected eDifficulty difficulty;

	public Questions(String question, eDifficulty difficulty) {
		this.question = question;
		this.difficulty = difficulty;
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
		return ((this.question.equals(temp.question)) && (this.difficulty == temp.difficulty));
	}

}
