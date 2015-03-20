require 'spec_helper'
require 'duet/application'

describe Duet::Application do
  it "should have the call method required by Rack" do
    expect(subject).to respond_to(:call)
  end
end
