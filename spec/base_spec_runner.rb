require_relative 'support/serial_faker'

class BaseSpecRunner
  include SerialFaker

  attr_reader :app

  class << self
    attr_reader :suite

    @@suite = []
    @@nest = 0
  end

  def initialize(app)
    @app = app
  end

  def call
    @@suite.each do |example_group|
      nest = "  " * example_group[:nest]
      puts nest + example_group[:name]
      example_group[:specs].each do |spec|
        spec_result = send(spec.method)
        color = case spec_result
                when false
                  31 # red
                when true
                  32 # green
                else
                  33 # yellow
                end

        puts nest + "  - \e[#{color}m#{spec.name}\e[0m"
      end
    end
  end

  def self.context(description, &block)
    @@suite << { name: description, specs: [], nest: @@nest }
    @@nest += 1
    instance_eval(&block)
    @@nest -= 1
  end

  class << self
    alias describe context
  end

  def self.it(description, &block)
    @@suite.last[:specs] << Spec.new(
      name: description,
      method: define_method(description.tr(' ', '_')) do
        teardown!
        instance_eval(&block)
      end,
    )
  end

  def teardown!
    app.store.clear!
  end

  def expect(received_value, expected_value)
    expected_value == received_value
  end

  class Spec
    attr_reader :name, :method

    def initialize(name:, method:)
      @name = name
      @method = method
    end
  end
end

