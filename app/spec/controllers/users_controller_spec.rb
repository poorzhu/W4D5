require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  subject(:user) { User.new(username: 'example', password: 'password') }

  describe 'GET #new' do
    it 'renders the new users page' do
      get :new

      # here we check to make sure that the response renders back the new template
      expect(response).to render_template('new')
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    context 'with invalid params' do
      it 'validates the presence of username and password' do
        post :create, params: { user: { username: '' } }
        expect(response).to render_template('new')
        # expect(flash[:errors]).to be_present
      end
    end

    context 'with valid params' do
      it 'redirects to the link show page' do
        post :create, params: { user: { username: 'td', password: 'password' } }
        expect(response).to redirect_to(user_url(User.last))
      end
    end

  end

  describe 'GET #show' do
    it "renders the user's show page" do
      get :show, id: user.id

      # here we check to make sure that the response renders back the new template
      expect(response).to render_template('show')
      expect(response).to have_http_status(200)
    end
  end

end

# (new, create, show, destroy, edit, update)
