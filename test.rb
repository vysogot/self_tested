require_relative 'app'
require_relative 'mvp_spec'

app = App.new
mvp_spec = MVPSpec.new(app)

mvp_spec.run
