require_relative 'support/serial_faker'

class BaseSpecRunner
  include SerialFaker

  attr_reader :app

  def initialize(app)
    @app = app
  end

  class Spec
    attr_reader :name, :method

    def initialize(name:, method:)
      @name = name
      @method = method
    end
  end

  class << self
    attr_reader :suite

    @@suite = []
    @@nest = 0

    def context(description, &block)
      @@suite << { name: description, specs: [], nest: @@nest }
      @@nest += 1
      instance_eval(&block)
      @@nest -= 1
    end

    alias describe context

    def it(description, &block)
      @@suite.last[:specs] << Spec.new(
        name: description,
        method: define_method(description.tr(' ', '_')) do
          instance_eval(&block)
        end,
      )
    end
  end

  def call
    @@suite.each do |example_group|
      nest = "  " * example_group[:nest]
      puts nest + example_group[:name]
      example_group[:specs].each do |spec|
        teardown!
        result = send(spec.method)
        print_spec(nest, spec.name, result)
      end
    end
  end

  private

  def print_spec(nest, name, result)
    color = case result
            when false
              31 # red
            when true
              32 # green
            else
              33 # yellow
            end
    puts nest + "  - \e[#{color}m#{name}\e[0m"
  end

  def teardown!
    app.store.clear!
  end

  def expect(received_value, expected_value)
    expected_value == received_value
  end
end

