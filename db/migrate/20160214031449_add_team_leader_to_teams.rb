class AddTeamLeaderToTeams < ActiveRecord::Migration
  def change
      add_column :teams, :leader, :string
  end
end
