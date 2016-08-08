class DataPointFieldValue < ActiveRecord::Base

  belongs_to :data_point
  belongs_to :field

  validates :data_point, :field, :value, :presence => true

end
