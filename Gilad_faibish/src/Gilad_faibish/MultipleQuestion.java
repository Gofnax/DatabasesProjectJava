package Gilad_faibish;

import java.io.Serializable;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Arrays;

@SuppressWarnings("serial")
public class MultipleQuestion extends Questions implements Serializable {
	private QuestionAnswer[] allQAnswers;
	private int numOfQAnswers;
	private final int MAX_ANSWERS = 10;

	public MultipleQuestion(String question, eDifficulty difficulty) {
		super(question, difficulty);
		allQAnswers = new QuestionAnswer[MAX_ANSWERS];
		numOfQAnswers = 0;
	}

	public boolean isQAExist(QuestionAnswer qa) { // is question exist
		for (int i = 0; i < numOfQAnswers; i++) {
			if (allQAnswers[i].getQAnswer().getAnswer().equalsIgnoreCase(qa.getQAnswer().getAnswer()))
				return true;
		}
		return false;
	}

	public boolean isAExist(Answers a) {// is answer exist
		for (int i = 0; i < numOfQAnswers; i++) {
			if (allQAnswers[i].getQAnswer().getAnswer().equalsIgnoreCase(a.getAnswer()))
				return true;
		}
		return false;
	}

	public boolean addAnswerToQuestion(Answers a, boolean iscorrect, int answerid, int questionid, Statement stmt, int type)
			throws SQLException {
		QuestionAnswer qa = new QuestionAnswer(a, iscorrect);

		if (isQAExist(qa))
			return false;

		if (numOfQAnswers < MAX_ANSWERS) {
			this.allQAnswers[numOfQAnswers++] = qa;
			if(type == 1)
				stmt.executeUpdate(
						"INSERT INTO mquestion_answertb VALUES (" + questionid + ", " + answerid + ", " + iscorrect + ");");
			return true;
		} else
			return false;
	}

	public boolean removeAnswerToQuestion(int index, int answerid, int questionid, Statement stmt) throws SQLException {
		if (index >= this.numOfQAnswers || index < 0)
			return false;

		this.allQAnswers[index] = this.allQAnswers[numOfQAnswers - 1];
		this.allQAnswers[--numOfQAnswers] = null;
		stmt.executeUpdate("DELETE FROM mquestion_answertb WHERE mquestionid = " + questionid + " AND answerid = "
				+ answerid + ";");
		return true;
	}

	public QuestionAnswer[] getAllQAnswers() {// get all question answers
		return allQAnswers;
	}

	public int getNumOfQAnswers() { // get number of question answers
		return numOfQAnswers;
	}

	public QuestionAnswer getQAnswer(int index) { // get question answer
		return allQAnswers[index];
	}

	public int getNumOfCcorectA() {
		int counter = 0;
		for (int i = 0; i < numOfQAnswers; i++) {
			if (allQAnswers[i].getIsCorrect())
				counter++;
		}
		return counter;
	}

	@Override
	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}

	@Override
	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb.append(question + "\n");
		for (int i = 0; i < numOfQAnswers; i++) {
			sb.append((i + 1) + ") " + allQAnswers[i].toString() + "\n");
		}
		return sb.toString();
	}

	@Override
	public boolean equals(Object obj) {
		if (!(obj instanceof MultipleQuestion)) {
			return false;
		}
		if (!(super.equals(obj))) {
			return false;
		}

		MultipleQuestion temp = (MultipleQuestion) obj;
		return (Arrays.equals(this.allQAnswers, temp.allQAnswers));
	}

}
