require 'minitest/autorun'
require 'protobuf'
require 'hbase-jruby'
require './test_message.pb.rb'

HBase.resolve_dependency!('0.94.7')

class TestSerializationBug < MiniTest::Unit::TestCase
  def setup
    @message = TestMessage.new(:number1 => 1370561364, :number2 => 1370561408)
  end

  def test_completes_roundtrip_with_straight_serialization
    bytes           = @message.serialize_to_string.to_java_bytes
    # java bytes convert it back to a ruby string?
    string_to_parse = bytes.to_s

    parsed = TestMessage.new.parse_from_string(string_to_parse)

    assert_equal 1370561364, parsed.number1
    assert_equal 1370561408, parsed.number2
  end

  # this fails
  def test_completes_roundtrip_with_util_serialization
    bytes = HBase::Util.to_typed_bytes(:string, @message.serialize_to_string)
    string_to_parse = HBase::Util.from_bytes(:string, bytes)

    parsed = TestMessage.new.parse_from_string(string_to_parse)

    # java bytes convert it back to a ruby string?
    assert_equal 1370561364, parsed.number1
    assert_equal 1370561408, parsed.number2
  end
end
