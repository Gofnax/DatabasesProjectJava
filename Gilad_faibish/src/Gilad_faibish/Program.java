package Gilad_faibish;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.InputMismatchException;
import java.util.Scanner;
import java.sql.*;
// emilio is gay
import Gilad_faibish.Questions.eDifficulty;

public class Program {
	private static Scanner s = new Scanner(System.in);
	public static final boolean uploadToDb = true;

	public static MultipleQuestion[] showMQuestions(DataBase db) {
		MultipleQuestion[] mq = new MultipleQuestion[db.getNumOfMQuestions()];
		int mqIndex = 0;

		for (int i = 0; i < db.getNumOfQuestions(); i++) {
			if (db.getAllQuestions()[i] instanceof MultipleQuestion) {
				System.out.println((mqIndex + 1) + ") " + db.getAllQuestions()[i].getQuestion());
				System.out.println("   difficuly level: " + db.getAllQuestions()[i].difficulty + "\n");
				mq[mqIndex++] = (MultipleQuestion) db.getAllQuestions()[i];
				for (int j = 0; j < mq[mqIndex - 1].getNumOfQAnswers(); j++) {
					System.out.println((j + 1) + ") " + mq[mqIndex - 1].getAllQAnswers()[j].toString());
				}
			}
			System.out.println();
		}
		return mq;
	}

	public static void printQuestionsFromDb(DataBase db) {
		System.out.println(db.toString());
	}
	
	public static String checkSQLInjection(String str) {
		boolean isSafe = false;
		do {
			if(str.contains("--") || str.contains(";") || str.contains("/*") || str.contains("*/")) {
				System.out.println("String entered contains illegal chararcters. Try again.");
				str = s.nextLine();
			} else {
				isSafe = true;
			}
		}while(!isSafe);
		return str;
	}

	public static boolean addAnswerToDb(DataBase db, Statement stmt) throws SQLException {
		System.out.println(db.ansToString());

		System.out.println("please write your answer: ");
		s.nextLine();
		String answer = s.nextLine();
		answer = checkSQLInjection(answer);

		Answers a = new Answers(answer);

		boolean res = db.addAnswerWithDB(a, stmt);

		if (res) {
			System.out.println("Answer successfully added.\n ");
			return true;
		} else
			System.out.println("The answer already exists in the database.\n ");
		return false;
	}

	public static boolean addAnswerToQuestion(DataBase db, Statement stmt) throws SQLException {
		int mqIndex; // multiple question index
		int qIndex; // question index
		int aIndex; // answer index
		boolean isCorrect;
		int maxAns = 10;
		int counter = 0;
		Answers temp[] = new Answers[db.getNumOfAnswers()];
		int aLen = db.getNumOfAnswers(); // answer length
		MultipleQuestion[] allMQuestions;

		System.out.println(
				"These are all the multiple choice questions with their answers that exist in the database:\n");
		allMQuestions = showMQuestions(db);

		System.out.println("Please select an question number.");
		mqIndex = s.nextInt();
		if (mqIndex > allMQuestions.length || mqIndex <= 0) {
			System.out.println("There is no question with this number.\n");
			return false;
		} else if (allMQuestions[mqIndex - 1].getNumOfQAnswers() >= maxAns) {
			System.out.println("There is no place to add more answers to this question.\n");
			return false;
		} else if (allMQuestions[mqIndex - 1].getNumOfQAnswers() >= db.getNumOfAnswers()) {
			System.out.println("The question you selected already has all the answers that exist in the database.\n");
			return false;
		}
		System.out.println("This is the question you select with her answers:\n");
		System.out.println(allMQuestions[mqIndex - 1].toString() + "\n");
		System.out.println("These are the answers that exist in the database and do not exist in the question:");

		for (int i = 0; i < aLen; i++) {
			if (!allMQuestions[mqIndex - 1].isAExist(db.getAnswer(i))) {
				temp[counter++] = db.getAnswer(i);
				System.out.println(counter + ") " + db.getAnswer(i).toString());
			}
		}

		System.out.println("Please select the answer number you wish to add.");
		aIndex = s.nextInt();
		if (aIndex > counter || aIndex <= 0) {
			System.out.println("There is no answer with this number.\n");
			return false;
		}
		System.out.println("Is the answer correct? (Y/N)");
		char ans = s.next().charAt(0);
		s.nextLine();

		if (ans == 'n' || ans == 'N') {
			isCorrect = false;
		} else if (ans != 'y' && ans != 'Y') {
			System.out.println("Invalid answer.\n");
			return false;
		} else
			isCorrect = true;

		qIndex = db.getQuestionIndex(allMQuestions[mqIndex - 1].getQuestion());

		if (db.getAllQuestions()[qIndex] instanceof MultipleQuestion) {
			MultipleQuestion mq = (MultipleQuestion) db.getAllQuestions()[qIndex];
			int subjectid = getSubjectId(db, stmt);
			int questionid = getQuestionId(mq, subjectid, stmt);
			int answerid = getAnswerId(temp[aIndex - 1].getAnswer(), stmt, subjectid);
			mq.addAnswerToQuestion(temp[aIndex - 1], isCorrect, answerid, questionid, stmt, uploadToDb);
			System.out.println("Answer successfully added.\n ");
		}
		return true;

	}

	public static boolean addQuestionToDb(DataBase db, Statement stmt) throws SQLException {
		eDifficulty difficulty = Questions.eDifficulty.Easy;
		int qType; // question type
		boolean flag;
		Questions q;

		System.out.println(db.questionToString());

		System.out.println("What type of question do you want to create?");
		System.out.println("(open question = 1 , multiple choice question = 2) ");
		qType = s.nextInt();
		if (qType < 1 || qType > 2) {
			System.out.println("Invalid input.\n");
			return false;
		} else if (qType == 1 && db.getNumOfAnswers() == 0) {
			System.out.println(
					"There are no answers in the database.\nIf you wish to create an open question, first add an answer to the database.\n");
			return false;
		}

		do {
			flag = true;
			try {
				System.out.println("What is the difficulty level of the question? (Easy/Regular/Hard)");
				difficulty = Questions.eDifficulty.valueOf(s.next());
			} catch (IllegalArgumentException e) {
				System.out.println("Invalid input , please try again.");
				flag = false;
				s.nextLine();
			} catch (Exception e) {
				System.out.println(e.getMessage());
				flag = false;
			}

		} while (flag != true);

		System.out.println("Please write your question: ");
		s.nextLine();
		String question = s.nextLine();
		question = checkSQLInjection(question);

		int ans = 0;
		if (qType == 1) {
			System.out.println(db.ansToString());
			System.out.println("Please select the answer number that you want to add.");
			ans = s.nextInt();
			if (ans < 1 || ans > db.getNumOfAnswers()) {
				System.out.println("Invalid Input.\n");
				return false;
			}
			q = new OpenQuestion(question, difficulty, db.getAnswer(ans - 1));
		} else {
			q = new MultipleQuestion(question, difficulty);
		}
		int subjectid = getSubjectId(db, stmt);
		int answerid = 0;
		if (q instanceof OpenQuestion)
			answerid = getAnswerId(db.getAnswer(ans - 1).getAnswer(), stmt, subjectid);

		boolean res = db.addQuestion(q, subjectid, answerid, stmt, uploadToDb);
		if (res) {
			System.out.println("Question successfully added.\n ");
			return true;
		} else
			System.out.println("The question already exists in the database.\n ");
		return false;
	}

	public static boolean deleteAnsToQuestionFromDb(DataBase db, Statement stmt) throws SQLException {
		int mqIndex; // Multiple choice question index
		int aIndex; // Answer index
		int qIndex; // Question index
		MultipleQuestion[] allMQuestions;

		if (db.getNumOfMQuestions() == 0) {
			System.out.println("There are no multiple choice questions in the database");
			return false;
		}

		System.out.println(
				"These are all the multiple choice questions with their answers that exist in the database:\n");
		allMQuestions = showMQuestions(db);

		System.out.println("Please select an question number.");
		mqIndex = s.nextInt();
		if (mqIndex > allMQuestions.length || mqIndex <= 0) {
			System.out.println("There is no question with this number.\n");
			return false;
		}
		if (allMQuestions[mqIndex - 1].getNumOfQAnswers() == 0) {
			System.out.println("The question you selected has no answers.\n");
			return false;
		}
		System.out.println("This is the question you select with her answers:\n");
		System.out.println(allMQuestions[mqIndex - 1].toString());

		System.out.println("Please select an answer number.");
		aIndex = s.nextInt();
		if (aIndex > allMQuestions[mqIndex - 1].getNumOfQAnswers() || aIndex <= 0) {
			System.out.println("There is no answer with this number.\n");
			return false;
		} else
			qIndex = db.getQuestionIndex(allMQuestions[mqIndex - 1].getQuestion());

		if (db.getAllQuestions()[qIndex] instanceof MultipleQuestion) {
			MultipleQuestion mq = (MultipleQuestion) db.getAllQuestions()[qIndex];
			int subjectid = getSubjectId(db, stmt);
			int questionid = getQuestionId(mq, subjectid, stmt);
			String ans = mq.getAllQAnswers()[aIndex - 1].getQAnswer().getAnswer();
			int answerid = getAnswerId(ans, stmt, subjectid);
			mq.removeAnswerToQuestion(aIndex - 1, answerid, questionid, stmt);
			System.out.println("The answer was successfully removed");
		}
		return true;
	}

	public static boolean deleteQuestionFromDb(DataBase db, Statement stmt) throws SQLException {
		if (db.getNumOfQuestions() == 0) {
			System.out.println("There are no questions in the database.\n");
			return false;
		}
		System.out.println(db.questionToString());

		System.out.println("Please select a question number.");
		int index = s.nextInt();
		if (index - 1 >= db.getNumOfQuestions() || index - 1 < 0) {
			System.out.println("There is no question in the database with the number you selected.\n");
			return false;
		}
		int subjectid = getSubjectId(db, stmt);
		int questionid = getQuestionId(db.getQuestion(index - 1), subjectid, stmt);

		boolean res = db.removeQuestion(index - 1, questionid, stmt);

		if (res)
			System.out.println("The question has been deleted from the database.\n");

		return res;
	}

	public static void createExam(DataBase db, Statement stmt) throws FileNotFoundException, SQLException {
		boolean isValid = true;
		int numOfQuestions = 0;
		if (db.getNumOfQuestions() > 0 && db.getNumOfGoodQuestions() > 0) {
			do {
				isValid = false;
				try {
					System.out.println("There are " + db.getNumOfGoodQuestions()
							+ " good questions in the database ,how many questions would you like to create for the exam?");
					numOfQuestions = s.nextInt();

					if (numOfQuestions > 10 || numOfQuestions <= 0) {
						throw new TooManyQuestionException();
					} else if (numOfQuestions > db.getNumOfGoodQuestions()) {
						System.out.println(
								"The number of questions for the exam must be less than the number of good questions in the database.\n");
						isValid = true;
					}
				} catch (TooManyQuestionException e) {
					System.out.println(e.getMessage() + "\n");
					isValid = true;
				} catch (InputMismatchException e) {
					System.out.println(e.getMessage());
					isValid = true;
				}
			} while (isValid);

			do {
				isValid = false;
				System.out.println("In which way do you want to create the exam?");
				System.out.println("1) Manual exam.");
				System.out.println("2) Automatic exam.");
				int choice = s.nextInt();
				switch (choice) {
				case 1:
					ManualExam me = new ManualExam();
					me.createExam(db, numOfQuestions, stmt);
					break;
				case 2:
					AutomaticExam ae = new AutomaticExam();
					ae.createExam(db, numOfQuestions, stmt);
					break;
				default:
					System.out.println("Wrong input , please try again.");
					isValid = true;
				}

			} while (isValid);
		} else if (db.getNumOfQuestions() == 0) {
			System.out.println("There are no questions in the database.\n");
		} else {
			System.out.println("There are no good questions in the database.\n");
		}
	}

	public static void getExamFromDB(DataBase db, Statement stmt) throws SQLException, FileNotFoundException {
		int choice = 0, i = 1;
		boolean inRange = false;
		ArrayList<String> examNames = new ArrayList<String>();
		System.out.println("These are the exams that exist in the database:");
		int subjectid = getSubjectId(db, stmt);
		ResultSet rs1 = stmt
				.executeQuery("SELECT exam FROM examtb WHERE subjectid = '" + subjectid + "' ORDER BY exam ASC");
		while (rs1.next()) {
			examNames.add(i - 1, rs1.getString("exam"));
			System.out.println("" + i + ") " + rs1.getString("exam"));
			i++;
		}
		rs1.close();
		System.out.println();

		if (i > 1) { // if there are no exams in the DB
			do {
				System.out.println("Choose the number of the exam you want to download:");
				choice = s.nextInt();
				if (choice <= 0 || choice >= i) {
					System.out.println("Invalid input , please try again.");
				} else {
					inRange = true;
				}
			} while (!inRange);
		}

		ResultSet rs2 = stmt.executeQuery("SELECT * FROM examtb WHERE exam = '" + examNames.get(choice - 1)
				+ "' AND subjectid = '" + subjectid + "';");
		rs2.next();
		String examString = rs2.getString("examcontent");
		String solutionString = rs2.getString("solutioncontent");

		File ex = new File("exam_" + examNames.get(choice - 1));
		File so = new File("solution_" + examNames.get(choice - 1));
		PrintWriter pw = new PrintWriter(ex);
		PrintWriter pw1 = new PrintWriter(so);
		pw.print(examString);
		pw1.print(solutionString);
		pw.close();
		pw1.close();
	}

	public static void printMenu() {
		System.out.println("Choose an option from the following: ");
		System.out.println("1) Display all the questions in the database with their answers. ");
		System.out.println("2) Add new answer to the database. ");
		System.out.println("3) Add an answer from the database to an existing question. ");
		System.out.println("4) Add a new question to the database. ");
		System.out.println("5) Delete an answer to a question that exist in the database. ");
		System.out.println("6) Delete a question from the database. ");
		System.out.println("7) Create an exam. ");
		System.out.println("8) Download an exam. ");
		System.out.println("-1) Exit. ");
	}

	public static DataBase chooseSubject(Statement stmt) {
		boolean isValid = true, isExist = true;
		DataBase db = null;
		int choice;
		String allSubjects[] = getSubjectsDB(stmt);
		do {
			try {
				System.out.println("Choose an option from the following:");
				System.out.println("1) Add new subject.");
				System.out.println("2) Choose a subject from among the existing subjects.\n");
				choice = s.nextInt();
				switch (choice) {
				case 1:
					do {
						System.out.println("Enter the name of the subject:");
						s.nextLine();
						String ans = s.nextLine();
						ans = checkSQLInjection(ans);
						isExist = false;
						for (int i = 0; i < allSubjects.length; i++) {
							if (allSubjects[i] == ans) {
								System.out.println(
										"There is already a subject with the name you chose , please try again.");
								isExist = true;
							}
						}
						if (!isExist) {
							db = new DataBase(ans);
							stmt.executeUpdate("INSERT INTO subjecttb VALUES (default, '" + db.getSubject() + "');");
						}
					} while (isExist);
					isValid = false;
					break;

				case 2:
					do {
						System.out.println("Please select the subject number.");
						int ans = s.nextInt();
						if (ans <= 0 || ans > allSubjects.length) {
							System.out.println("Invalid input , please try again.");
						} else {
							db = new DataBase(allSubjects[ans - 1]);
							isValid = false;
							getAnswersDB(stmt, db, ans);
							getOQuestionsDB(stmt, db, ans);
							getMQuestionsDB(stmt, db, ans);
						}
					} while (isValid);
					break;
				default:
					System.out.println("Invalid input , please try again.");
				}
			} catch (SQLException ex) {
				while (ex != null) {
					System.out.println("SQL exception: " + ex.getMessage());
					ex = ex.getNextException();
				}
			} catch (InputMismatchException e) {
				System.out.println("Invalid input , please try again.");
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		} while (isValid);
		return db;

	}

	public static Connection initConnection() {
		Connection conn = null;
		try {
			Class.forName("org.postgresql.Driver");
			String dbUrl = "jdbc:postgresql://localhost:5432/ExamCreationDB";
			conn = DriverManager.getConnection(dbUrl, "postgres", "12345");
		} catch (SQLException ex) {
			while (ex != null) {
				System.out.println("SQL exception: " + ex.getMessage());
				ex = ex.getNextException();
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return conn;
	}

	public static Statement createStatement(Connection conn) {
		Statement stmt = null;
		try {
			stmt = conn.createStatement();
		} catch (SQLException ex) {
			System.out.println("SQL exception: " + ex.getMessage());
		}
		return stmt;
	}

	public static String[] getSubjectsDB(Statement stmt) {
		String allSubjects[] = null;
		try {
			ResultSet rs = stmt.executeQuery("SELECT COUNT(*) AS num FROM subjecttb;");
			int counter = 0;
			rs.next();
			counter = rs.getInt("num");
			allSubjects = new String[counter];
			ResultSet rs1 = stmt.executeQuery("SELECT * FROM subjecttb;");

			System.out.println("These are all the subjects that exist in our system:");
			for (int i = 0; i < allSubjects.length; i++) {
				rs1.next();
				allSubjects[i] = rs1.getString("subject");
				System.out.println((i + 1) + ") " + allSubjects[i]);
			}
			System.out.println();
		} catch (SQLException ex) {
			while (ex != null) {
				System.out.println("SQL exception: " + ex.getMessage());
				ex = ex.getNextException();
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return allSubjects;
	}

	public static void getAnswersDB(Statement stmt, DataBase db, int subjectid) throws SQLException {
		ResultSet rs2 = stmt.executeQuery("SELECT * FROM answertb WHERE subjectid = " + subjectid + ";");
		while (rs2.next()) {
			String answerText = rs2.getString("answer");
			Answers ans = new Answers(answerText);
			db.addAnswer(ans);
		}
		rs2.close();
	}

	public static void getOQuestionsDB(Statement stmt, DataBase db, int subjectid) throws SQLException {
		ResultSet rs3 = stmt
				.executeQuery("SELECT * FROM oquestiontb NATURAL JOIN answertb WHERE subjectid = " + subjectid + ";");
		while (rs3.next()) {
			String questionText = rs3.getString("question");
			int difficulty = rs3.getInt("difficulty");
			String answerText = rs3.getString("answer");
			db.addQuestion(new OpenQuestion(questionText, eDifficulty.values()[difficulty],
					db.getAnswer(db.getAnswerIndex(answerText))), 0, 0, stmt, !uploadToDb);
		}
		rs3.close();
	}

	public static int getSubjectId(DataBase db, Statement stmt) throws SQLException {
		ResultSet rs = stmt.executeQuery("SELECT subjectid FROM subjecttb WHERE subject = '" + db.getSubject() + "';");
		rs.next();
		int subjectid = rs.getInt("subjectid");
		rs.close();
		return subjectid;
	}

	public static int getQuestionId(Questions question, int subjectid, Statement stmt) throws SQLException {
		ResultSet rs;
		int questionid;
		if (question instanceof MultipleQuestion) {
			rs = stmt.executeQuery("SELECT mquestionid FROM mquestiontb WHERE question = '" + question.getQuestion()
					+ "' AND subjectid = " + subjectid + ";");
			rs.next();
			questionid = rs.getInt("mquestionid");
		} else {
			rs = stmt.executeQuery("SELECT oquestionid FROM oquestiontb WHERE question = '" + question.getQuestion()
					+ "' AND subjectid = " + subjectid + ";");
			rs.next();
			questionid = rs.getInt("oquestionid");
		}
		rs.close();
		return questionid;
	}

	public static int getAnswerId(String answer, Statement stmt, int subjectid) throws SQLException {
		ResultSet rs = stmt.executeQuery(
				"SELECT answerid FROM answertb WHERE answer = '" + answer + "' AND subjectid = " + subjectid + ";");
		rs.next();
		int answerid = rs.getInt("answerid");
		rs.close();
		return answerid;
	}

	public static void getMQuestionsDB(Statement stmt, DataBase db, int subjectid) throws SQLException {
		int offset = db.getNumOfQuestions() - 1;
		ResultSet rs4 = stmt.executeQuery(
				"SELECT question, difficulty, isCorrect, answer, mquestionid FROM mquestiontb NATURAL JOIN"
						+ " mquestion_answertb NATURAL JOIN answertb WHERE subjectid = " + subjectid + ";");
		while (rs4.next()) {
			String questionText = rs4.getString("question");
			int difficulty = rs4.getInt("difficulty");
			db.addQuestion(new MultipleQuestion(questionText, eDifficulty.values()[difficulty]), 0, 0, stmt,
					!uploadToDb);

			boolean isCorrect = rs4.getBoolean("iscorrect");
			String answerText = rs4.getString("answer");
			Answers tmpAns = db.getAnswer(db.getAnswerIndex(answerText));
			int questionIndex = rs4.getInt("mquestionid") + offset;
			((MultipleQuestion) (db.getQuestion(questionIndex))).addAnswerToQuestion(tmpAns, isCorrect, 0, 0, stmt,
					!uploadToDb);
		}
		rs4.close();
	}

	public static void main(String[] args) throws ClassNotFoundException, IOException {
		boolean fcontinue = true;
		int choice;

		Connection conn = initConnection();
		Statement stmt = createStatement(conn);
		System.out.println("Welcome to our exams creation system.\n ");
		DataBase db = chooseSubject(stmt);

		do {
			try {
				printMenu();
				choice = s.nextInt();
				switch (choice) {
				case 1:
					printQuestionsFromDb(db);
					break;
				case 2:
					addAnswerToDb(db, stmt);
					break;
				case 3:
					addAnswerToQuestion(db, stmt);
					break;
				case 4:
					addQuestionToDb(db, stmt);
					break;
				case 5:
					deleteAnsToQuestionFromDb(db, stmt);
					break;
				case 6:
					deleteQuestionFromDb(db, stmt);
					break;
				case 7:
					createExam(db, stmt);
					break;
				case 8:
					getExamFromDB(db, stmt);
					break;
				case -1:
					System.out.println("Thank you and goodbye. ");
					fcontinue = false;
					conn.close();
					break;
				default:
					System.out.println("Invalid input , please choose again.\n");
				}
			} catch (SQLException ex) {
				while (ex != null) {
					System.out.println("SQL exception: " + ex.getMessage());
					ex = ex.getNextException();
				}
			} catch (InputMismatchException e) {
				System.out.println("Invalid input , please try again.\n");
				s.nextLine();
			} catch (Exception e) {
				System.out.println(e.getMessage() + "\n");
			}

		} while (fcontinue);

	}

}
