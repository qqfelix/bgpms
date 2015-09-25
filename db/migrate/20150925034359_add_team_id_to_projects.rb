class AddTeamIdToProjects < ActiveRecord::Migration
  def up
      add_column :projects, :team_id,:integer
      add_index :projects, :team_id
  end

  def down
      remove_column :projects, :team_id
      remove_index :projects, :team_id
  end
end
