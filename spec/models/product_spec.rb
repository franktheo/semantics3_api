require 'rails_helper'

RSpec.describe Product, type: :model do

  it "has a valid factory" do
     valid_product = FactoryGirl.build(:product, :search_term => 'Apple iPod')
     expect(valid_product).to be_valid
  end

  it "has no search_term" do
     product_no_search_term = FactoryGirl.build(:product, :search_term => nil)
     expect(product_no_search_term).to_not be_valid
  end

end
