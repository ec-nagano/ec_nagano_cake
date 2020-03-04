# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#adminの初期データ
Admin.create(email: "ec_nagano_cake@email", password: "password")

#categoryの初期データ
categories = ["ケーキ", "プリン", "焼き菓子", "キャンディ"]
categories.each { |category| Category.create(name: category) }