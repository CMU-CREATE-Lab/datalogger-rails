class Channel < ActiveRecord::Base

  has_many :fields
  has_many :data_points

  validates :name, :presence => true
  validates :name, :uniqueness => { :case_sensitive => false } # TODO validate format as well?


  def as_json(options={})
    super(:only => [:name, :description], :include => :fields)
  end

end
