require 'test_helper'
require 'rack/test'
describe "App, /" do
  include Rack::Test::Methods

  def app
    MobileCity::App
  end

  it 'works' do
    header 'Accept', 'text/html'
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to match(/html/)
    expect(last_response.body).to match(/form/)
  end

end
