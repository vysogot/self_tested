require_relative 'support/serial_faker'

class BaseSpecRunner
  include SerialFaker

  attr_reader :app

  class << self
    attr_reader :suite

    @@suite = []
  end

  def initialize(app)
    @app = app
  end

  def call
    nest = ''

    @@suite.each do |example_group|
      puts nest + example_group[:name]
      example_group[:specs].each do |spec|
        if send(spec[:method]) == true
          puts nest + "  - \e[#{32}m#{spec[:name]}\e[0m"
        else
          puts nest + "  - \e[#{31}m#{spec[:name]}\e[0m"
        end
      end
      nest += "  "
    end
  end

  def self.context(description, &block)
    @@suite << { name: description, specs: [] }
    instance_eval(&block)
  end

  class << self
    alias describe context
  end

  def self.it(description, &block)
    @@suite.last[:specs] << {
      name: description,
      method: define_method(description.tr(' ', '_')) do
        teardown!
        instance_eval(&block)
      end,
    }
  end

  def teardown!
    app.store.clear!
  end

  def expect(received_value, expected_value)
    expected_value == received_value
  end
end
