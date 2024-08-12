package Gilad_faibish;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.io.Serializable;
import java.sql.*;
import java.util.Arrays;

@SuppressWarnings("serial")
public class DataBase implements Serializable {
	private String subject;
	private Questions[] allQuestions;
	private int numOfQuestions;

	private Answers[] allAnswers;
	private int numOfAnswers;

	private int qLength = 5; // question length
	private int aLength = 5; // answer length

	public DataBase(String subject) {
		this.subject = subject;
		allQuestions = new Questions[qLength];
		allAnswers = new Answers[aLength];
		numOfQuestions = 0;
		numOfAnswers = 0;
	}

	public String getSubject() {
		return this.subject;
	}

	public Questions[] getAllQuestions() {
		return allQuestions;
	}

	public int getNumOfGoodQuestions() {
		int counter = 0;

		for (int i = 0; i < numOfQuestions; i++) {
			if (allQuestions[i] instanceof MultipleQuestion) {
				MultipleQuestion mq = (MultipleQuestion) allQuestions[i];
				if (mq.getNumOfQAnswers() >= 4 && mq.getNumOfCcorectA() <= 1) {
					counter++;
				}
			} else if (allQuestions[i] instanceof OpenQuestion) {
				counter++;
			}
		}

		return counter;
	}

	public Questions getQuestion(int index) {
		return allQuestions[index];
	}

	public int getQuestionIndex(String q) {
		for (int i = 0; i < numOfQuestions; i++) {
			if (allQuestions[i].getQuestion().equalsIgnoreCase(q))
				return i;
		}
		return -1;
	}

	public int getAnswerIndex(String a) {
		for (int i = 0; i < numOfAnswers; i++) {
			if (allAnswers[i].getAnswer().equalsIgnoreCase(a))
				return i;
		}
		return -1;
	}

	public boolean isQExist(Questions question) { // is question exist
		for (int i = 0; i < numOfQuestions; i++) {
			if (allQuestions[i].getQuestion().equalsIgnoreCase(question.getQuestion()))
				return true;
		}
		return false;
	}

	public boolean addQuestion(Questions question, int subjectid, int answerid, Statement stmt, boolean type)
			throws SQLException {
		if (isQExist(question)) {
			return false;
		}

		if (this.numOfQuestions == qLength) {
			allQuestions = Arrays.copyOf(allQuestions, allQuestions.length * 2);
			qLength = allQuestions.length;
		}

		allQuestions[numOfQuestions++] = question;
		if (question instanceof MultipleQuestion && type)
			stmt.executeUpdate("INSERT INTO mquestiontb VALUES (default, " + subjectid + ", '" + question.getQuestion()
					+ "', " + question.difficulty.ordinal() + ");");

		if (question instanceof OpenQuestion && type)
			stmt.executeUpdate("INSERT INTO oquestiontb VALUES (default, " + subjectid + ", " + answerid + ", '"
					+ question.getQuestion() + "', " + question.difficulty.ordinal() + ");");

		return true;
	}

	public boolean removeQuestion(int index, int questionid, Statement stmt) {
		if (index >= this.numOfQuestions || index < 0)
			return false;

		this.allQuestions[index] = this.allQuestions[numOfQuestions - 1];
		this.allQuestions[--numOfQuestions] = null;
		return true;

	}

	public int getNumOfQuestions() {
		return this.numOfQuestions;
	}

	public int getNumOfMQuestions() {
		int counter = 0;

		for (int i = 0; i < allQuestions.length; i++) {
			if (allQuestions[i] instanceof MultipleQuestion) {
				counter++;
			}
		}

		return counter;
	}

	public int getNumOfAnswers() {
		return this.numOfAnswers;
	}

	public Answers getAnswer(int index) {
		return this.allAnswers[index];
	}

	public boolean isAExist(Answers a) { // is answer exist
		for (int i = 0; i < numOfAnswers; i++) {
			if (allAnswers[i].getAnswer().equalsIgnoreCase(a.getAnswer()))
				return true;
		}
		return false;
	}

	public boolean addAnswer(Answers a) {
		if (this.isAExist(a)) {
			return false;
		}

		if (numOfAnswers == aLength) {
			allAnswers = Arrays.copyOf(allAnswers, allAnswers.length * 2);
			aLength = allAnswers.length;
		}

		allAnswers[numOfAnswers++] = a;
		return true;
	}

	public boolean addAnswerWithDB(Answers a, Statement stmt) throws SQLException {
		if (this.isAExist(a)) {
			return false;
		}

		if (numOfAnswers == aLength) {
			allAnswers = Arrays.copyOf(allAnswers, allAnswers.length * 2);
			aLength = allAnswers.length;
		}

		allAnswers[numOfAnswers++] = a;
		ResultSet rs = stmt.executeQuery("SELECT subjectid FROM subjecttb WHERE subject = '" + this.subject + "';");
		rs.next();
		int subjectid = rs.getInt("subjectid");
		stmt.executeUpdate("INSERT INTO answertb VALUES (default, " + subjectid + ", '" + a.getAnswer() + "');");
		return true;
	}

	@Override
	public String toString() {
		StringBuffer sb = new StringBuffer("All the questions with their answers are:\n\n");

		for (int i = 0; i < numOfQuestions; i++) {
			sb.append(i + 1).append(") ").append(allQuestions[i].getQuestion()).append("\n   serial number: ")
					.append(allQuestions[i].serialNum).append(" | difficulty level: ")
					.append(allQuestions[i].difficulty);
			if (allQuestions[i] instanceof MultipleQuestion) {
				MultipleQuestion mq = (MultipleQuestion) allQuestions[i];
				sb.append("\n\n").append("Answers:\n");
				for (int j = 0; j < mq.getNumOfQAnswers(); j++) {
					sb.append(j + 1).append(") ").append(mq.getAllQAnswers()[j]).append("\n");
				}
			} else if (allQuestions[i] instanceof OpenQuestion) {
				sb.append("\n\n").append("Answer:\n").append(allQuestions[i].toString()).append("\n");
			}
			sb.append("\n");
		}
		if (this.numOfQuestions == 0)
			sb.append("There are no questions in the database yet.\n\n");

		return sb.toString();
	}

	public String ansToString() {
		StringBuffer sb = new StringBuffer("The answers that exist in the database are:\n\n");

		for (int i = 0; i < numOfAnswers; i++) {
			sb.append(i + 1).append(") ").append(allAnswers[i].getAnswer()).append("\n");
		}
		return sb.toString();

	}

	public String questionToString() {
		StringBuffer sb = new StringBuffer("The questions that exist in the database are:\n\n");

		for (int i = 0; i < numOfQuestions; i++) {
			sb.append(i + 1).append(") ").append(allQuestions[i].getQuestion()).append("\n");
		}
		return sb.toString();

	}

	public String examToString(int exType) {// exType = exam type (auto\manual).
		StringBuffer sb = new StringBuffer("Questions:\n");
		for (int i = 0; i < numOfQuestions; i++) {
			sb.append("\n").append((i + 1) + ") " + allQuestions[i].getQuestion()).append("\n   serial number: ")
					.append(allQuestions[i].serialNum).append(" | difficulty level: ")
					.append(allQuestions[i].difficulty).append("\n");
			if (allQuestions[i] instanceof MultipleQuestion) {
				MultipleQuestion mq = (MultipleQuestion) allQuestions[i];
				sb.append("\n").append("Answers:\n\n");
				for (int j = 0; j < mq.getNumOfQAnswers(); j++) {
					sb.append((j + 1) + ") " + mq.getQAnswer(j).getQAnswer().getAnswer() + "\n");
				}
				sb.append((mq.getNumOfQAnswers() + 1) + ") None of the above\n");
				if (exType == 0)
					sb.append((mq.getNumOfQAnswers() + 2) + ") More than one answer is correct\n");
			}
		}
		sb.append("\n");
		return sb.toString();
	}

	public String solutionToString() {
		Answers correctAnswer = new Answers("More than one answer is correct");
		int tCounter = 0, corrcetNum = 0; // tCounter = true counter
		StringBuffer sb = new StringBuffer("Solutions:\n");
		for (int i = 0; i < numOfQuestions; i++) {
			sb.append("\n" + (i + 1) + ") " + allQuestions[i].getQuestion() + "\n");
			if (allQuestions[i] instanceof MultipleQuestion) {
				MultipleQuestion mq = (MultipleQuestion) allQuestions[i];
				tCounter = 0;
				corrcetNum = 0;
				for (int j = 0; j < mq.getNumOfQAnswers(); j++) {
					if (mq.getQAnswer(j).getIsCorrect()) {
						tCounter++;
						correctAnswer = mq.getQAnswer(j).getQAnswer();
						corrcetNum = j;
					}
				}
				corrcetNum++;
				sb.append("\nThe correct answer is:\n");
				if (tCounter == 0) {
					correctAnswer = new Answers("None of the above");
					corrcetNum = mq.getNumOfQAnswers() + 2;
				}

				else if (tCounter > 1) {
					correctAnswer = new Answers("More than one answer is correct");
					corrcetNum = mq.getNumOfQAnswers() + 1;
				}
				sb.append(corrcetNum + ") " + correctAnswer.getAnswer() + "\n");
			} else {
				sb.append("\nThe school answer is:\n" + allQuestions[i].getAnswer().getAnswer() + "\n");
			}
		}

		return sb.toString();
	}

	public void createExamFiles(DataBase exam, StringBuffer exName, int exType, Statement stmt, String subject)
			throws FileNotFoundException, SQLException {
		// exType = exam type (auto\manual).

		File ex = new File("exam_" + exName.toString());
		File so = new File("solution_" + exName.toString());
		PrintWriter pw = new PrintWriter(ex);
		PrintWriter pw1 = new PrintWriter(so);
		String examString = exam.examToString(exType);
		String solutionString = exam.solutionToString();
		pw.print(examString);
		pw1.print(solutionString);
		pw.close();
		pw1.close();

		ResultSet rs1 = stmt.executeQuery("SELECT subjectid FROM subjecttb WHERE subject = '" + subject + "';");
		rs1.next();
		int subjectid = rs1.getInt("subjectid");

		stmt.executeUpdate("INSERT INTO examtb VALUES (default, " + subjectid + ", '" + exName + "', '" + examString
				+ "', '" + solutionString + "');");
	}

	@Override
	public boolean equals(Object obj) {
		if (!(obj instanceof DataBase)) {
			return false;
		}

		DataBase temp = (DataBase) obj;
		return (this.subject.equals(temp.subject) && (Arrays.equals(this.allAnswers, temp.allAnswers))
				&& (Arrays.equals(this.allQuestions, temp.allQuestions)));
	}
}
