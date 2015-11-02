class RemoveTeamIdOfWorkOneType < ActiveRecord::Migration
  def up
      remove_column :work_one_types, :team_id
  end

  def down
    add_column :work_one_types, :team_id, :integer
  end
end
