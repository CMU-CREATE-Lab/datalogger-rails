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


  def self.valid_channel_fields_array?(channel_fields)
    defined_fields = []
    return false if channel_fields.blank?

    channel_fields.each do |field|
      return false if field["field_type"].blank? or field["name"].blank?
      return false unless VALID_FIELD_TYPES.include? field["field_type"]
      if defined_fields.include? field["name"].downcase
        return false
      else
        defined_fields.push field["name"].downcase
      end
    end

    return true
  end


  def as_json(options={})
    super(:only => [:name,:description,:field_type,:is_required])
  end

end
