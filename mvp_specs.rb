module MVPSpecs
  def they_are_asked_how_they_feel
    teardown!

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
    teardown!

    spec = 'The gradation is from 1 to 10'
    expected_rate = '1'

    mock_input("#{expected_rate}\n\n") do
      app.run
    end

    received_rate = app.store.feelings.first[:rate]
    expect(received_rate, expected_rate, spec)
  end

  def they_are_welcome_to_leave_optional_note
    teardown!

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

  def they_can_see_their_feelings_stats
    spec = 'Every time the user wants he or she can see the feeling stats'
    expect(0, 1, spec)
  end

  def they_can_get_daily_weekly_and_monthly_histograms
    spec = 'Daily, weekly and monthly histograms should be available'
    expect(0, 1, spec)
  end
end
