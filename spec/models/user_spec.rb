require 'rails_helper'

RSpec.describe User, type: :model do

  it "has a valid factory" do
     valid_user = FactoryGirl.build(:user, :username => 'Obi-wan Kenobi', :role => 'admin')
     expect(valid_user).to be_valid
  end

  it "has no username" do
     user_no_username = FactoryGirl.build(:user, :username => nil)
     expect(user_no_username).to_not be_valid
  end

end
