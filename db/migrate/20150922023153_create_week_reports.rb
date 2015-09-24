class CreateWeekReports < ActiveRecord::Migration
  def up
    create_table :week_reports do |t|
      t.text :wr_content
      t.text :wr_plan
      t.integer :project_id
      t.integer :user_id
      t.integer :month_report_id

      t.timestamps null: false
    end

    add_index :week_reports, ['project_id','user_id','month_report_id']
  end

  def down
    drop_table :week_reports
  end
end
