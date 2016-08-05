class DataPointFieldValue < ActiveRecord::Base
  belongs_to :datapoint
  belongs_to :field
end
