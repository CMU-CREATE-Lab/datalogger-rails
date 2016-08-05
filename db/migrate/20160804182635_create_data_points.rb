class CreateDataPoints < ActiveRecord::Migration
  def change
    create_table :data_points do |t|
      t.references :channel, index: true, foreign_key: true
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
  end
end
