#encoding:utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Option.create(type_name:'method', code: 0, name:'상관 없음')
Option.create(type_name:'method', code: 1, name:'직거래')
Option.create(type_name:'method', code: 2, name:'택배 거래')

Option.create(type_name:'status', code: 0, name:'판매중')
Option.create(type_name:'status', code: 1, name:'거래 중')
Option.create(type_name:'status', code: 2, name:'판매 완료')

Option.create(type_name:'evaluation', code: 0, name:'good')
Option.create(type_name:'evaluation', code: 1, name:'bad')
Option.create(type_name:'evaluation', code: 2, name:'no')

Option.create(type_name:'gender', code: 0, name:'여')
Option.create(type_name:'gender', code: 1, name:'남')
Option.create(type_name:'gender', code: 2, name:'')

Category.create(name:"전체",uplevel_id:0, end:false)
	uplevel=Category.create(name:"패션/의류", end:false)
		uplevel2=Category.create(name:"여성 의류/패션",uplevel_id:uplevel.id, end:false)
			Category.create(name:"상의",uplevel_id:uplevel2.id)
			Category.create(name:"하의",uplevel_id:uplevel2.id)
			Category.create(name:"자켓/코트/점퍼",uplevel_id:uplevel2.id)
			Category.create(name:"원피스/정장",uplevel_id:uplevel2.id)
			Category.create(name:"기타",uplevel_id:uplevel2.id)

		uplevel2=Category.create(name:"남성 의류/패션",uplevel_id:uplevel.id, end:false)
			Category.create(name:"상의",uplevel_id:uplevel2.id)
			Category.create(name:"하의",uplevel_id:uplevel2.id)
			Category.create(name:"자켓/코트/점퍼",uplevel_id:uplevel2.id)
			Category.create(name:"정장",uplevel_id:uplevel2.id)
			Category.create(name:"기타",uplevel_id:uplevel2.id)

		uplevel2=Category.create(name:"언더웨어/잠옷/내의",uplevel_id:uplevel.id, end:false)

		uplevel2=Category.create(name:"기타",uplevel_id:uplevel.id, end:false)

	uplevel=Category.create(name:"패션잡화/화장품/헤어", end:false)
		uplevel2=Category.create(name:"여성화/남성화/패션화",uplevel_id:uplevel.id, end:false)
			Category.create(name:"여성샌들",uplevel_id:uplevel2.id)
			Category.create(name:"여성단화/플랫슈즈",uplevel_id:uplevel2.id)
			Category.create(name:"펌프스/하이힐",uplevel_id:uplevel2.id)
			Category.create(name:"여성운동화",uplevel_id:uplevel2.id)
			Category.create(name:"여성부츠/부티/워커힐",uplevel_id:uplevel2.id)
			Category.create(name:"남성운동화/구두",uplevel_id:uplevel2.id)
			Category.create(name:"기타",uplevel_id:uplevel2.id)

		uplevel2=Category.create(name:"패션잡화",uplevel_id:uplevel.id, end:false)
			Category.create(name:"여성가방",uplevel_id:uplevel2.id)
			Category.create(name:"남성가방",uplevel_id:uplevel2.id)
			Category.create(name:"가방/모자/장갑",uplevel_id:uplevel2.id)
			Category.create(name:"지갑/벨트/시계",uplevel_id:uplevel2.id)
			Category.create(name:"안경/선글라스",uplevel_id:uplevel2.id)
			Category.create(name:"쥬얼리/악세사리",uplevel_id:uplevel2.id)
			Category.create(name:"기타",uplevel_id:uplevel2.id)

		uplevel2=Category.create(name:"화장품/향수/바디/헤어",uplevel_id:uplevel.id, end:false)
			Category.create(name:"기초/기능성케어",uplevel_id:uplevel2.id)
			Category.create(name:"메이크업/클렌징",uplevel_id:uplevel2.id)
			Category.create(name:"헤어/바디",uplevel_id:uplevel2.id)
			Category.create(name:"향수/미용",uplevel_id:uplevel2.id)
			Category.create(name:"남성/베이비",uplevel_id:uplevel2.id)
			Category.create(name:"기타",uplevel_id:uplevel2.id)

		uplevel2=Category.create(name:"기타",uplevel_id:uplevel.id, end:false)


	uplevel=Category.create(name:"유아동/출산/식품", end:false)
		uplevel2=Category.create(name:"유아동",uplevel_id:uplevel.id, end:false)
			Category.create(name:"유아패션",uplevel_id:uplevel2.id)
			Category.create(name:"아동패션",uplevel_id:uplevel2.id)
			Category.create(name:"유아용품",uplevel_id:uplevel2.id)
			Category.create(name:"장난감",uplevel_id:uplevel2.id)
			Category.create(name:"교육용품",uplevel_id:uplevel2.id)
			Category.create(name:"기타",uplevel_id:uplevel2.id)

		uplevel2=Category.create(name:"임부/출산",uplevel_id:uplevel.id, end:false)
			Category.create(name:"유모차/카시트/유아동안전용품",uplevel_id:uplevel2.id)
			Category.create(name:"수유용품",uplevel_id:uplevel2.id)
			Category.create(name:"임부복/임산부용품",uplevel_id:uplevel2.id)
			Category.create(name:"기타",uplevel_id:uplevel2.id)

		uplevel2=Category.create(name:"식품",uplevel_id:uplevel.id, end:false)
			Category.create(name:"신선식품",uplevel_id:uplevel2.id)
			Category.create(name:"가공식품",uplevel_id:uplevel2.id)
			Category.create(name:"건강식품",uplevel_id:uplevel2.id)
			Category.create(name:"다이어트",uplevel_id:uplevel2.id)
			Category.create(name:"기타",uplevel_id:uplevel2.id)

	uplevel=Category.create(name:"가구/리빙/건강", end:false)
		uplevel2=Category.create(name:"가구/DIY",uplevel_id:uplevel.id, end:false)
			Category.create(name:"수납가구",uplevel_id:uplevel2.id)
			Category.create(name:"쇼파/탁자",uplevel_id:uplevel2.id)
			Category.create(name:"책상/의자",uplevel_id:uplevel2.id)
			Category.create(name:"침대",uplevel_id:uplevel2.id)
			Category.create(name:"기타",uplevel_id:uplevel2.id)

		uplevel2=Category.create(name:"침구/인테리어/리빙",uplevel_id:uplevel.id, end:false)
			Category.create(name:"침구/쿠션",uplevel_id:uplevel2.id)
			Category.create(name:"인테리어/조명/커튼",uplevel_id:uplevel2.id)
			Category.create(name:"욕실/세제/제지/청소",uplevel_id:uplevel2.id)
			Category.create(name:"철물/공구/안전",uplevel_id:uplevel2.id)
			Category.create(name:"기타",uplevel_id:uplevel2.id)

		uplevel2=Category.create(name:"주방/조리기구/식기",uplevel_id:uplevel.id)
		uplevel2=Category.create(name:"건강/안마/비데/의료용품",uplevel_id:uplevel.id)
		uplevel2=Category.create(name:"기타",uplevel_id:uplevel.id)

	uplevel=Category.create(name:"스포츠/자동차", end:false)
		uplevel2=Category.create(name:"스포츠/레저",uplevel_id:uplevel.id, end:false)
			Category.create(name:"골프용품/의류",uplevel_id:uplevel2.id)
			Category.create(name:"아웃도어/캠핑/낚시",uplevel_id:uplevel2.id)
			Category.create(name:"스포츠/헬스/수영/자전거",uplevel_id:uplevel2.id)
			Category.create(name:"기타",uplevel_id:uplevel2.id)

		uplevel2=Category.create(name:"자동차/모터싸이클",uplevel_id:uplevel.id, end:false)
			Category.create(name:"자동차/자동차용품",uplevel_id:uplevel2.id)
			Category.create(name:"모터싸이클/모터싸이클용품",uplevel_id:uplevel2.id)
			Category.create(name:"기타",uplevel_id:uplevel2.id)

		uplevel2=Category.create(name:"기타",uplevel_id:uplevel.id)

	uplevel=Category.create(name:"컴퓨터/디지털/가전", end:false)
		uplevel2=Category.create(name:"컴퓨터",uplevel_id:uplevel.id, end:false)
			Category.create(name:"노트북/태블릿",uplevel_id:uplevel2.id)
			Category.create(name:"데크스탑/올인원PC/모니터",uplevel_id:uplevel2.id)
			Category.create(name:"PC부품/주변장치",uplevel_id:uplevel2.id)
			Category.create(name:"태블릿/노트북악세사리",uplevel_id:uplevel2.id)
			Category.create(name:"기타",uplevel_id:uplevel2.id)

		uplevel2=Category.create(name:"디지털",uplevel_id:uplevel.id, end:false)
			Category.create(name:"휴대폰",uplevel_id:uplevel2.id)
			Category.create(name:"카메라",uplevel_id:uplevel2.id)
			Category.create(name:"MP3/게임기/소프트웨어",uplevel_id:uplevel2.id)
			Category.create(name:"악세사리",uplevel_id:uplevel2.id)
			Category.create(name:"기타",uplevel_id:uplevel2.id)

		uplevel2=Category.create(name:"TV/냉장고/세탁기",uplevel_id:uplevel.id, end:false)
			Category.create(name:"TV",uplevel_id:uplevel2.id)
			Category.create(name:"냉장고/김치냉장고",uplevel_id:uplevel2.id)
			Category.create(name:"세탁기",uplevel_id:uplevel2.id)
			Category.create(name:"기타",uplevel_id:uplevel2.id)
		uplevel2=Category.create(name:"밥솥/믹서/오븐/주방가전",uplevel_id:uplevel.id)
		uplevel2=Category.create(name:"선풍기/에어컨/여름겨울가전",uplevel_id:uplevel.id)
		uplevel2=Category.create(name:"청소기/이미용/생활가전",uplevel_id:uplevel.id)
		uplevel2=Category.create(name:"기타",uplevel_id:uplevel.id)

	uplevel=Category.create(name:"도서/문구/여행/쿠폰", end:false)
		uplevel2=Category.create(name:"도서/티켓/쿠폰/상품권",uplevel_id:uplevel.id, end:false)
			Category.create(name:"도서/음반/DVD",uplevel_id:uplevel2.id)
			Category.create(name:"공연/스포츠/영화티켓",uplevel_id:uplevel2.id)
			Category.create(name:"쿠폰",uplevel_id:uplevel2.id)
			Category.create(name:"백화점/제화/기타상품권",uplevel_id:uplevel2.id)
			Category.create(name:"기타",uplevel_id:uplevel2.id)
		uplevel2=Category.create(name:"문구/애완/꽃/악기",uplevel_id:uplevel.id, end:false)
			Category.create(name:"문구/학용품/사무/용지",uplevel_id:uplevel2.id)
			Category.create(name:"애견/사료/애완용품",uplevel_id:uplevel2.id)
			Category.create(name:"꽃/원예/팬시/이벤트용품",uplevel_id:uplevel2.id)
			Category.create(name:"피아노/악기/취미/프라모델",uplevel_id:uplevel2.id)
			Category.create(name:"기타",uplevel_id:uplevel2.id)
		uplevel2=Category.create(name:"여행/레저/호텔/항공권",uplevel_id:uplevel.id)
		uplevel2=Category.create(name:"기타",uplevel_id:uplevel.id)

