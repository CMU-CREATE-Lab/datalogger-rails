class DataPointFieldValue < ActiveRecord::Base
  belongs_to :data_point
  belongs_to :field
end
