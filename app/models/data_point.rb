class DataPoint < ActiveRecord::Base

  belongs_to :channel
  has_many :data_point_field_values

  validates :channel, :latitude, :longitude, :presence => true


  # construct a hash with field names as Keys along with their associated value
  def values
    result = {}

    self.data_point_field_values.each do |field_value|
      result["#{field_value.field.name}"] = field_value.value
    end

    return result
  end

end
