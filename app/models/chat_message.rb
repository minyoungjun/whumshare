class ChatMessage
  HISTORY = 20

  attr_accessor :message, :created_at

  def initialize(chat_id, message, created_at=Time.now)
    @message = message
    @created_at = created_at
    self.class.push self
		FBMsgWorker.perform_async(4, 1, message)
  end

  def self.push(chat_message)
    @chat_messages ||= []
    @chat_messages << chat_message
    @chat_messages = @chat_messages.reverse.take(HISTORY).reverse
  end

  def self.find
    @chat_messages ||= []
  end

end
