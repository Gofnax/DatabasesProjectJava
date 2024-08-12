CREATE TABLE subjecttb(
	subjectid SERIAL NOT NULL,
	subject VARCHAR(100) NOT NULL,
	PRIMARY KEY(subjectid));

CREATE TABLE answertb(
	answerid SERIAL NOT NULL,
	subjectid INT NOT NULL,
	answer VARCHAR(256) NOT NULL,
	PRIMARY KEY(answerid),
	FOREIGN KEY (subjectid) REFERENCES subjecttb(subjectid));

CREATE TABLE mquestiontb(
	mquestionid SERIAL NOT NULL,
	subjectid INT NOT NULL,
	question VARCHAR(256) NOT NULL,
	difficulty INT NOT NULL CHECK(difficulty >= 0 AND difficulty <= 2),
	PRIMARY KEY(mquestionid),
	FOREIGN KEY (subjectid) REFERENCES subjecttb(subjectid));

CREATE TABLE oquestiontb(
	oquestionid SERIAL NOT NULL,
	subjectid INT NOT NULL,
	answerid INT NOT NULL,
	question VARCHAR(256) NOT NULL,
	difficulty INT NOT NULL CHECK(difficulty >= 0 AND difficulty <= 2),
	PRIMARY KEY(oquestionid),
	FOREIGN KEY (answerid) REFERENCES answertb(answerid),
	FOREIGN KEY (subjectid) REFERENCES subjecttb(subjectid));

CREATE TABLE mquestion_answertb(
	mquestionid INT NOT NULL,
	answerid INT NOT NULL,
	iscorrect boolean NOT NULL,
	PRIMARY KEY(mquestionid, answerid),
	FOREIGN KEY (answerid) REFERENCES answertb(answerid),
	FOREIGN KEY (mquestionid) REFERENCES mquestiontb(mquestionid) ON DELETE CASCADE);

CREATE TABLE examtb(
    examid SERIAL NOT NULL,
	subjectid INT NOT NULL,
    exam VARCHAR(256) NOT NULL,
    examcontent TEXT NOT NULL,
	solutioncontent TEXT NOT NULL,
    PRIMARY KEY(examid),
	FOREIGN KEY (subjectid) REFERENCES subjecttb(subjectid));