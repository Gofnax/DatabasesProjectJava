package Gilad_faibish;

import java.io.FileNotFoundException;

public interface Examable  {
	void createExam(DataBase db , int numOfQuestions) throws FileNotFoundException;

}
