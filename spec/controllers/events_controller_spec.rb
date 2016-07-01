require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  render_views

  before :all do
    User.destroy_all
    Event.destroy_all
  end

  let(:date_in_style)  { '%d/%m/%y' }
  let(:date_out_style) { '%Y-%m'    }

  before :all do
    @user1 = User.create email: 'k@k.kk', password: 'kkkkkkkk', full_name: 'Danis Danisov'
    @user2 = User.create email: 'j@j.jj', password: 'jjjjjjjj', full_name: 'Danil Danilov'

    @event1 = Event.create name: :hello,        user: @user1, date: Date.today,  occurance: :d
    @event2 = Event.create name: 'go to store', user: @user2, date: Date.today,  occurance: :w
    @event3 = Event.create name: 'tamtamtam',   user: @user2, date: 1.month.ago, occurance: :d
  end

  describe "GET #index" do
    it 'should render index template' do
      get :index
      expect(response).to render_template :index
    end

    it 'should render "usual" template' do
      get :index, usual: true
      expect(response).to render_template :usual
    end
  end

  describe "GET #show" do
    context 'user signed in' do
      it 'should render edit and delete links' do
        sign_in @user1
        get :show, id: @event1.id
        expect(response.body).to match /id="edit"/
        expect(response.body).to match /id="delete"/
      end

      it 'should not render edit and delete links, because event not belongs to signed in user' do
        sign_in @user1
        get :show, id: @event2.id
        expect(response.body).not_to match /id="edit"/
        expect(response.body).not_to match /id="delete"/
      end
    end

    context 'user not signed in' do
      it 'should not have edit and delete links' do
        get :show, id: @event1.id
        expect(response.body).not_to match /id="edit"/
        expect(response.body).not_to match /id="delete"/
      end
    end
  end

  describe "GET #new" do
  end

  describe "GET #edit" do
  end

  describe "GET #create" do
    it 'should successfully update event information' do
      sign_in @user1
      count = Event.count
      post :create, event: { name: :creation_test, date: Date.today.strftime(date_in_style), occurance: :d }
      # Checking count increased
      expect(Event.count).to eql(count + 1)
      expect(response).to redirect_to Event.find_by_name(:creation_test)
      expect(flash[:notice]).to match /successfully created/i
    end

    it 'should redirect to form' do
      sign_in @user1
      count = Event.count
      post :create
      # Checking count increased
      expect(Event.count).to eql(count)
      expect(response).to redirect_to new_event_path
      expect(flash[:notice]).to match /there are errors/i
    end
  end

  describe "GET #update" do
    it 'should successfully update event information' do
      sign_in @user1
      post :update, id: @event1, event: { name: :bye, date: @event1.date.strftime(date_in_style) }
      expect(response).to redirect_to @event1
      expect(flash[:notice]).to match /successfully updated/i
    end
  end

  describe "GET #destroy" do
    it 'shuld delete event from db' do
      sign_in @user1
      delete :destroy, id: @event1
      expect(response).to redirect_to events_path
      expect(flash[:notice]).to match /successfully deleted/i
    end
  end

  describe 'Checking that access denided' do
    it 'should redirect to root path, because user unsigned in' do
      [:new, :edit, [:create, :post], [:update, :post], [:destroy, :delete]].each do |action|
        action, method_type = action.is_a?(Symbol) ? [action, :get] : [action[0], action[1]]
        expect(send(method_type, action, id: @event1.id)).to redirect_to root_path
      end
    end

    it 'should redirect to root path, because event do not belongs to this user' do
      sign_in @user1

      [{name: :edit, method: :get}, {name: :update, method: :post}, {name: :destroy, method: :delete}].each do |action|
        expect(send(action[:method], action[:name], id: @event2.id)).to redirect_to root_path
      end
    end
  end

end
