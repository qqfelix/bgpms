class ModifyWorkDescriptionToWorkSheet < ActiveRecord::Migration
  def change
      change_column :work_sheets, :work_description, :text, :limit => 4294967295
  end
end
