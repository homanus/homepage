package spring.model.homepage.chat;

public class Chat_RoomDTO {
	
	private int chat_index;
	private String chat_title;
	private String chat_nickname;
	private String id;
	private String cdate;
	
	public int getChat_index() {
		return chat_index;
	}
	public void setChat_index(int chat_index) {
		this.chat_index = chat_index;
	}
	public String getChat_title() {
		return chat_title;
	}
	public void setChat_title(String chat_title) {
		this.chat_title = chat_title;
	}
	public String getChat_nickname() {
		return chat_nickname;
	}
	public void setChat_nickname(String chat_nickname) {
		this.chat_nickname = chat_nickname;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCdate() {
		return cdate;
	}
	public void setCdate(String cdate) {
		this.cdate = cdate;
	}
	
	
}
