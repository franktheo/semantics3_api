module SpecTestHelper   

  def login(user)
     allow(controller).to receive(:current_user).and_return(user)
  end

end
