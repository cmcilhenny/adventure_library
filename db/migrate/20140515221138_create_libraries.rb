class CreateLibraries < ActiveRecord::Migration
  def change
    create_table :libraries do |t|
      t.text :url

      t.timestamps
    end
  end
end
