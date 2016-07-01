describe Event do
  context '.all' do
    before :all do
      Event.destroy_all

      @user = User.first

      @e1 = Event.create(name: :some_title, date: Date.parse('2016-05-20'), occurance: :d, user: @user)
      @e2 = Event.create(name: :some_title, date: Date.parse('2015-05-20'), occurance: :d, user: @user)
      @e3 = Event.create(name: :some_title, date: Date.parse('2016-06-20'), occurance: :d, user: @user)
    end

    it 'should return data ordering by date' do
      expect(Event.all.map(&:date).map(&:to_s)).to eql(['2015-05-20', '2016-05-20', '2016-06-20'])
    end
  end
end