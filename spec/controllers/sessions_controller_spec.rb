require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:admin) {FactoryGirl.create(:admin)}
  let(:guest) {FactoryGirl.create(:guest)}

  describe 'GET new' do
    it 'renders template' do
      get :new, {}
      expect(response).to render_template('new')
    end
  end

  describe 'POST create' do
    describe 'with valid username' do
      it 'logs the user in' do
        post :create, {username: admin.username}
        expect(session[:user_id]).to eq admin.id
      end

      it 'redirects to root_url' do
        post :create, {username: admin.username}
        #expect(response).to redirect_to root_url
        expect(response).to redirect_to search_results_product_path
      end
    end

    describe 'with invalid username' do
      it 'does not log the user in' do
        post :create, {username: 'bogus'}
        expect(session[:user_id]).to be_nil
      end

      it 're-renders the new template' do
        post :create, {username: 'bogus'}
        expect(response).to render_template('new')
      end
    end
  end

  describe 'DELETE destroy' do
    let(:valid_session) {{user_id: admin.id}}

    it 'logs the user out' do
      delete :destroy, {}, valid_session
      expect(session[:user_id]).to be_nil
    end
  end
end
