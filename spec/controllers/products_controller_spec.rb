require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  before (:each) do
    user = FactoryGirl.create(:user, :username => 'Obi-wan Kenobi', :role => 'admin')
    login(user)
  end

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

  describe "GET #search_background" do
    it "returns http success" do
      get :search_background
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #search_results_background" do
    it "returns http success" do
      get :search_results_background, query1: 'Sharp TV', query2: 'SONY TV', query3: 'Toshiba TV', query4: 'Dell Laptop',query5: 'HP Laptop'
      Wait.until_true! { Rails.cache.fetch('Sharp TV')[0]} 
      expect(Rails.cache.fetch('Sharp TV')[0]).to have_text(/Sharp/i)

      Wait.until_true! { Rails.cache.fetch('SONY TV')[0]} 
      expect(Rails.cache.fetch('SONY TV')[0]).to have_text(/Sony/i)

      Wait.until_true! { Rails.cache.fetch('Toshiba TV')[0]} 
      expect(Rails.cache.fetch('Toshiba TV')[0]).to have_text(/Toshiba/i)

      Wait.until_true! { Rails.cache.fetch('Dell Laptop')[0]} 
      expect(Rails.cache.fetch('Dell Laptop')[0]).to have_text(/Dell/i)

      Wait.until_true! { Rails.cache.fetch('HP Laptop')[0]} 
      expect(Rails.cache.fetch('HP Laptop')[0]).to have_text(/HP/i)

    end
  end

  describe "GET #search_results" do
  
    it "get cached data" do
      get :search_results, query: 'Sharp TV'
      expect(Rails.cache.fetch('Sharp TV')[0]).to have_text('Sharp TV')
    end

    it "get DB data" do
      get :search_results, query: 'Apple iphone'
      product_ids = Product.where(search_term: 'Apple iphone').limit(10).pluck(:id)
      products = Product.find(product_ids[0])
      expect(products.search_results).to have_text('Apple iPhone')
      expect(response).to have_http_status(:success)
    end

    it "do API access and check cached data" do
      get :search_results, query: 'Samsung Galaxy 7S'
      expect(Rails.cache.fetch('Samsung Galaxy 7S')[0]).to have_text('Samsung Galaxy')
      expect(response).to have_http_status(:success)
    end

    it "returns no results" do
      get :search_results, query: ''
      expect(flash[:results]).to have_text('Search returns no results. Please search again.')
    end

   it "check if API key is incorrect or doesn't exist" do
      API_KEY = ENV['SEMANTIC3_API_KEY']
      SEMANTICS3_API_KEY = "BOGUS API KEY"
      get :search_results, query: 'ASUS Laptop'
      expect(flash[:message]).to have_text('API key does not exist. Please provide one.')
      SEMANTICS3_API_KEY = API_KEY
    end

  end

end
