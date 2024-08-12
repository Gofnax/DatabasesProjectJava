package Gilad_faibish;

import java.io.FileNotFoundException;
import java.sql.*;

public interface Examable  {
	void createExam(DataBase db , int numOfQuestions, Statement stmt) throws FileNotFoundException, SQLException;

}
