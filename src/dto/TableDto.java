package dto;

/*
CREATE TABLE  BG_TABLE(
    TABLENUMBER NUMBER(4) PRIMARY KEY,     --���̺� ��ȣ
    NUMBERPEOPLE NUMBER(4) NOT NULL,       --�ִ� �̿� ���� �ο���
    ISRESERVAITONTABLE NUMBER(1) NOT NULL  --�������� ���̺��ΰ�? (0 : �ƴ� / 1 : ����)
);
*/
public class TableDto {
	private int tablenumber;
	private int numberpeople;
	private int isreserbaitiontable;
	
	public TableDto() {
		// TODO Auto-generated constructor stub
	}

	public TableDto(int tablenumber, int numberpeople, int isreserbaitiontable) {
		super();
		this.tablenumber = tablenumber;
		this.numberpeople = numberpeople;
		this.isreserbaitiontable = isreserbaitiontable;
	}

	public int getTablenumber() {
		return tablenumber;
	}

	public void setTablenumber(int tablenumber) {
		this.tablenumber = tablenumber;
	}

	public int getNumberpeople() {
		return numberpeople;
	}

	public void setNumberpeople(int numberpeople) {
		this.numberpeople = numberpeople;
	}

	public int getIsreserbaitiontable() {
		return isreserbaitiontable;
	}

	public void setIsreserbaitiontable(int isreserbaitiontable) {
		this.isreserbaitiontable = isreserbaitiontable;
	}
	
}
