require_relative 'support/serial_faker'

class BaseSpecRunner
  include SerialFaker

  attr_reader :app

  def initialize(app)
    @app = app
  end

  def self.it(description, &block)
    define_method(description.tr(' ', '_')) do
      teardown!
      instance_eval(&block)
    end
  end

  def call
    raise "Implement this method in child"
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
