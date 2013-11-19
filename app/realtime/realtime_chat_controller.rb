class RealtimeChatController < FayeRails::Controller
  channel '/chat/*' do
    subscribe do
      puts "Received on #{channel}: #{inspect}"

      created_at = if message['created_at'] && message['created_at'].size > 0
                     Time.parse(message['created_at'])
                   else
                     Time.now
                   end
			#ChatMessage.new(message['chat_id'], message['message'])
    end
  end

  channel '/noti_push/*' do
    subscribe do
      puts "Received on #{channel}: #{inspect}"
		end
	end
end
