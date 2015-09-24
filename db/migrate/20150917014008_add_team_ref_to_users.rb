class AddTeamRefToUsers < ActiveRecord::Migration
  def up
      add_column :users, :team_id, :integer
      add_index :users, :team_id
  end

  def down
      remove_column :users, :team_id, :integer
      remove_index :users, :team_id
  end
end
