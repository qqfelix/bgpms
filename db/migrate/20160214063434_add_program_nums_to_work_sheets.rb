class AddProgramNumsToWorkSheets < ActiveRecord::Migration
  def change
      add_column :work_sheets, :program_nums, :string
  end
end
