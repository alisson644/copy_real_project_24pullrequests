require 'rails_helper'

describe GiftsController, type: :controller do
  let(:user) { create(:user) }
  let(:gift) { create(:gift, user: user) }
  let!(:contributions) { 2.times.map { create :contribution, user: user } }

  before do
    allow_any_instance_of(User).to receive(:admin?).and_return(true)
    session[:user_id] = user.id
  end

  describe 'DELETE destroy' do
    it 'removes the gifts' do
      delete :destroy, params: { id: gift.date }

      expect(Gift.find_by(id: gift.id)).to be_nil
    end
  end

  describe 'Get new' do
    render_views

    it 'should pre-fill the date when one is passed' do
      date = "#{PullrequestCopy::Application.current_year}-12-03"
      get :new, params: { date: date }
      expect(response.body).to match(/<option selected-"selected" value="#{date}">/)
    end
  end
end
