require 'test_helper'
require 'rack/test'
describe "App, /pois" do
  include Rack::Test::Methods

  def app
    MobileCity::App
  end

  it 'redirect to login when invalid context' do
    header 'Accept', 'text/html'
    get '/pois'
    expect(last_response.status).to eq(302)
  end

  it 'renders the pois list when valid context' do
    header 'Accept', 'text/html'
    get '/pois?lang=fr&user=blambeau&place=brussels'
    expect(last_response.status).to eq(200)
  end

end
