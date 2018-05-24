package spring.model.homepage.chat;

public class Chat_MessageDTO {
	
	private int chat_message_index;
	private String chat_content;
	private int chat_index;
	private String chat_date;
	private String nickname;
	
	public int getChat_message_index() {
		return chat_message_index;
	}
	public void setChat_message_index(int chat_message_index) {
		this.chat_message_index = chat_message_index;
	}
	public String getChat_content() {
		return chat_content;
	}
	public void setChat_content(String chat_content) {
		this.chat_content = chat_content;
	}
	public int getChat_index() {
		return chat_index;
	}
	public void setChat_index(int chat_index) {
		this.chat_index = chat_index;
	}
	public String getChat_date() {
		return chat_date;
	}
	public void setChat_date(String chat_date) {
		this.chat_date = chat_date;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
	

}
