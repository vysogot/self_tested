class Store
  attr_accessor :feelings

  def initialize
    @feelings = []
  end

  def clear!
    @feelings.clear
  end
end
