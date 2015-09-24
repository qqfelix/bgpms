class CreateMonthReports < ActiveRecord::Migration
  def up
    create_table :month_reports do |t|
      t.text :mr_content
      t.text :mr_plan
      t.integer :project_id
      t.integer :user_id

      t.timestamps null: false
    end

    add_index :month_reports, ['project_id','user_id']
  end

  def down
    drop_table :month_reports  
  end
end
