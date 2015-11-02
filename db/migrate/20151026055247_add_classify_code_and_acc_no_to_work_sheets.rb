class AddClassifyCodeAndAccNoToWorkSheets < ActiveRecord::Migration
  def change
    add_column :work_sheets, :classify_code, :string
    add_column :work_sheets, :acc_no, :string
  end
end
