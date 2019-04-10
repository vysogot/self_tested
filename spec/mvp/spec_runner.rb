require_relative '../base_spec_runner'
require_relative 'spec_suite'

module MVP
  class SpecRunner < BaseSpecRunner
    include SpecSuite

    def call
      the_spec =<<~END
    1. MVP (Minimum Viable Product):
      * Get input from user on how they feel:
        - #{they_are_asked_how_they_feel}
        - #{the_gradation_is_from_1_to_10}
        - #{they_are_welcome_to_leave_optional_note}
      * Give stats to the user:
        - #{they_can_see_their_feelings_stats}
        - #{they_can_get_daily_weekly_and_monthly_histograms}
      END

      print the_spec
    end
  end
end
