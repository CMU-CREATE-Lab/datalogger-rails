require 'test_helper'

class ChannelTest < ActiveSupport::TestCase

  def setup
    @testChannel = channels(:testChannel)
  end

  test "channel and fields exist" do
    assert not(@testChannel.fields.blank?)
  end

  test "all data points have required fields" do
    Channel.all.each do |channel|
      required_fields = channel.fields.where(:is_required => true)
      channel.data_points.each do |datapoint|
        fields = datapoint.data_point_field_values.map(&:field)
        assert false unless required_fields.to_set.subset? fields.to_set
      end
    end

    assert true
  end

end
