class ApiController < ApplicationController

  skip_before_action :verify_authenticity_token

  # channels

  # POST /api/v1/channels
  #
  # PARAMS
  # "name" : String *
  # "description" : String
  # "fields" : Array:[ {"field_type" : FieldType *, "name" : String *, "description" : String, "is_required" : Boolean }[,{...}] ]
  #
  def channel_create
    channel = Channel.new
    channel.name = params["name"] unless params["name"].blank?
    channel.description = params["description"] unless params["description"].blank?
    fields = params["fields"].blank? ? [] : params["fields"].to_a

    if Field.valid_channel_fields_array?(fields)
      result_fields = []
      begin
        channel.save!

        fields.each do |f|
          field = Field.new
          result_fields.push field

          field.name = f["name"] unless f["name"].blank?
          field.field_type = f["field_type"] unless f["field_type"].blank?
          field.description = f["description"] unless f["description"].blank?
          field.is_required = f["is_required"] unless f["is_required"].blank?
          field.channel = channel
          field.save!
        end

        response = {
          :channel_id => channel.id,
          :name => channel.name,
          :description => channel.description,
          :fields => channel.fields.map{|f| JSON.parse(f.to_json(:only => [:name,:description,:field_type,:is_required]))}
        }
      rescue Exception => e
        # make sure we delete any records that might have been created
        channel.destroy
        result_fields.each(&:destroy)
        response = {
          :error => e.message
        }
      end
    else
      response = {
        :error => "Defined fields are invalid."
      }
    end

    render :json => response, :layout => false
  end

  # GET /api/v1/channels
  #
  # PARAMS: none
  #
  def channel_index
  end

  # GET /api/v1/channels/:channel_id
  #
  # PARAMS: none
  #
  def channel_show
  end

  # datapoints

  # POST /api/v1/channels/:channel_id/data_points
  #
  # PARAMS
  # "latitude" : Double *
  # "longitude" : Double *
  # "values" : Hash:{ ["fieldName"(String) => "fieldValue"(String) ][,[...]] }
  #
  def data_point_create
  end

  # GET /api/v1/channels/:channel_id/data_points
  #
  # PARAMS: none
  #
  def data_point_index
  end

end
