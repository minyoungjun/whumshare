#encoding:utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Option.create(type_name:'method', code: 1, name:'직거래')
Option.create(type_name:'method', code: 2, name:'택배 거래')
Option.create(type_name:'method', code: 3, name:'상관 없음')

Option.create(type_name:'status', code: 1, name:'판매중')
Option.create(type_name:'status', code: 2, name:'거래 중')
Option.create(type_name:'status', code: 3, name:'판매 완료')

Option.create(type_name:'evaluation', code: 1, name:'good')
Option.create(type_name:'evaluation', code: 2, name:'bad')
Option.create(type_name:'evaluation', code: 3, name:'no')




