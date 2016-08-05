class CreateDataPointFieldValues < ActiveRecord::Migration
  def change
    create_table :data_point_field_values do |t|
      t.references :data_point, index: true, foreign_key: true
      t.references :field, index: true, foreign_key: true
      t.text :value

      t.timestamps null: false
    end
  end
end
