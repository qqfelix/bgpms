class CreateWorkOneTypes < ActiveRecord::Migration
  def change
    create_table :work_one_types do |t|
      t.string :name
      t.integer :team_id

      t.timestamps null: false
    end
  end
end
