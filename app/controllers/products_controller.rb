class ProductsController < ApplicationController

   def index
      @products_all = Product.all.page(params[:page]).per(2)
   end

   def search
   end

   def search_background
   end

   def search_results

      @products = 
        if Rails.cache.fetch(params[:query])
           puts "option 1"
           Rails.cache.fetch(params[:query])
        elsif !Product.where(search_term: params[:query]).empty?
           search_results = []
           puts "option 2"
           product_ids = Product.where(search_term: params[:query]).limit(10).pluck(:id)
           products = Product.find(product_ids[0..10])
           products.each do |product|
             search_results  << product.search_results
           end
           search_results
        else
           puts "option 3"
           get_api_results 
        end

      if @products.class == Array
         @products_paginate = Kaminari.paginate_array(@products).page(params[:page]).per(2) if @products
      else
         @products_paginate = @products.page(params[:page]).per(2) if @products
      end

      if @products
         @products.each do |product|
            puts "product: " + product.inspect
            if duplicate_product?(product["sem3_id"],product["updated_at"]) == false
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

   def search_results_background

     #unless params[:query1].empty?
     #  BackgroundJobs.perform_async(params[:query1]) 
     #end

     time = 0
     [params[:query1],params[:query2], params[:query3],params[:query4],params[:query5]].each do |job|
       unless job.empty?  
          BackgroundJobs.perform_in(time,job) 
          time += 15
       end
     end

     render 'search_background'
 
   end

   def clear_cache
     Rails.cache.clear 
     redirect_to search_background_path
   end

   private

   def get_api_results
     Rails.cache.fetch(params[:query], :expires_in => 1.minute) do
         puts "guess accessing API ... search term: " + params[:query].inspect
         sem3 = Semantics3::Products.new(SEMANTICS3_API_KEY, SEMANTICS3_API_SECRET)
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
