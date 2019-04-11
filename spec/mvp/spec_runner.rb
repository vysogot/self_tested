require_relative '../base_spec_runner'

module MVP
  class SpecRunner < BaseSpecRunner
    describe '1. MVP (Minimum Viable Product)' do
      context '* Get input from user on how they feel' do
        it 'When they run the program they should be asked to rate their feeling' do
          expected_prompt = 'Rate how you feel from 1 to 10: ' \
            'Write a note if you want: '

          received_prompt = catch_output do
            mock_input("\n\n") do
              app.run
            end
          end

          expect(received_prompt, expected_prompt)
        end

        it 'The gradation is from 1 to 10' do
          expected_rate = '1'

          catch_output do
            mock_input("#{expected_rate}\n\n") do
              app.run
            end
          end

          received_rate = app.store.feelings.first[:rate]
          expect(received_rate, expected_rate)
        end

        it 'Each time they are welcome to leave an optional note' do
          expected_note = 'What a day!'

          catch_output do
            mock_input("\n#{expected_note}\n") do
              app.run
            end
          end

          received_note = app.store.feelings.first[:note]
          expect(received_note, expected_note)
        end
      end

      context '* Give stats to the user:' do
        it 'Every time the user wants he or she can see the feeling stats' do
          received_output = catch_output do
            mock_input("stats\n") do
              app.run
            end
          end

          expected_output = received_output.split(': ').last
          expect('Here are the stats', expected_output)
        end

        it 'Daily, weekly and monthly histograms should be available' do
        end
      end
    end
  end
end
