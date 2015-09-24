class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :p_no
      t.string :p_level
      t.string :p_name
      t.integer :p_author
      t.string :p_owner
      t.string :p_dept
      t.date :p_begin_date
      t.date :p_end_date
      t.string :p_status
      t.text :p_description

      t.timestamps null: false
    end
  end
end
