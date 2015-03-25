require 'test_helper'
require 'rack/test'
describe "Explorer, /:relvar" do
  include Rack::Test::Methods

  def app
    MobileCity::Explorer
  end

  it 'works in html' do
    header 'Accept', 'text/html'
    get '/pois?lang=fr&structured=on'
    expect(last_response).to be_ok
    expect(last_response.body).to match(/table/)
  end

  it 'works in json' do
    header 'Accept', 'application/json'
    get '/pois?lang=fr&structured=on'
    expect(last_response).to be_ok
    expect(last_response.content_type).to match(/json/)
    expect(last_response.body).not_to match(/table/)
  end

  it 'works in implicit json' do
    get '/pois.json?lang=fr&structured=on'
    expect(last_response).to be_ok
    expect(last_response.content_type).to match(/json/)
    expect(last_response.body).not_to match(/table/)
  end

end
