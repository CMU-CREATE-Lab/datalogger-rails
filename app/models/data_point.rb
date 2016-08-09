class DataPoint < ActiveRecord::Base

  belongs_to :channel
  has_many :data_point_field_values

  validates :channel, :latitude, :longitude, :presence => true

  validate :contains_all_required_fields
  validate :contains_only_defined_fields
  after_save :save_field_values

  attr_accessor :values

  def values
    if @values.nil?
      @values = {}
      self.data_point_field_values.each do |field_value|
        @values["#{field_value.field.name}"] = field_value.value
      end
    end
    @values
  end


  # class methods
  def as_json(options={})
    super(:only => [:latitude,:longitude,:created_at], :methods => :values)
  end
  #

  private
  def contains_all_required_fields
    required_fields = self.channel.fields.where(:is_required => true).map{|f| f.name.downcase}
    keys = self.values.keys.map(&:downcase)
    unless required_fields.to_set.subset?(keys.to_set)
      missing_fields = (required_fields - keys).join(", ")
      errors.add(:data_point_field_values, "required field(s) missing: #{missing_fields}.")
      return
    end
  end

  def contains_only_defined_fields
    channel_fields = self.channel.fields.map{|f| f.name.downcase}
    keys = self.values.keys.map(&:downcase)
    unless keys.to_set.subset?(channel_fields.to_set)
      missing_fields = (keys - channel_fields).join(", ")
      errors.add(:data_point_field_values, "undefined field(s): #{missing_fields}.")
      return
    end
  end

  def save_field_values
    # destroy all old entries
    self.data_point_field_values.destroy_all

    self.values.keys.each do |key|
      # create DB entry for each key-value pair
      row = DataPointFieldValue.new
      row.data_point = self
      # ASSERT: this should exist, if we were validated
      row.field = Field.where(:channel_id => self.channel_id, :name => key).first
      row.value = self.values[key].to_s
      row.save
    end
  end

  # private :contains_all_required_fields, :contains_only_defined_fields, :save_field_values

end
