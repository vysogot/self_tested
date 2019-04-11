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
    @@suite.each do |group|
      print_group(group)
      group[:specs].each do |spec|
        teardown!
        result = send(spec.method)
        print_spec(group, spec, result)
      end
    end
  end

  private

  def print_spec(group, spec, result)
    nest = "  " * group[:nest]
    color = case result
            when false
              31 # red
            when true
              32 # green
            else
              33 # yellow
            end

    fail_message = @fail || ''
    puts nest + "  - \e[#{color}m#{spec.name}\e[0m" + fail_message
  end

  def print_group(group)
    nest = "  " * group[:nest]
    puts nest + group[:name]
  end

  def teardown!
    app.store.clear!
  end

  def expect(received_value, expected_value)
    if expected_value == received_value
      true
    else
      @fail = "\nFAIL: Expected '#{expected_value}', got '#{received_value}'"
      false
    end
  end
end

