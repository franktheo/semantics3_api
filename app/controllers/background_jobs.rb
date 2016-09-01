class BackgroundJobs

  include SuckerPunch::Job
  workers 4

  def perform(search_terms)
    Rails.cache.fetch('placeholder', :expires_in => 1.minute) do
      puts "admin accessing API ..."
      sem3 = Semantics3::Products.new(SEMANTICS3_API_KEY, SEMANTICS3_API_SECRET)
      sem3.products_field("search", search_terms)
      productsHash = sem3.get_products()
      #if ( (productsHash["message"] != nil) && (productsHash["message"].include?("API key does not exist")))
      #  flash[:message] = "API key does not exist. Please provide one."
      #else
      #  flash[:results] = "Fetching results"
      #end
      $products = productsHash["results"]
    end

    Rails.cache.fetch(search_terms, :expires_in => 5.minutes) do
      $products
    end
    puts "cached data: " + Rails.cache.fetch(search_terms)[0].inspect

  end

end

