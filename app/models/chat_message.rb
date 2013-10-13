#FayeRails와 ActiveRecord를 연걸

class ChatMessage
  def initialize(chat_id, user_id, message)
		Message.make_msg(chat_id,user_id,message)
  end
end
