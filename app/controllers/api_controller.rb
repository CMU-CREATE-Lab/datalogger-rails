class ApiController < ApplicationController

  # channels

  # POST /api/v1/channels
  #
  # PARAMS
  # "name" : String *
  # "description" : String
  # "fields" : Array:[ {"type" : FieldType *, "name" : String *, "description" : String, "is_required" : Boolean }[,{...}] ]
  #
  def channel_create
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
