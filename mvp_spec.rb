require_relative 'base_spec'

class MVPSpec < BaseSpec
  def run
    the_spec =<<~END
    1. MVP (Minimum Viable Product):
      * Get input from user on how they feel:
        - #{teardown!; they_are_asked_how_they_feel}
        - #{teardown!; the_gradation_is_from_1_to_10}
        - #{teardown!; they_are_welcome_to_leave_optional_note}
    END

    print the_spec
  end

  private

  def they_are_asked_how_they_feel
    spec = 'When they run the program they should be asked ' \
      'to rate their feeling'
    expected_prompt = 'Rate how you feel from 1 to 10: ' \
      'Write a note if you want: '

    received_prompt = catch_output do
      mock_input("\n\n") do
        app.run
      end
    end

    expect(received_prompt, expected_prompt, spec)
  end

  def the_gradation_is_from_1_to_10
    spec = 'The gradation is from 1 to 10'
    expected_rate = '1'

    mock_input("#{expected_rate}\n\n") do
      app.run
    end

    received_rate = app.store.feelings.first[:rate]
    expect(received_rate, expected_rate, spec)
  end

  def they_are_welcome_to_leave_optional_note
    spec = 'Each time they are welcome to leave an optional note'
    expected_note = 'What a day!'

    prompt = catch_output do
      mock_input("\n#{expected_note}\n") do
        app.run
      end
    end

    received_note = app.store.feelings.first[:note]
    expect(received_note, expected_note, spec)
  end
end
