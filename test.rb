class Store
  attr_accessor :feelings

  def initialize
    @feelings = []
  end
end

def app(store)
  print 'Rate how you feel from 1 to 10: '
  rate = $stdin.gets.chomp

  print 'Write a note if you want: '
  note = $stdin.gets.chomp

  store.feelings << { rate: rate, note: note }
end

def test(store)
  rate = '5'
  note = 'What a day!'

  $stdin = StringIO.new("#{rate}\n#{note}\n")
  $stdout = StringIO.new

  app(store)

  $stdout = STDOUT

  feeling = store.feelings.first
  if feeling && feeling[:rate] == rate && feeling[:note] == note
    "\e[#{32}mTest passed!\e[0m"
  else
    "\e[#{31}mTest failed...\e[0m"
  end
end

store = Store.new
puts test(store)
