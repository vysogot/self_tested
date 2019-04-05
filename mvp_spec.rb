require_relative 'serial_output_catch'

class MVPSpec
  include SerialOutputCatch

  attr_reader :app

  def initialize(app)
    @app = app
  end

  def run
    the_spec =<<~END
    1. MVP (Minimum Viable Product):
      * Get input from user on how they feel:
        - #{they_are_asked_how_they_feel}
    #{it_gets_input_on_how_the_user_feels}
    END

    print the_spec
  end

  def they_are_asked_how_they_feel
    spec = 'When they run the program they should be asked ' \
      'to rate their feeling'

    expected_prompt = 'Rate how you feel from 1 to 10: Write a note if you want: '

    prompt = catch_output do
      mock_input("\n\n") do
        app.run
      end
    end

    if expected_prompt == prompt
      "\e[#{32}m#{spec}\e[0m"
    else
      "\e[#{31}m#{spec}\e[0m"
    end
  end

  def it_gets_input_on_how_the_user_feels
    spec =<<-END
    - The gradation is from 1 to 10
    - Each time they are welcome to leave an optional note
    END

    rate = '5'
    note = 'What a day!'

    prompt = catch_output do
      mock_input("#{rate}\n#{note}\n") do
        app.run
      end
    end

    # TODO: teardown!
    feeling = app.store.feelings.last
    if feeling && feeling[:rate] == rate && feeling[:note] == note
      "\e[#{32}m#{spec}\e[0m"
    else
      "\e[#{31}m#{spec}\e[0m"
    end
  end
end
