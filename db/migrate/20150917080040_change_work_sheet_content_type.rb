class ChangeWorkSheetContentType < ActiveRecord::Migration
  def up
      rename_column :work_sheets, :work_result, :work_content
  end
  def down
      rename_column :work_sheets, :work_content, :work_result
  end
end
