class ProductsController < ApplicationController

   def index
      @products_all = Product.all.page(params[:page]).per(2)
   end

   def search
   end

   def search_results

      @products = get_api_results
 
      if @products
         @products.each do |product|
            unless duplicate_product?(product["sem3_id"],product["updated_at"])
               @product = Product.new(allowed_params(params[:query],product))
               @product.save
            end
         end
         render 'search_results'
      else
         flash[:results] = "Search returns no results. Please search again."
         render 'search'
      end

   end

   private

   def get_api_results
     Rails.cache.fetch(params[:query], :expires_in => 1.minute) do
         sem3 = Semantics3::Products.new(API_KEY,API_SECRET)
         sem3.products_field("search", params[:query])
         productsHash = sem3.get_products()
         if ( (productsHash["message"] != nil) && (productsHash["message"].include?("API key does not exist")))
           flash[:message] = "API key does not exist. Please provide one."
         end
         @products = productsHash["results"]
      end
   end

   def duplicate_product?(sem3_id,updated_at)
     return true if (Product.where('search_results @> ?', {sem3_id: sem3_id, updated_at: updated_at}.to_json).count >= 1)
     false
   end

   def allowed_params(term, results)
      search_term = term
      {search_term: term, search_results: results}
   end

end
