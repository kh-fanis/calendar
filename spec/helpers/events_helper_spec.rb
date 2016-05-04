require 'rails_helper'

RSpec.describe EventsHelper, type: :helper do
  context '.info_text' do
    it 'should return the text' do
      expect(helper.info_text('hello', true)).to eql 'hello'
    end

    it 'should return nil, because condition we are sending is false' do
      expect(helper.info_text('hello', false)).to be_nil
    end
  end
end
