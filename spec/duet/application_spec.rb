require 'spec_helper'
require 'duet/application'
require 'duet/endpoint'
require 'rack/test'

describe Duet::Application do
  include Rack::Test::Methods

  it 'should have the call method required by Rack' do
    expect(subject).to respond_to(:call)
  end

  context 'with a hello endpoint' do
    let!(:app) { subject }

    before do
      subject.endpoint do
        version 'v1'
        post '/hello', :hello do |env|
          [200, { 'Content-Type' => 'text/plain' }, 'Hello Duet!']
        end
      end
    end

    it 'should say hello' do
      post '/api/v1/hello'
      expect(last_response).to be_ok
      expect(last_response.body).to eq('Hello Duet!')
    end
  end
end
