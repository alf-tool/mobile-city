require 'test_helper'
module MobileCity
  describe Viewpoint::Privacy do

    let(:db){
      db = Viewpoint::Base.new(SQLITE_DB.connection)
      db = Viewpoint::Privacy.new(db, user: 'blambeau')
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

    describe "pois" do
      subject{
        db.pois
      }

      it 'restrict to those pois owned or public' do
        r = subject
        expect(r.restrict(poi: "brussels")).not_to be_empty
        expect(r.restrict(poi: "moulin-rouge")).not_to be_empty
        expect(r.restrict(poi: "chocolate")).to be_empty
      end
    end

    describe "poi_descriptions" do
      subject{
        db.poi_descriptions
      }

      it 'restrict to those pois owned or public' do
        r = subject
        expect(r.restrict(poi: "brussels")).not_to be_empty
        expect(r.restrict(poi: "moulin-rouge")).not_to be_empty
        expect(r.restrict(poi: "chocolate")).to be_empty
      end
    end

    describe "poi_images" do
      subject{
        db.poi_images
      }

      it 'restrict to those pois owned or public' do
        r = subject
        expect(r.restrict(poi: "brussels")).not_to be_empty
        expect(r.restrict(poi: "moulin-rouge")).not_to be_empty
        expect(r.restrict(poi: "chocolate")).to be_empty
      end
    end

    describe "poi_image_descriptions" do
      subject{
        db.poi_image_descriptions
      }

      it 'restrict to those pois owned or public' do
        r = subject
        expect(r.restrict(img: "brussels-1")).not_to be_empty
        expect(r.restrict(img: "moulin-rouge-1")).not_to be_empty
        expect(r.restrict(img: "chocolate-1")).to be_empty
      end
    end

    describe "poi_owners" do
      subject{
        db.poi_owners
      }

      it 'restrict to those pois owned by the user' do
        r = subject
        expect(r.restrict(poi: "moulin-rouge")).not_to be_empty
        expect(r.restrict(poi: "chocolate")).to be_empty
      end
    end

    describe "user_profiles" do
      subject{
        db.user_profiles
      }

      it 'restrict to user only' do
        r = subject
        expect(r.restrict(user: "blambeau")).not_to be_empty
        expect(r.restrict(user: "mdelsol")).to be_empty
      end
    end

  end
end
