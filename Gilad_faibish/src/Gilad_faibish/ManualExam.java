package Gilad_faibish;

import java.io.FileNotFoundException;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Scanner;

public class ManualExam implements Examable {
	public static Scanner s1 = new Scanner(System.in);

	@Override
	public void createExam(DataBase db, int numOfQuestions, Statement stmt) throws FileNotFoundException, SQLException {
		boolean flag = true;
		boolean fcontinue = true;
		int counter = 0;
		int minAns;
		int userChoice;
		int qIndex; // question index
		Questions temp[] = new Questions[db.getNumOfQuestions()];

		LocalDateTime today = LocalDateTime.now();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy_MM_dd_hh_mm");
		StringBuffer exName = new StringBuffer("" + today.format(dtf) + ".txt");
		DataBase exam = new DataBase(exName.toString());

		for (int eIndex = 0; eIndex < numOfQuestions; eIndex++) {// eIndex = exam index
			do {
				counter = 0;
				flag = true;
				fcontinue = true;

				System.out.println("The questions that exist in the database and have answers are:");
				System.out.println("(The displayed questions have not yet been selected)\n");
				for (int j = 0; j < db.getNumOfQuestions(); j++) {
					if (!exam.isQExist(db.getQuestion(j))) {
						if (db.getQuestion(j) instanceof MultipleQuestion
								&& ((MultipleQuestion) db.getQuestion(j)).getNumOfQAnswers() > 0) {
							MultipleQuestion mq = (MultipleQuestion) db.getQuestion(j);
							temp[counter++] = mq;
							System.out.println(counter + ") " + mq.getQuestion());
							System.out.println("difficulty: " + mq.difficulty + " (multiple choice question with "
									+ mq.getNumOfQAnswers() + "answers.)\n");
						} else if (db.getQuestion(j) instanceof OpenQuestion) {
							temp[counter++] = db.getQuestion(j);
							System.out.println(counter + ") " + db.getQuestion(j).getQuestion());
							System.out.println("difficulty: " + db.getQuestion(j).difficulty + " (open question)\n");
						}
					}
				}
				System.out.println("\nPlease select the question number that you want to add.");
				System.out.println("(Multiple choice question must have at least 4 answers!)");
				userChoice = s1.nextInt();
				if (userChoice <= 0 || userChoice > counter) {
					System.out.println("Invalid answer , please try again.\n");
					flag = false;
				} else if (temp[userChoice - 1] instanceof MultipleQuestion) {
					MultipleQuestion mq = (MultipleQuestion) temp[userChoice - 1];
					try {
						if (mq.getNumOfQAnswers() < 4)
							throw new NotEnoughAnswersException();
					} catch (NotEnoughAnswersException e) {
						System.out.println(e.getMessage() + "\n");
						flag = false;
					}
				}

			} while (flag != true);

			qIndex = db.getQuestionIndex(temp[userChoice - 1].getQuestion());

			if (db.getQuestion(qIndex) instanceof MultipleQuestion) {
				Questions q = new MultipleQuestion(db.getQuestion(qIndex).getQuestion(),
						db.getQuestion(qIndex).difficulty);
				exam.addQuestion(q, 0, 0, stmt, !Program.uploadToDb);
				minAns = 0;
				while (minAns < 4) {
					flag = addAnsToQuestionForExam(exam, db, qIndex, eIndex, stmt);
					if (flag)
						minAns++;
				}

				if (flag) {
					while (fcontinue && ((MultipleQuestion) exam.getQuestion(eIndex))
							.getNumOfQAnswers() < ((MultipleQuestion) db.getQuestion(qIndex)).getNumOfQAnswers()) {
						System.out.println("Do you want to add more answers? (Y/N)");
						char ans = s1.next().charAt(0);

						if (ans == 'n' || ans == 'N') {
							fcontinue = false;
						} else if (ans == 'y' || ans == 'Y') {
							flag = addAnsToQuestionForExam(exam, db, qIndex, eIndex, stmt);
						} else {
							System.out.println("Invalid answer , please try again.");
						}
					}
					if (((MultipleQuestion) exam.getQuestion(eIndex))
							.getNumOfQAnswers() == ((MultipleQuestion) db.getQuestion(qIndex)).getNumOfQAnswers()) {
						System.out.println(
								"\nAll the answers to this question that are in the database are already in this test.\n");
					}
				}
			} else {
				Answers a = db.getQuestion(qIndex).getAnswer();
				Questions q = new OpenQuestion(db.getQuestion(qIndex).getQuestion(), db.getQuestion(qIndex).difficulty,
						a);
				exam.addQuestion(q, 0, 0, stmt, !Program.uploadToDb);
			}
		}
		exam.createExamFiles(exam, exName, 0, stmt, db.getSubject());

	}

	public boolean addAnsToQuestionForExam(DataBase exam, DataBase db, int qIndex, int eIndex, Statement stmt)
			throws SQLException {
		MultipleQuestion mq = (MultipleQuestion) db.getQuestion(qIndex);
		MultipleQuestion eq = (MultipleQuestion) exam.getQuestion(eIndex);
		int aIndex; // answer index
		int answer;
		int counter = 0;
		int aLen = mq.getNumOfQAnswers(); // answer length
		boolean res = true;
		boolean fContinue = true;
		Answers[] temp = new Answers[db.getNumOfAnswers()];

		System.out.println("\nYour question is: " + mq.getQuestion());
		System.out.println("The answers to the question that do not appear in the exam are:");

		for (int i = 0; i < aLen; i++) {
			if (!eq.isAExist(mq.getQAnswer(i).getQAnswer())) {
				temp[counter++] = db.getAnswer(i);
				System.out.println(counter + ") " + mq.getQAnswer(i));
			}
		}
		do {
			res = true;
			System.out.println("Please select the answer number that you want to add.");
			s1.nextLine();
			answer = s1.nextInt();
			if (answer <= 0 || answer > counter) {
				System.out.println("Invalid answer , please try again.");
				res = false;
			}
			if (res) {
				fContinue = false;
				aIndex = db.getAnswerIndex(temp[answer - 1].getAnswer());
				QuestionAnswer qa = mq.getQAnswer(aIndex);
				res = eq.addAnswerToQuestion(qa.getQAnswer(), qa.getIsCorrect(), 0, 0, stmt, !Program.uploadToDb);
			}

		} while (fContinue);

		return res;
	}

}