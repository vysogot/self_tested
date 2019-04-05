require_relative 'app'

def test(app)
  rate = '5'
  note = 'What a day!'

  $stdin = StringIO.new("#{rate}\n#{note}\n")
  $stdout = StringIO.new

  app.run

  $stdout = STDOUT

  feeling = app.store.feelings.first
  if feeling && feeling[:rate] == rate && feeling[:note] == note
    "\e[#{32}mTest passed!\e[0m"
  else
    "\e[#{31}mTest failed...\e[0m"
  end
end

app = App.new
puts test app
