class DataPoint < ActiveRecord::Base

  belongs_to :channel
  has_many :data_point_field_values

  validates :channel, :latitude, :longitude, :presence => true

end
