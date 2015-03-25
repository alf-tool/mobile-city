require 'test_helper'
require 'rack/test'
describe "App, /pois/:poi" do
  include Rack::Test::Methods

  def app
    MobileCity::App
  end

  it 'redirect to login when invalid context' do
    header 'Accept', 'text/html'
    get '/pois/brussels'
    expect(last_response.status).to eq(302)
  end

  it 'renders the poi when valid context' do
    header 'Accept', 'text/html'
    get '/pois/brussels?lang=fr&user=blambeau&place=brussels'
    expect(last_response.status).to eq(200)
  end

  it 'renders the poi when valid context' do
    header 'Accept', 'application/json'
    get '/pois/brussels?lang=fr&user=blambeau&place=brussels'
    expect(last_response.status).to eq(200)
    expect(last_response.content_type).to match(/json/)
  end

  it 'works on a children too' do
    header 'Accept', 'text/html'
    get '/pois/delirium?lang=fr&user=blambeau&place=brussels'
    expect(last_response.status).to eq(200)
  end

end
