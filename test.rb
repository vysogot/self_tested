require_relative 'app'

def spec(app)
  mvp_description =<<~END
  1. MVP (Minimum Viable Product):
    * Get input from user on how they feel:
  END

  puts mvp_description
  it_gets_input_on_how_the_user_feels(app)
end

def it_gets_input_on_how_the_user_feels(app)
  spec =<<-END
    - When they run the program they should be asked to rate their feeling
    - The gradation is from 1 to 10
    - Each time they are welcome to leave an optional note
  END

  rate = '5'
  note = 'What a day!'

  $stdin = StringIO.new("#{rate}\n#{note}\n")
  $stdout = StringIO.new

  app.run

  $stdout = STDOUT

  feeling = app.store.feelings.first
  if feeling && feeling[:rate] == rate && feeling[:note] == note
    "\e[#{32}m#{spec}\e[0m"
  else
    "\e[#{31}m#{spec}\e[0m"
  end
end

app = App.new
puts spec app
