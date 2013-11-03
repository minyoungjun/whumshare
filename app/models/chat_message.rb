#FayeRails와 ActiveRecord를 연걸

class ChatMessage
  def initialize(chat_id, message)
		Message.send_facebook_message(chat_id,message)
  end
end
