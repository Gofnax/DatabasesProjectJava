package Gilad_faibish;

// El grande profesor
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.InputMismatchException;
import java.util.Iterator;
import java.util.Scanner;
import java.sql.*;

import Gilad_faibish.Questions.eDifficulty;

public class Program {
	private static Scanner s = new Scanner(System.in);

	public static MultipleQuestion[] showMQuestions(DataBase db) {
		MultipleQuestion[] mq = new MultipleQuestion[db.getNumOfMQuestions()];
		int mqIndex = 0;

		for (int i = 0; i < db.getNumOfQuestions(); i++) {
			if (db.getAllQuestions()[i] instanceof MultipleQuestion) {
				System.out.println((mqIndex + 1) + ") " + db.getAllQuestions()[i].getQuestion());
				System.out.println("   serial number: " + db.getAllQuestions()[i].serialNum + " | difficuly level: "
						+ db.getAllQuestions()[i].difficulty + "\n");
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

	public static boolean addAnswerToDb(DataBase db) {
		System.out.println(db.ansToString());

		System.out.println("please write your answer: ");
		s.nextLine();
		String answer = s.nextLine();

		Answers a = new Answers(answer);

		boolean res = db.addAnswer(a);

		if (res) {
			System.out.println("Answer successfully added.\n ");
			return true;
		} else
			System.out.println("The answer already exists in the database.\n ");
		return false;
	}

	public static boolean addAnswerToQuestion(DataBase db) {
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
			mq.addAnswerToQuestion(temp[aIndex - 1], isCorrect);
			System.out.println("Answer successfully added.\n ");
		}
		return true;

	}

	public static boolean addQuestionToDb(DataBase db) {
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

		if (qType == 1) {
			System.out.println(db.ansToString());
			System.out.println("Please select the answer number that you want to add.");
			int ans = s.nextInt();
			if (ans < 1 || ans > db.getNumOfAnswers()) {
				System.out.println("Invalid Input.\n");
				return false;
			}
			q = new OpenQuestion(question, difficulty, db.getAnswer(ans - 1));
		} else {
			q = new MultipleQuestion(question, difficulty);
		}

		boolean res = db.addQuestion(q);
		if (res) {
			System.out.println("Question successfully added.\n ");
			return true;
		} else
			System.out.println("The question already exists in the database.\n ");
		return false;
	}

	public static boolean deleteAnsToQuestionFromDb(DataBase db) {
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
			mq.removeAnswerToQuestion(aIndex - 1);
			System.out.println("The answer was successfully removed");
		}
		return true;
	}

	public static boolean deleteQuestionFromDb(DataBase db) {
		if (db.getNumOfQuestions() == 0) {
			System.out.println("There are no questions in the database.\n");
			return false;
		}
		System.out.println(db.questionToString());

		System.out.println("Please select a question number.");
		int index = s.nextInt();

		boolean res = db.removeQuestion(index - 1);

		if (res) {
			System.out.println("The question has been deleted from the database.\n");
			return res;
		} else
			System.out.println("There is no question in the database with the number you selected.\n");
		return res;
	}

	public static void createExam(DataBase db) throws FileNotFoundException {
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
					me.createExam(db, numOfQuestions);
					break;
				case 2:
					AutomaticExam ae = new AutomaticExam();
					ae.createExam(db, numOfQuestions);
					break;
				default:
					System.out.println("Wrong input , please try again.");
					isValid = true;
				}

			} while (isValid);
			Questions.setCounter(db.getNumOfQuestions());
		} else if (db.getNumOfQuestions() == 0) {
			System.out.println("There are no questions in the database.\n");
		} else {
			System.out.println("There are no good questions in the database.\n");
		}
	}

	public static void createQAndAManually(DataBase db) {
		MultipleQuestion q1 = new MultipleQuestion("Which of the following countries is the largest?",
				eDifficulty.Easy);
		db.addQuestion(q1);
		Answers a0 = new Answers("My name is Gilad");
		db.addAnswer(a0);
		Questions q0 = new OpenQuestion("What is your name?", eDifficulty.Easy, a0);
		db.addQuestion(q0);
		MultipleQuestion q2 = new MultipleQuestion("Which of the following countries is the smallest?",
				eDifficulty.Hard);
		db.addQuestion(q2);
		MultipleQuestion q3 = new MultipleQuestion("Which of the following countries is located in the Middle East?",
				eDifficulty.Regular);
		db.addQuestion(q3);
		MultipleQuestion q4 = new MultipleQuestion("Which of the following countries is located in America?",
				eDifficulty.Easy);
		db.addQuestion(q4);
		MultipleQuestion q5 = new MultipleQuestion("Which of the following countries is located in Europe?",
				eDifficulty.Easy);
		db.addQuestion(q5);
		MultipleQuestion q6 = new MultipleQuestion(
				"In which of the following countries is English considered their mother tongue?", eDifficulty.Easy);
		db.addQuestion(q6);
		MultipleQuestion q7 = new MultipleQuestion(
				"In which of the following countries is Spanish considered their mother tongue?", eDifficulty.Hard);
		db.addQuestion(q7);
		MultipleQuestion q8 = new MultipleQuestion(
				"In which of the following countries is Arabic considered their mother tongue?", eDifficulty.Regular);
		db.addQuestion(q8);
		MultipleQuestion q9 = new MultipleQuestion(
				"In which of the following countries is Hebrew considered their mother tongue?", eDifficulty.Hard);
		db.addQuestion(q9);

		Answers a1 = new Answers("Israel");
		db.addAnswer(a1);
		Answers a2 = new Answers("United States");
		db.addAnswer(a2);
		Answers a3 = new Answers("Mexico");
		db.addAnswer(a3);
		Answers a4 = new Answers("Colombia");
		db.addAnswer(a4);
		Answers a5 = new Answers("Netherlands");
		db.addAnswer(a5);
		Answers a6 = new Answers("Egypt");
		db.addAnswer(a6);
		Answers a7 = new Answers("Iran");
		db.addAnswer(a7);
		Answers a8 = new Answers("Spain");
		db.addAnswer(a8);
		Answers a9 = new Answers("Lebanon");
		db.addAnswer(a9);
		Answers a10 = new Answers("France");
		db.addAnswer(a10);
		Answers a11 = new Answers("Panama");
		db.addAnswer(a11);

		q1.addAnswerToQuestion(a1, false);
		q1.addAnswerToQuestion(a2, true);
		q1.addAnswerToQuestion(a3, false);
		q1.addAnswerToQuestion(a4, false);
		q1.addAnswerToQuestion(a5, false);
		q1.addAnswerToQuestion(a6, false);
		q1.addAnswerToQuestion(a7, false);
		q1.addAnswerToQuestion(a8, false);
		q1.addAnswerToQuestion(a9, false);
		q1.addAnswerToQuestion(a10, false);

		q2.addAnswerToQuestion(a1, true);
		q2.addAnswerToQuestion(a2, false);
		q2.addAnswerToQuestion(a3, false);
		q2.addAnswerToQuestion(a4, false);
		q2.addAnswerToQuestion(a10, false);

		q3.addAnswerToQuestion(a2, false);
		q3.addAnswerToQuestion(a5, false);
		q3.addAnswerToQuestion(a1, true);
		q3.addAnswerToQuestion(a6, true);
		q3.addAnswerToQuestion(a9, true);

		q4.addAnswerToQuestion(a1, false);
		q4.addAnswerToQuestion(a5, false);
		q4.addAnswerToQuestion(a6, false);
		q4.addAnswerToQuestion(a7, false);
		q4.addAnswerToQuestion(a8, false);

		q5.addAnswerToQuestion(a1, false);
		q5.addAnswerToQuestion(a2, false);
		q5.addAnswerToQuestion(a3, false);
		q5.addAnswerToQuestion(a4, false);
		q5.addAnswerToQuestion(a5, true);

		q6.addAnswerToQuestion(a1, false);
		q6.addAnswerToQuestion(a3, false);
		q6.addAnswerToQuestion(a5, false);
		q6.addAnswerToQuestion(a2, true);
		q6.addAnswerToQuestion(a8, false);

		q7.addAnswerToQuestion(a1, false);
		q7.addAnswerToQuestion(a2, false);
		q7.addAnswerToQuestion(a3, true);
		// q7.addAnswerToQuestion(a4, true);
		// q7.addAnswerToQuestion(a5, false);

		q8.addAnswerToQuestion(a2, false);
		q8.addAnswerToQuestion(a3, false);
		q8.addAnswerToQuestion(a4, false);
		q8.addAnswerToQuestion(a5, false);
		// q8.addAnswerToQuestion(a10, false);

		q9.addAnswerToQuestion(a4, false);
		q9.addAnswerToQuestion(a1, true);
		q9.addAnswerToQuestion(a6, false);
		// q9.addAnswerToQuestion(a9, false);

	}

	public static void printMenu() {
		System.out.println("Choose an option from the following: ");
		System.out.println("1) Display all the questions in the database with their answers. ");
		System.out.println("2) Add new answer to the database. ");
		System.out.println("3) Add an answer from the database to an existing question. ");
		System.out.println("4) Add a new question to the database. ");
		System.out.println("5) Delete an answer to a question that exist in the database. ");
		System.out.println("6) Delete a question from the database. ");
		System.out.println("7) Create an exam manually. ");
		System.out.println("-1) Exit. ");
	}

	public static DataBase chooseSubject(SubjectsDb subjects) {
		boolean isValid = true, isExist = true;
		DataBase db = null;
		int choice;

		System.out.println(subjects.toString());
		do {
			try {
				System.out.println("Choose an option from the following:");
				System.out.println("1) Add new subject.");
				System.out.println("2) Choose a subject from among the existing subjects.");
				choice = s.nextInt();
				switch (choice) {
				case 1:
					do {
						System.out.println("Enter the name of the subject:");
						String ans = s.next();
						if (!subjects.isSubExist(ans)) {
							db = new DataBase(ans);
							subjects.addSubject(db);
							Questions.setCounter(db.getNumOfQuestions());
							isExist = false;
						} else {
							System.out
									.println("There is already a subject with the name you chose , please try again.");
						}
					} while (isExist);
					isValid = false;
					break;

				case 2:
					do {
						System.out.println(subjects.toString());
						System.out.println("Please select the subject number.");
						int ans = s.nextInt();
						if (ans <= 0 || ans > subjects.getNumOfSubjects()) {
							System.out.println("Invalid input , please try again.");
						} else {
							db = subjects.getAllSubjects()[ans - 1];
							Questions.setCounter(db.getNumOfQuestions());
							isValid = false;
						}
					} while (isValid);
				}
			} catch (InputMismatchException e) {
				System.out.println("Invalid input , please try again.");
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		} while (isValid);
		return db;

	}

	public static DataBase[] createSubjectsArr() throws FileNotFoundException, IOException, ClassNotFoundException {
		DataBase[] allSubjects;
		ObjectInputStream inFile = new ObjectInputStream(new FileInputStream("SubjectsDb.dat"));
		allSubjects = (DataBase[]) inFile.readObject();
		inFile.close();
		return allSubjects;

	}

	public static void main(String[] args) throws ClassNotFoundException, IOException {
		boolean fcontinue = true;
		int choice;

		Connection conn = null;
		Statement stmt = null;
		try {
			Class.forName("org.postgresql.Driver");
			String dbUrl = "jdbc:postgresql://localhost:5432/ExamCreationDB";
			conn = DriverManager.getConnection(dbUrl, "postgres", "1234");
			stmt = conn.createStatement();
		} catch (SQLException ex) {
			while (ex != null) {
				System.out.println("SQL exception: " + ex.getMessage());
				ex = ex.getNextException();
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		// DataBase db = new DataBase("Countries");
		// createQAndAManually(db);
		//DataBase[] allSubjects;
		//allSubjects = createSubjectsArr();
		
		DataBase[] allSubjects = null;
		
		try {
			ResultSet rs = stmt.executeQuery("SELECT COUNT(*) AS num FROM subjecttb;");
			int counter = 0;
			rs.next();
			counter = rs.getInt("num");
			
			ResultSet rs1 = stmt.executeQuery("SELECT * FROM subjecttb;");
			int subjectid;
			String subject = null;
			allSubjects = new DataBase[counter];
			
			for(int i = 0; i < counter; i++) {
				rs1.next();
				subjectid = rs1.getInt("subjectid");
				subject = rs1.getString("subject");
				allSubjects[i] = new DataBase(subject);
				
				// gets all the answers from the DB
				ResultSet rs2 = stmt.executeQuery("SELECT * FROM answertb WHERE subjectid = " + subjectid + ";");
				while(rs2.next()) {
					String answerText = rs2.getString("answer");
					Answers ans = new Answers(answerText);
					allSubjects[i].addAnswer(ans);
				}
				
				// gets all the open questions from the DB
				ResultSet rs3 = stmt.executeQuery("SELECT * FROM oquestiontb WHERE subjectid = " + subjectid + ";");
				while(rs3.next()) {
					//maybe add answerid in serialNum attribute
					String questionText = rs3.getString("question");
					int difficulty = rs3.getInt("difficulty");
					int ansId = rs3.getInt("answerid");
					ResultSet rs4 = stmt.executeQuery("SELECT answer FROM answertb WHERE answerid = " + ansId + ";");
					rs4.next();
					String answerText = rs4.getString("answer");
					allSubjects[i].addQuestion(new OpenQuestion(questionText, eDifficulty.values()[difficulty],
							allSubjects[i].getAnswer(allSubjects[i].getAnswerIndex(answerText))));
				}
				
				// gets all the multiple choice questions from the DB
				ResultSet rs5 = stmt.executeQuery("SELECT * FROM mquestiontb WHERE subjectid = " + subjectid + ";");
				while(rs5.next()) {
					int questionid = rs5.getInt("mquestionid");
					String questionText = rs5.getString("question");
					int difficulty = rs5.getInt("difficulty");
					allSubjects[i].addQuestion(new MultipleQuestion(questionText, eDifficulty.values()[difficulty]));
					
					// gets all the answers associated with the multiple choice question
					ResultSet rs6 = stmt.executeQuery("SELECT answerid, isCorrect FROM mquestion_answertb WHERE mquestionid = " + questionid + ";");
					while(rs6.next()) {
						boolean isCorrect = rs6.getBoolean("iscorrect");
						ResultSet rs7 = stmt.executeQuery("SELECT answer FROM answertb WHERE answerid = " + rs6.getInt("answerid") + ";");
						rs7.next();
						String answerText = rs7.getString("answer");
						Answers tmpAns = allSubjects[i].getAnswer(allSubjects[i].getAnswerIndex(answerText));
						int questionIndex = allSubjects[i].getNumOfQuestions() - 1;
						((MultipleQuestion)(allSubjects[i].getQuestion(questionIndex))).addAnswerToQuestion(tmpAns, isCorrect);
					}
				}
				
			}
			
		} catch (SQLException ex) {
			while (ex != null) {
				System.out.println("SQL exception: " + ex.getMessage());
				ex = ex.getNextException();
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		// add subject to DB.
//		try {
//			for(int i = 0; i < allSubjects.length; i++) {
//				int rs = stmt.executeUpdate("INSERT INTO subjecttb VALUES (default, '" + allSubjects[i].getSubject() + "');");
//			}
//		} catch (SQLException ex) {
//			while (ex != null) {
//				System.out.println("SQL exception: " + ex.getMessage());
//				ex = ex.getNextException();
//			}
//		} catch (Exception e) {
//			System.out.println(e.getMessage());
//		}

		SubjectsDb subjects = new SubjectsDb(allSubjects);

		System.out.println("Welcome to our exams creation system.\n ");
		DataBase db = chooseSubject(subjects);

//		try {
		// get subject id
		
//			ResultSet rs1 = stmt.executeQuery("SELECT subjectid FROM subjecttb WHERE subject = 'Countries';");
//			Integer subjectid = null;
//			while (rs1.next()) {
//				subjectid = rs1.getInt("subjectid");
//			}
		// insert answers to answer table
		
//			for (int i = 0; i < db.getNumOfAnswers(); i++) {
//				int rs2 = stmt.executeUpdate("INSERT INTO answertb VALUES (default, " + subjectid.toString() + ", '"
//						+ db.getAnswer(i).getAnswer() + "');");
//			}
//			insert open question to their table.
		
//			Questions[] dbQuestions = db.getAllQuestions();
//			for (int i = 0; i < db.getNumOfQuestions(); i++) {
//				if(dbQuestions[i] instanceof OpenQuestion) {
//					String answerText = ((OpenQuestion)dbQuestions[i]).getAnswer().getAnswer();
//					ResultSet rs4 = stmt.executeQuery("SELECT answerid FROM answertb WHERE answer = '" + answerText + "';");
//					rs4.next();
//					int answerid = rs4.getInt("answerid");
//					int rs3 = stmt.executeUpdate("INSERT INTO oquestiontb VALUES (default, " + subjectid.toString() + ", " + answerid + ", '" + 
//							dbQuestions[i].getQuestion() + "', " + dbQuestions[i].difficulty.ordinal() + ");");
//				}
			// insert multiple question to their table
		
//				if(dbQuestions[i] instanceof MultipleQuestion) {
//					int rs5 = stmt.executeUpdate("INSERT INTO mquestiontb VALUES (default, " + subjectid.toString() + ", '" + dbQuestions[i].getQuestion() + "', "
//							+ dbQuestions[i].difficulty.ordinal() + ");");
//				}
//			}
			// insert links between questions to their answers.
		
//			for (int i = 0; i < dbQuestions.length; i++) {
//				if(dbQuestions[i] instanceof MultipleQuestion) {
//					MultipleQuestion mq = (MultipleQuestion)dbQuestions[i];
//					String ques = mq.getQuestion();
//					ResultSet rs6 = stmt.executeQuery("SELECT mquestionid FROM mquestiontb WHERE question = '" + ques + "';");
//					rs6.next();
//					int questionid = rs6.getInt("mquestionid");
//					for (int j = 0; j < mq.getNumOfQAnswers(); j++) {
//						String answerText = mq.getQAnswer(j).getQAnswer().getAnswer();
//						ResultSet rs7 = stmt.executeQuery("SELECT answerid FROM answertb WHERE answer = '" + answerText + "';");
//						rs7.next();
//						int answerid = rs7.getInt("answerid");
//						boolean isCorrrect = mq.getQAnswer(j).getIsCorrect();
//						int rs8 = stmt.executeUpdate("INSERT INTO mquestion_answertb VALUES("+ questionid + ", "+ answerid + ", "+ isCorrrect +");");
//					}
//				}
//			}
//
//		} catch (SQLException ex) {
//			while (ex != null) {
//				System.out.println("SQL exception: " + ex.getMessage());
//				ex = ex.getNextException();
//			}
//		} catch (Exception e) {
//			System.out.println(e.getMessage());
//		}

		do {
			try {
				printMenu();
				choice = s.nextInt();
				switch (choice) {
				case 1:
					printQuestionsFromDb(db);
					break;
				case 2:
					addAnswerToDb(db);
					break;
				case 3:
					addAnswerToQuestion(db);
					break;
				case 4:
					addQuestionToDb(db);
					break;
				case 5:
					deleteAnsToQuestionFromDb(db);
					break;
				case 6:
					deleteQuestionFromDb(db);
					break;
				case 7:
					createExam(db);
					break;
				case -1:
					System.out.println("Thank you and goodbye. ");
					ObjectOutputStream outFile = new ObjectOutputStream(new FileOutputStream("SubjectsDb.dat"));
					outFile.writeObject(subjects.getAllSubjects());
					outFile.close();
					fcontinue = false;
					conn.close();
					break;
				default:
					System.out.println("Invalid input , please choose again.\n");
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
