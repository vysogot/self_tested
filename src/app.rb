class App
  attr_reader :store

  def initialize(store)
    @store = store
  end

  def run
    print 'Rate how you feel from 1 to 10: '
    first_input = $stdin.gets.chomp

    if first_input == "stats"
      print 'Here are the stats'
    else
      print 'Write a note if you want: '
      note = $stdin.gets.chomp

      store.feelings << { rate: first_input, note: note }
    end
  end
end
