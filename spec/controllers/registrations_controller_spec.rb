require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  describe '#new' do
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

  describe '#create' do
    let!(:user) { create(:user, email: 'bar@example.com') }

    let(:user_params) do
      {
        user: {
          email: 'foo@example.com',
          password: 'foobar'
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

    subject(:new_registration) { post :create, params: user_params }

    it 'redirect to root path' do
      new_registration
      expect(response).to redirect_to(root_path)
    end

    it { expect{ new_registration }.to change(User, :count).by(1) }

    it 'return to new session' do
      post :create, params: wrong_params
      expect(response).to redirect_to(new_registration_path)
    end
  end
end
