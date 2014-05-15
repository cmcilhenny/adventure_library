class CreateLibraries < ActiveRecord::Migration
  def change
    create_table :libraries do |t|
      t.text :Url

      t.timestamps
    end
  end
end
