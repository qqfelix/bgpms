class CreateDicts < ActiveRecord::Migration
  def change
    create_table :dicts do |t|
      t.string :key
      t.string :value

      t.timestamps null: false
    end
  end
end
