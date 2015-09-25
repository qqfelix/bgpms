class AlertDictColumns < ActiveRecord::Migration
  def up
      rename_column :dicts, :key, :dict_key
      rename_column :dicts, :value, :dict_value
  end

  def down
      rename_column :dicts, :dict_key, :key
      rename_column :dicts, :dict_value, :value
  end
end
