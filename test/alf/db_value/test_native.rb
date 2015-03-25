require 'test_helper'
module Alf
  describe DbValue::Native do

    let(:db) {
      DbValue::Native.new(MobileCity::SQLITE_DB.connection)
    }

    after do
      db.close
    end

    it 'lets access existing relvars' do
      expect(db.pois).to be_a(Relvar)
    end
    
    it 'raises on existing relvars' do
      expect(->(){ db.no_such_one }).to raise_error(NoMethodError)
    end
    
  end
end
