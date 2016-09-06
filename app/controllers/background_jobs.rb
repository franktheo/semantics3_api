class BackgroundJobs

  include SuckerPunch::Job
  workers 5

  def perform(search_terms)
    #must set expiration time to sufficient time
    #puts "search terms: " + search_terms.inspect

    Rails.cache.fetch(search_terms, :expires_in => 15.minute) do
      puts "admin accessing API for " + search_terms.inspect
      sem3 = Semantics3::Products.new(SEMANTICS3_API_KEY, SEMANTICS3_API_SECRET)
      sem3.products_field("search", search_terms)
      productsHash = sem3.get_products()
      $products = productsHash["results"]
    end
  end

end




