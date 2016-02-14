class AddColumnsToWorkSheets < ActiveRecord::Migration
  def change
    #   新增问题负责人，问题类型，问题频率,问题处理状态4个字段
      add_column :work_sheets, :work_leader, :string
      add_column :work_sheets, :work_mode, :string
      add_column :work_sheets, :work_rate, :string
      add_column :work_sheets, :work_status2, :string
  end
end
