require 'test_helper'
module Alf
  describe DbValue do

    let(:db_class) do
      Class.new(DbValue){
        def pois
          restrict(up.pois, poi: context[:poi])
        end
      }
    end

    let(:native) {
      DbValue::Native.new(MobileCity::SQLITE_DB.connection)
    }

    let(:db) {
      db_class.new(native, poi: 'brussels')
    }

    after do
      db.close
    end

    it 'works as expected' do
      expect(db.pois).to be_a(Relvar)
      expect(db.pois.value).to eq(Relation([{
        :poi => "brussels",
        :name => "Brussels",
        :sensible => false,
        :parent => "brussels"
      }]))
    end
    
  end
end
