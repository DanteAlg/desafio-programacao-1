require 'rails_helper'

RSpec.describe PurchasesController, type: :controller do
  let!(:user) { create(:user) }

  describe 'GET #index' do
    context 'when logged' do
      before { session[:user_id] = user.id }

      let!(:purchases) { create_list(:purchase, 3) }

      before { get :index }

      it 'return all purchases' do
        expect(assigns(:purchases)).to eq(purchases)
      end

      it 'return gross revenues' do
        expect(assigns(:gross_revenues)).to eq(30.0)
      end
    end

    context 'when user loggout' do
      it 'redirect to new session' do
        get :index
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  describe 'POST #create' do
    before { session[:user_id] = user.id }

    subject(:create_purchases) do
      post :create, params: {
        purchases: { file: fixture_file_upload('files/example_input.tab') }
      }
    end

    it 'create purchases' do
      expect{ create_purchases }.to change(Purchase, :count).by(4)
    end
  end
end
