package Gilad_faibish;

import java.util.Arrays;

public class SubjectsDb {
	private DataBase[] allSubjects;
	private int numOfSubjects;

	public SubjectsDb(DataBase[] allSubjects) {
		this.allSubjects = allSubjects;
		this.numOfSubjects = allSubjects.length;
	}

	public DataBase[] getAllSubjects() {
		return this.allSubjects;
	}

	public int getNumOfSubjects() {
		return this.numOfSubjects;
	}

	public boolean isSubExist(String subject) {
		for (int i = 0; i < allSubjects.length; i++) {
			if (allSubjects[i].getSubject().equalsIgnoreCase(subject))
				return true;
		}
		return false;
	}

	public boolean addSubject(DataBase db) {
		if (this.numOfSubjects > 0 && isSubExist(db.getSubject()))
			return false;

		this.allSubjects = Arrays.copyOf(allSubjects, allSubjects.length + 1);
		this.allSubjects[numOfSubjects++] = db;
		return true;
	}

	public String toString() {
		StringBuffer sb = new StringBuffer("This is all the subjects that exist in our system:\n\n");

		for (int i = 0; i < numOfSubjects; i++) {
			sb.append(i + 1).append(") ").append(allSubjects[i].getSubject()).append("\n");
		}
		return sb.toString();
	}

	@Override
	public boolean equals(Object obj) {
		if (!(obj instanceof SubjectsDb)) {
			return false;
		}

		SubjectsDb temp = (SubjectsDb) obj;
		return (Arrays.equals(this.allSubjects, temp.allSubjects)
				&& (this.getNumOfSubjects() == temp.getNumOfSubjects()));
	}

}
