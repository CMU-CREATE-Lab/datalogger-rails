class AddDefaultForIsRequiredOnFields < ActiveRecord::Migration
  def change
    change_column_null :fields, :is_required, false
    change_column_default :fields, :is_required, false
  end
end
