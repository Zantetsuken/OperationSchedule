package jp.co.vsn.schedule;

public class Employee {
	private int no;
	private String tacheck;
	private String datestart;
	private String dateend;
	private String id;
	private String name;
	private String place;
	private String detail;
	private String riyu;
	private String delflg;
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getTacheck() {
		return tacheck;
	}
	public void setTacheck(String tacheck) {
		this.tacheck = tacheck;
	}
	public String getDatestart() {
		return datestart;
	}
	public void setDatestart(String datestart) {
		this.datestart = datestart;
	}
	public String getDateend() {
		return dateend;
	}
	public void setDateend(String dateend) {
		this.dateend = dateend;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPlace() {
		return place;
	}
	public void setPlace(String place) {
		this.place = place;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	public String getRiyu() {
		return riyu;
	}
	public void setRiyu(String riyu) {
		this.riyu = riyu;
	}
	public String getDelflg() {
		return delflg;
	}
	public void setDeflg(String delflg) {
		this.delflg = delflg;
	}

	public Employee(int no,String tacheck, String datestart, String dateend,
			String id, String name, String place, String detail, String riyu,
			String delflg) {
		super();
		this.no = no;
		this.tacheck = tacheck;
		this.datestart = datestart;
		this.dateend = dateend;
		this.id = id;
		this.name = name;
		this.place = place;
		this.detail = detail;
		this.riyu = riyu;
		this.delflg = delflg;
	}
}
