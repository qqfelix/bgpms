class CreateWorkSheets < ActiveRecord::Migration
  def change
    create_table :work_sheets do |t|
      t.datetime :work_datetime
      t.string :username
      t.string :work_type
      t.string :work_type1
      t.string :work_type2
      t.string :work_place
      t.string :work_person
      t.string :work_person_phone
      t.string :work_description
      t.string :work_demand
      t.datetime :work_benin_datetime
      t.datetime :work_end_datetime
      t.integer :user_id
      t.string :work_result
      t.string :work_status

      t.timestamps null: false
    end
  end
end
