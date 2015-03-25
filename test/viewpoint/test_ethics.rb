require 'test_helper'
module MobileCity
  describe Viewpoint::Ethics do

    let(:db){
      db = Viewpoint::Base.new(SQLITE_DB.connection)
      db = Viewpoint::Ethics.new(db, user: user)
      db
    }

    describe "members" do
      let(:user){ 'mdelsol' }

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

    context 'when an child' do
      let(:user){ 'mdelsol' }

      it 'restricts sensible pois' do
        expect(db.pois.restrict(poi: "delirium")).to be_empty
      end

      it 'restricts poi_descriptions accordingly' do
        expect(db.poi_descriptions.restrict(poi: "delirium")).to be_empty
        expect(db.poi_descriptions.restrict(poi: "brussels").size).to eq(2)
      end

      it 'restricts poi_images accordingly' do
        expect(db.poi_images.restrict(poi: "delirium")).to be_empty
      end

      it 'restricts poi_image_descriptions accordingly' do
        expect(db.poi_image_descriptions.restrict(img: "delirium-1")).to be_empty
        expect(db.poi_image_descriptions.restrict(img: "brussels-1").size).to eq(2)
      end

      it 'restricts poi_owners accordingly' do
        expect(db.poi_owners.restrict(poi: "moulin-rouge")).to be_empty
      end
    end

    context 'when an adult' do
      let(:user){ 'blambeau' }

      it 'does not restrict sensible pois' do
        expect(db.pois.restrict(poi: "delirium")).not_to be_empty
      end

      it 'does not restrict poi descriptions' do
        expect(db.poi_descriptions.restrict(poi: "delirium")).not_to be_empty
        expect(db.poi_descriptions.restrict(poi: "delirium").size).to eq(2)
      end

      it 'does not restrict poi_images' do
        expect(db.poi_images.restrict(poi: "delirium")).not_to be_empty
      end

      it 'does not restrict poi_image_descriptions' do
        expect(db.poi_image_descriptions.restrict(img: "delirium-1")).not_to be_empty
        expect(db.poi_image_descriptions.restrict(img: "brussels-1").size).to eq(2)
      end

      it 'does not restrict poi_owners' do
        expect(db.poi_owners.restrict(poi: "moulin-rouge")).not_to be_empty
      end
    end

  end
end
