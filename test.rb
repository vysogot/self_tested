require_relative 'db/fake_store'
require_relative 'src/app'
require_relative 'spec/mvp/spec_runner'

store = FakeStore.new
app = App.new(store)
mvp_spec_runner = MVP::SpecRunner.new(app)

mvp_spec_runner.call
