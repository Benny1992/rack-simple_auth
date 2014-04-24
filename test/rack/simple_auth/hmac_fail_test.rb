require 'test_helper.rb'

# Test HMAC Authorization Method
class HMACFailTest < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def setup
    @secret = 'test_secret'
    @signature = 'test_signature'
  end

  def app
    Rack::SimpleAuth.failapp
  end

  def test_fail
    uri = '/'
    content = { 'method' => 'GET', 'data' => uri }.to_json
    hash = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), @secret, content)

    assert_raises(RuntimeError) { get uri, {}, 'HTTP_AUTHORIZATION' => "#{hash}:#{@signature}" }
  end

  def test_fail_step
    out, _err = capture_io do
      Rack::Builder.parse_file("#{Rack::SimpleAuth.root}/test/config_fail_step.ru").first
    end

    assert_match('Warning: Minimum allowed stepsize is 0.01', out, 'Warning should be printed if stepsize is below 0.01')
  end

  def test_fail_tolerance
    assert_raises(RuntimeError) { Rack::Builder.parse_file("#{Rack::SimpleAuth.root}/test/config_fail_tolerance.ru").first }
  end

  def teardown
  end
end
