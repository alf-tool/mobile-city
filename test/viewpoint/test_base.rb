require 'test_helper'
module MobileCity
  describe Viewpoint::Base do

    let(:db){
      db = Viewpoint::Base.new(SQLITE_DB.connection)
      db
    }

    describe "members" do
      subject{
        db.members
      }

      it 'is as expected' do
        expect(subject).to eq([
          :user_profiles,
          :pois,
          :poi_descriptions,
          :poi_images,
          :poi_image_descriptions,
          :poi_owners
        ])
      end
    end

  end
end
