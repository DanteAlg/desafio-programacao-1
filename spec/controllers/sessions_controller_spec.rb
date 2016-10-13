require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET #new' do
    context 'when logged' do
      let(:user) { create(:user) }

      before { session[:user_id] = user.id }

      it 'redirect to root_Path' do
        get :new
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when loggin' do
      it { expect(get :new).to be_ok }
    end
  end

  describe 'POST #create' do
    let!(:user) { create(:user) }
    let(:user_params) do
      {
        user: {
          email: user.email,
          password: user.password
        }
      }
    end

    let(:wrong_params) do
      {
        user: {
          email: user.email,
          password: '11111'
        }
      }
    end

    it 'new session' do
      post :create, params: user_params
      expect(response).to redirect_to(root_path)
    end

    it 'return to new session' do
      post :create, params: wrong_params
      expect(response).to redirect_to(new_session_path)
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { create(:user) }

    before { session[:user_id] = user.id }

    it 'return to new session' do
      delete :destroy, params: { id: user.id }
      expect(response).to redirect_to(new_session_path)
    end
  end
end
