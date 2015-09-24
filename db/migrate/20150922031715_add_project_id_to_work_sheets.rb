class AddProjectIdToWorkSheets < ActiveRecord::Migration
  def up
      add_column :work_sheets, :project_id, :integer
  end
  def down
      remove_column :work_sheets, :project_id
  end
end
