# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# 创建Team基础数据


Team.delete_all

teams = [
    "应用",
    "系统",
    "网络",
    "管理"
]

teams.each do |team|
  Team.create(:name => team)
end
