require_relative 'spec_helper'



require_relative '../application'

set :environment, :test

describe 'Media converter Service' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "validates the params" do
    binding.pry
    post "/validate", {"aaa" => "bbbb"}
    binding.pry
    last_response.should be_ok
    last_response.body.should == 'Hello World'
  end
end