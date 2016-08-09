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

        response = channel.as_json
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

  # GET /api/v1/channels/:channel_name
  #
  # PARAMS: none
  #
  def channel_show
    @channel = Channel.find_by_name params["channel_name"]

    if @channel.blank?
      json = {
        :error => "Channel name '#{params["channel_name"]}' does not exist."
      }
    else
      json = @channel.as_json
    end
    render :json => json
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
    data_point = DataPoint.new
    @channel = Channel.find_by_name params["channel_name"]
    if @channel.blank?
      json = {
        :error => "Channel name '#{params["channel_name"]}' does not exist."
      }
    else
      data_point.channel = @channel
      data_point.latitude = params["latitude"] unless params["latitude"].blank?
      data_point.longitude = params["longitude"] unless params["longitude"].blank?
      data_point.values = params["values"] unless params["values"].blank?

      begin
        data_point.save!
        response = data_point.as_json
      rescue Exception => e
          # make sure we delete any records that might have been created
          data_point.destroy
          response = {
            :error => e.message
          }
      end
    end

    render :json => response
  end

  # GET /api/v1/channels/:channel_id/data_points
  #
  # PARAMS: none
  #
  def data_point_index
    @channel = Channel.find_by_name params["channel_name"]

    if @channel.blank?
      json = {
        :error => "Channel name '#{params["channel_name"]}' does not exist."
      }
    else
      json = @channel.data_points.map(&:as_json)
    end
    render :json => json
  end

end
