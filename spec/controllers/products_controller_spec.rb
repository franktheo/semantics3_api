require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

   describe "GET #index" do
      it "returns http success" do
         get :index
         expect(response).to have_http_status(:success)
      end

   end

  describe "GET #search" do
      it "returns http success" do
         get :search
         expect(response).to have_http_status(:success)
      end
  end

  describe "GET #search_results" do
      it "returns http success" do
         get :search_results
         expect(response).to have_http_status(:success)
      end
  end

end
