package Gilad_faibish;

import java.io.FileNotFoundException;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Random;

public class AutomaticExam implements Examable {

	@Override
	public void createExam(DataBase db, int numOfQuestions, Statement stmt) throws FileNotFoundException, SQLException {
		Random r = new Random();
		boolean flag = true;
		int trueCounter;
		boolean isCorrect;
		int ans;
		int counter = 0;
		int qIndex; // question index
		Questions temp[] = new Questions[db.getNumOfQuestions()];

		LocalDateTime today = LocalDateTime.now();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy_MM_dd_hh_mm");
		StringBuffer exName = new StringBuffer("" + today.format(dtf) + ".txt");
		DataBase exam = new DataBase(exName.toString());

		for (int i = 0; i < db.getNumOfQuestions(); i++) {
			if (!exam.isQExist(db.getQuestion(i))) {
				if (db.getQuestion(i) instanceof MultipleQuestion
						&& ((MultipleQuestion) db.getQuestion(i)).getNumOfQAnswers() > 0) {
					MultipleQuestion mq = (MultipleQuestion) db.getQuestion(i);
					trueCounter = 0;
					for (int j = 0; j < mq.getNumOfQAnswers(); j++) {
						isCorrect = mq.getAllQAnswers()[j].getIsCorrect();
						if (isCorrect)
							trueCounter++;
					}
					if (trueCounter <= 1)
						temp[counter++] = mq;
				} else if (db.getQuestion(i) instanceof OpenQuestion) {
					temp[counter++] = db.getQuestion(i);
				}
			}
		}

		for (int eIndex = 0; eIndex < numOfQuestions; eIndex++) {
			do {
				flag = true;
				ans = r.nextInt(counter);
				if (temp[ans] instanceof MultipleQuestion) {
					MultipleQuestion mq = (MultipleQuestion) temp[ans];
					try {
						if (mq.getNumOfQAnswers() < 4) {
							throw new NotEnoughAnswersException();
						}
					} catch (NotEnoughAnswersException e) {
						temp[ans] = temp[counter - 1];
						temp[counter - 1] = null;
						counter--;
						flag = false;
					}
				}
			} while (!flag);

			qIndex = db.getQuestionIndex(temp[ans].getQuestion());

			if (db.getQuestion(qIndex) instanceof MultipleQuestion) {
				Questions q = new MultipleQuestion(db.getQuestion(qIndex).getQuestion(),
						db.getQuestion(qIndex).difficulty);
				exam.addQuestion(q, 0, 0, stmt, !Program.uploadToDb);
				addAnsToQuestionForExam(exam, db, qIndex, eIndex, stmt);
			} else {
				Answers a = db.getQuestion(qIndex).getAnswer();
				Questions q = new OpenQuestion(db.getQuestion(qIndex).getQuestion(), db.getQuestion(qIndex).difficulty,
						a);
				exam.addQuestion(q, 0, 0, stmt, !Program.uploadToDb);
			}
			temp[ans] = temp[counter - 1];
			temp[counter - 1] = null;
			counter--;
		}
		exam.createExamFiles(exam, exName, 1, stmt, db.getSubject());

	}

	public void addAnsToQuestionForExam(DataBase exam, DataBase db, int qIndex, int eIndex, Statement stmt)
			throws SQLException {
		MultipleQuestion mq = (MultipleQuestion) db.getQuestion(qIndex);
		MultipleQuestion eq = (MultipleQuestion) exam.getQuestion(eIndex);
		Random r = new Random();
		int aIndex; // answer index
		int answer;
		int counter = 0;
		int aLen = mq.getNumOfQAnswers(); // answer length
		Answers[] temp = new Answers[db.getNumOfAnswers()];

		for (int i = 0; i < aLen; i++) {
			if (!eq.isAExist(mq.getQAnswer(i).getQAnswer())) {
				temp[counter++] = db.getAnswer(i);
			}
		}
		for (int j = 0; j < 4; j++) {
			answer = r.nextInt(counter);
			aIndex = db.getAnswerIndex(temp[answer].getAnswer());
			QuestionAnswer qa = mq.getQAnswer(aIndex);
			eq.addAnswerToQuestion(qa.getQAnswer(), qa.getIsCorrect(), 0, 0, stmt, !Program.uploadToDb);
			temp[answer] = temp[counter - 1];
			temp[counter - 1] = null;
			counter--;
		}

	}

}