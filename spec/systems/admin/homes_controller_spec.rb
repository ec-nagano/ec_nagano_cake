require 'rails_helper'

RSpec.describe Admin::HomesController, type: :controller do

  describe "GET #top" do
    it "returns http success" do
      get :top
      expect(response).to have_http_status(:success)
    end
  end

end