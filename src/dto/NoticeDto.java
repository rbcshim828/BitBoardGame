package dto;

/*
CREATE TABLE BG_NOTICE(
	    SEQ NUMBER(8) PRIMARY KEY,            --������
	    ID VARCHAR2(50) NOT NULL,             --���̵�. �ܷ�Ű
	    WDATE DATE NOT NULL,                  --�ۼ���
	    TITLE VARCHAR2(200) NOT NULL,         --����
	    CONTENT VARCHAR2(4000) NOT NULL,      --����
	    READCOUNT NUMBER(8) NOT NULL,         --��ȸ��
	    DEL NUMBER(1) NOT NULL                --�������� (0 : X / 1 : ���� Ż��)
	);

	CREATE SEQUENCE SEQ_BG_NOTICE
	START WITH 1
	INCREMENT BY 1;

	ALTER TABLE BG_NOTICE
	ADD CONSTRAINT FK_BG_NOTICE_ID FOREIGN KEY(ID)
	REFERENCES BG_MEMBER(ID);
*/
public class NoticeDto {

	int seq;
	String id;
	String wDate;
	String title;
	String content;
	int readCount;
	int del;
	
	
	public NoticeDto() {
		// TODO Auto-generated constructor stub
	}


	public NoticeDto(int seq, String id, String wdate, String title, String content, int readcount, int del) {
		super();
		this.seq = seq;
		this.id = id;
		this.wDate = wdate;
		this.title = title;
		this.content = content;
		this.readCount = readcount;
		this.del = del;
	}


	public NoticeDto(String id, String title, String content) {
		this.id=id;
		this.title=title;
		this.content=content;
	}
	
	
	public NoticeDto(String title, String content) {
		this.title = title;
		this.content = content;
	}

	public int getSeq() {
		return seq;
	}


	public void setSeq(int seq) {
		this.seq = seq;
	}


	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public String getWdate() {
		return wDate;
	}


	public void setWdate(String wdate) {
		this.wDate = wdate;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public int getReadcount() {
		return readCount;
	}


	public void setReadcount(int readcount) {
		this.readCount = readcount;
	}


	public int getDel() {
		return del;
	}


	public void setDel(int del) {
		this.del = del;
	}
	
}
