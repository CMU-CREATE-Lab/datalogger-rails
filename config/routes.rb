Rails.application.routes.draw do

  # channels
  post "/api/v1/channels" => "api#channel_create"
  get "/api/v1/channels/:channel_name" => "api#channel_show"

  # datapoints
  post "/api/v1/channels/:channel_name/data_points" => "api#data_point_create"
  get "/api/v1/channels/:channel_name/data_points" => "api#data_point_index"

end
