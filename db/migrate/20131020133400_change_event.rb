class ChangeEvent < ActiveRecord::Migration
  def change
    add_column :events, :all_day, :boolean, :default => false, :null => false
    add_column :events, :description, :text
    rename_column :events, :name, :title
  end
end
