require_relative 'serial_faker'

class BaseSpec
  include SerialFaker

  attr_reader :app

  def initialize(app)
    @app = app
  end

  def teardown!
    app.store.clear!
  end

  def expect(received_value, expected_value, spec)
    if expected_value == received_value
      "\e[#{32}m#{spec}\e[0m"
    else
      "\e[#{31}m#{spec}\e[0m"
    end
  end
end
