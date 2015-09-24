class CreateDocuments < ActiveRecord::Migration
  def up
    create_table :documents do |t|
      t.string :name
      t.integer :project_id
      t.integer :user_id
      t.timestamps null: false
    end

    add_attachment :documents, :doc
  end

  def down
    drop_table :documents
  end
end
