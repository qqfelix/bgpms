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
    ["应用","景致威"],
    ["系统","史旭天"],
    ["管理","王春宵"]
]

teams.each do |team|
  Team.create(:name => team[0],:leader => team[1])
end

["A已结案", "B已完成", "C处理中", "D方案研讨中", "E已反馈"].each { |e| Dict.create(:dict_key => '处理状态',:dict_value => e) }

["A紧急", "B重要", "C普通", "D其它"].each { |e|  Dict.create(:dict_key => '级别',:dict_value => e)}

# work_modes

work_modes = [
    "A1数据下载",
    "A2请示报告",
    "A3问题协调",
    "A4业务授权",
    "A5业务咨询",
    "A6修改数据",
    "A7删除数据",
    "A8导入数据"
]


work_modes.each { |wm| Dict.create(:dict_key => '问题类型',:dict_value => wm) }

# 问题频率新增

work_rates = [
    "A频繁",
    "B经常",
    "C很少"
]

work_rates.each { |wm| Dict.create(:dict_key => '问题频率',:dict_value => wm) }

# 项目负责人新增
work_leaders = [
    "景致威",
    "王春宵",
    "史旭天"
]
work_leaders.each { |wm| Dict.create(:dict_key => '项目负责人',:dict_value => wm) }
