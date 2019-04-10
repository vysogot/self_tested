require_relative 'db/fake_store'
require_relative 'src/app'

store = FakeStore.new
app = App.new(store)

app.run
