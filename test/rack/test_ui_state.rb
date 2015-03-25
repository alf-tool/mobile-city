require 'test_helper'
require 'rack/test'
describe Rack::UiState do
  include Rack::Test::Methods

  let(:app){
    Class.new(Sinatra::Base) do
      use Rack::UiState

      enable  :raise_errors
      enable  :dump_errors
      disable :show_exceptions

      def state
        env['ui-state']
      end

      get '/' do
        raise if state.nil?
      end

      get '/lang' do
        raise unless state.lang.is_a?(Rack::UiState::QueryVar)
        raise "#{state.lang.defined?} vs. #{params.has_key?("lang")}"\
          unless state.lang.defined? == (params.has_key?("lang") && !params["lang"].empty?)
        raise unless state.lang.en == (params["lang"] == "en")
      end

      get '/array' do
        raise unless state.a.is_a?(Rack::UiState::QueryVar)
        raise unless state.a.has1 == state.a.value.include?("has1")
      end

    end
  }

  it 'lets the tool be accessible' do
    get '/'
    expect(last_response).to be_ok
  end

  it 'let variables be queried' do
    get '/lang'
    expect(last_response).to be_ok

    get '/lang?lang='
    expect(last_response).to be_ok

    get '/lang?lang=en'
    expect(last_response).to be_ok

    get '/lang?lang=fr'
    expect(last_response).to be_ok
  end

  it 'does what expected on array param' do
    get '/array?a[]=has1&a[]=has3'
  end

end