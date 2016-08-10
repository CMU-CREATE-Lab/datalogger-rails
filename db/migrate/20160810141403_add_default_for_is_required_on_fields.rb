class AddDefaultForIsRequiredOnFields < ActiveRecord::Migration
  def change
    change_column_default :fields, :is_required, false
    Field.where(:is_required => nil).each do |field|
      field.is_required = false
      field.save
    end
  end
end
