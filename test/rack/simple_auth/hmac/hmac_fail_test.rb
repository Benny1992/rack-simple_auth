require 'test_helper.rb'

# Test HMAC Authorization Method
class HMACFailTest < Minitest::Test
  include Rack::Test::Methods

  def setup
    @secret = 'test_secret'
    @signature = 'test_signature'
  end

  def app
    Rack::SimpleAuth::HMAC.failapp
  end

  def test_fail
    uri = '/'
    content = { 'method' => 'GET', 'data' => uri }.to_json
    hash = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), @secret, content)

    assert_raises(RuntimeError) { get uri, {}, 'HTTP_AUTHORIZATION' => "#{hash}:#{@signature}" }
  end

  def test_unknown_dsl_option
    assert_raises(RuntimeError) { Rack::Builder.parse_file("#{Rack::SimpleAuth.root}/test/rack/simple_auth/hmac/config_fail_option.ru").first }
  end

  def teardown
  end
end
