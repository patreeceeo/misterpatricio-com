require 'spec_helper'

describe BeerController do

  describe "GET 'intro'" do
    it "returns http success" do
      get 'intro'
      response.should be_success
    end
  end

end
