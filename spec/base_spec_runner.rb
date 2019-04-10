require_relative 'support/serial_faker'

class BaseSpecRunner
  include SerialFaker

  attr_reader :app

  def initialize(app)
    @app = app
  end

  def run
    raise "Implement this method"
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
