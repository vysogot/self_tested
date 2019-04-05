require_relative 'store'

class App
  attr_reader :store

  def initialize
    @store = Store.new
  end

  def run
    print 'Rate how you feel from 1 to 10: '
    rate = $stdin.gets.chomp

    print 'Write a note if you want: '
    note = $stdin.gets.chomp

    store.feelings << { rate: rate, note: note }
  end
end
