class CreateWorkTwoTypes < ActiveRecord::Migration
  def change
    create_table :work_two_types do |t|
      t.string :name
      t.integer :work_one_type_id

      t.timestamps null: false
    end
  end
end
