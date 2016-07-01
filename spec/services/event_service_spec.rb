describe EventService do
  before :all do
    User.destroy_all
    User.create(email: 'k@k.kk', password: 'kkkkkkkk', full_name: 'Denisov Denis')
  end

  context '.parse_date' do
    it 'should return today\'s date if not valid date string' do
      expect(EventService.parse_date('hello, this is invalid date')).to eql(Date.today)
    end

    it 'should correctly parse string to date with set styles' do
      expect(EventService.parse_date('2016-04')).to eql(Date.new(2016, 4))
    end
  end

  context '.parse_params' do
    let(:params) { {name: 'some title', date: '04/05/2016'} }
    let(:user)   { User.first }

    it 'should set correct date replacing the string' do
      expect(EventService.set_up_params(params, user)[:date]).to eql(Date.new(2016, 04, 05))
    end

    it 'should set correct user id' do
      expect(EventService.set_up_params(params, user)[:user]).to eql(user)
    end
  end
end