require_relative 'spec_helper'

set :environment, :test

describe 'Media converter Service' do
  include Rack::Test::Methods

  def app
    MediaConverterService
  end

  context "#index" do
    it "Work in progress......" do
      get "/"
      last_response.should be_ok
      last_response.body.should == "Work in progress......"
    end
  end

  context "/start_conversion" do
    it "should convert start the conversin" do
      post "/start", {:source => "./test_files/nepali_song.mp4" , :destination => "./converted", :to => "mp3"}
      last_response.should be_ok
    end
  end



end