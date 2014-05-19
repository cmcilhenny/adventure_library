class AddIndexToAdventure < ActiveRecord::Migration
  def change
    add_index :adventures, :guid, :unique => true
  end
end
