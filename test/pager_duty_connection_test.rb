require_relative "test_helper"

class PagerDutyConnectionTest < Minitest::Test
  def test_module_exists
    assert defined?(PagerDuty), "PagerDuty module should be defined"
  end

  def test_connection_class_exists
    assert defined?(PagerDuty::Connection), "PagerDuty::Connection class should be defined"
  end

  def test_version_constant_exists
    assert defined?(PagerDuty::Connection::VERSION), "VERSION constant should be defined"
  end

  def test_version_format
    assert_match(/\d+\.\d+\.\d+/, PagerDuty::Connection::VERSION, "VERSION should follow semantic versioning")
  end

  def test_api_version_constant
    assert_equal 2, PagerDuty::Connection::API_VERSION, "API_VERSION should be 2"
  end

  def test_api_prefix_constant
    assert_equal "https://api.pagerduty.com/", PagerDuty::Connection::API_PREFIX, "API_PREFIX should be correct"
  end

  def test_connection_accepts_token
    # Connection initialization should work with a token
    # This is a smoke test to ensure initialization doesn't raise unexpected errors
    connection = PagerDuty::Connection.new("test_token_123")
    assert_instance_of PagerDuty::Connection, connection
  end

  def test_connection_has_connection_attribute
    connection = PagerDuty::Connection.new("test_token_123")
    assert_respond_to connection, :connection
  end

  def test_connection_responds_to_get
    connection = PagerDuty::Connection.new("test_token_123")
    assert_respond_to connection, :get
  end

  def test_connection_responds_to_post
    connection = PagerDuty::Connection.new("test_token_123")
    assert_respond_to connection, :post
  end

  def test_connection_responds_to_put
    connection = PagerDuty::Connection.new("test_token_123")
    assert_respond_to connection, :put
  end

  def test_connection_responds_to_delete
    connection = PagerDuty::Connection.new("test_token_123")
    assert_respond_to connection, :delete
  end

  def test_file_not_found_error_exists
    assert defined?(PagerDuty::Connection::FileNotFoundError)
    assert PagerDuty::Connection::FileNotFoundError < RuntimeError
  end

  def test_api_error_exists
    assert defined?(PagerDuty::Connection::ApiError)
    assert PagerDuty::Connection::ApiError < RuntimeError
  end

  def test_rate_limit_error_exists
    assert defined?(PagerDuty::Connection::RateLimitError)
    assert PagerDuty::Connection::RateLimitError < RuntimeError
  end

  def test_unauthorized_error_exists
    assert defined?(PagerDuty::Connection::UnauthorizedError)
    assert PagerDuty::Connection::UnauthorizedError < RuntimeError
  end

  def test_forbidden_error_exists
    assert defined?(PagerDuty::Connection::ForbiddenError)
    assert PagerDuty::Connection::ForbiddenError < RuntimeError
  end

  def test_connection_with_bearer_token
    connection = PagerDuty::Connection.new("bearer_token_123", token_type: :Bearer)
    assert_instance_of PagerDuty::Connection, connection
  end

  def test_connection_with_custom_url
    custom_url = "https://custom.pagerduty.com/"
    connection = PagerDuty::Connection.new("test_token", url: custom_url)
    assert_instance_of PagerDuty::Connection, connection
  end

  def test_connection_with_invalid_token_type
    error = assert_raises(ArgumentError) do
      PagerDuty::Connection.new("test_token", token_type: :InvalidType)
    end
    assert_match(/invalid token_type/, error.message)
  end
end
