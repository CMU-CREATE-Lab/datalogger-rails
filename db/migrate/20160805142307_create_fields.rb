class CreateFields < ActiveRecord::Migration
  def change
    create_table :fields do |t|
      t.references :channel, index: true, foreign_key: true
      t.string :name
      t.string :type
      t.text :description
      t.boolean :is_required

      t.timestamps null: false
    end
  end
end
