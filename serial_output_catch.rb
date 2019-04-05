module SerialOutputCatch
  def catch_output(&block)
    default_serial_output = $stdout

    fake_serial_output = StringIO.new
    $stdout = fake_serial_output

    block.call

    fake_serial_output.string
  ensure
    $stdout = default_serial_output
  end

  def mock_input(value, &block)
    default_serial_input = $stdin

    fake_serial_input = StringIO.new(value)
    $stdin = fake_serial_input

    block.call
  ensure
    $stdin = default_serial_input
  end
end
