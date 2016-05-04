describe Event do
  context '.all' do
    before :all do
      Event.destroy_all

      @e1 = Event.create(name: :some_title, date: Date.parse('2016-05-20'))
      @e2 = Event.create(name: :some_title, date: Date.parse('2015-05-20'))
      @e3 = Event.create(name: :some_title, date: Date.parse('2016-06-20'))
    end

    it 'should return data ordering by date' do
      expect(Event.all.map(&:date).map(&:to_s)).to eql(['2015-05-20', '2016-05-20', '2016-06-20'])
    end
  end
end