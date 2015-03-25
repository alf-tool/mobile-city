require 'test_helper'
require 'rack/test'
describe "Explorer, /" do
  include Rack::Test::Methods

  def app
    MobileCity::Explorer
  end

  it 'works' do
    header 'Accept', 'text/html'
    get '/?rels[]=pois&rels[]=poi_descriptions'
    expect(last_response).to be_ok
    expect(last_response.body).to match(/html/)
    expect(last_response.body).to match(/<td>en<\/td>/)
  end

  it 'restricts language with lang=...' do
    header 'Accept', 'text/html'
    get '/?rels[]=pois&rels[]=poi_descriptions&lang=fr'
    expect(last_response).to be_ok
    expect(last_response.body).to match(/html/)
    expect(last_response.body).not_to match(/<td>en<\/td>/)
  end

end
