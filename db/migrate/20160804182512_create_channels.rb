class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :name
      t.text :description

      t.timestamps null: false
    end
    add_index :channels, :name, unique: true
  end
end
