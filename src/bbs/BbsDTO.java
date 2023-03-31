package bbs;

public class BbsDTO {
	int bbsNumber;
	String bbsTitle;
	String userID;
	String bbsContent;
	String bbsDate;
	int bbsActive;
	
	public int getBbsNumber() {
		return bbsNumber;
	}
	public void setBbsNumber(int bbsNumber) {
		this.bbsNumber = bbsNumber;
	}
	public String getBbsTitle() {
		return bbsTitle;
	}
	public void setBbsTitle(String bbsTitle) {
		this.bbsTitle = bbsTitle;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getBbsContent() {
		return bbsContent;
	}
	public void setBbsContent(String bbsContent) {
		this.bbsContent = bbsContent;
	}
	public String getBbsDate() {
		return bbsDate;
	}
	public void setBbsDate(String bbsDate) {
		this.bbsDate = bbsDate;
	}
	public int getBbsActive() {
		return bbsActive;
	}
	public void setBbsActive(int bbsActive) {
		this.bbsActive = bbsActive;
	}
}
