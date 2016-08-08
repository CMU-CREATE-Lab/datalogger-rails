class Field < ActiveRecord::Base

  # TODO expand list
  # TODO enum type
  VALID_FIELD_TYPES = [
    "number", "boolean", "string", "file"
  ]

  belongs_to :channel

  validates :channel, :field_type, :name, :presence => true
  # TODO add enum type
  validates :field_type, :inclusion => { :in => VALID_FIELD_TYPES, :message => "%{value} is not a valid Field type."}
  validates :name, :uniqueness => { :case_sensitive => false, :scope => :channel, :message => "Fields in the same channel must have unique names." } # TODO validate format as well?

end
