require 'test_helper'
module MobileCity
  describe Viewpoint::Localized do

    let(:db){
      db = Viewpoint::Base.new(SQLITE_DB.connection)
      db = Viewpoint::Localized.new(db, lang: 'fr')
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

    describe "poi_descriptions" do
      subject{
        db.poi_descriptions
      }

      it 'restrict then abstract on the language' do
        r = subject.restrict(poi: "brussels")
        expect(r.value.size).to eql(2)

        r = r.restrict(age_group: "adult")
        expect(r.tuple_extract.to_hash).to eql({
          :poi=>"brussels",
          :age_group=>"adult",
          :poi_description=>"La ville de Bruxelles est la capitale de la Belgique et un noyau de la construction européenne."
        })
      end
    end

    describe "poi_image_descriptions" do
      subject{
        db.poi_image_descriptions
      }

      it 'restrict then abstract on the language' do
        r = subject.restrict(img: "brussels-1")
        expect(r.value.size).to eql(2)

        r = r.restrict(age_group: "adult")
        expect(r.tuple_extract.to_hash).to eql({
          :img=>"brussels-1",
          :age_group=>"adult",
          :img_description=>"On voit ici la grand place de Bruxelles, décorée de son tapis de fleurs."
        })
      end
    end

  end
end
