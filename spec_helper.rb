module SpecHelper
  def teardown!
    app.store.clear!
  end

  def expect(received_value, expected_value, spec)
    if expected_value == received_value
      "\e[#{32}m#{spec}\e[0m"
    else
      "\e[#{31}m#{spec}\e[0m"
    end
  end
end
