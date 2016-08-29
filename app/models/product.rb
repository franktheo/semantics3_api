class Product < ApplicationRecord

   validates :search_term, presence: true, uniqueness: true

end
