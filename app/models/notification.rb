class Notification < ActiveRecord::Base
  attr_accessible :type, :content

	#noti_type
	#1. 신규메시지
	#2. 물품상태변화(판매자에게 구매신청내역, 구매자에게 구매수락내역),
	#3. 일정기간동안(하루, 마지막 로그인 이후) 관심검색어에 등록된 신규물품수
	def self.create_push_noti user_id, type, content
		puts "created_push_noti model"
		noti = Notification.new
		noti.user_id = user_id
		noti.type = type
		noti.content = content
		noti.save

		noti.push_alarm
	end
	def push_alarm
		puts "push_alarm model #{self.user_id}, #{self.content}"
		client = Faye::Client.new('http://share.whum.net/faye')
		
		data = {
			:type => self.type,
			:content => self.content,
			:created_at => Time.now
		}

		client.publish("/noti_push/#{self.user_id}", data)
	end
end
