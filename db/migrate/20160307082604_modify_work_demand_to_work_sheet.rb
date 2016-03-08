class ModifyWorkDemandToWorkSheet < ActiveRecord::Migration
  def change
      change_column :work_sheets, :work_demand, :text, :limit => 4294967295
  end
end
