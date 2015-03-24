require 'test_helper'
module MobileCity
  describe Viewpoint, "poi_images" do
    include ViewpointHelpers

    subject{
      query{ poi_images }
    }

    context 'when a adult/fr' do
      let(:viewpoint){ Viewpoint[user_id: 'blambeau'] }

      it 'should include owned POIS' do
        kites = subject.restrict(img: "kites-1").tuple_extract
        kites.img_description.should eq("On voit ici le magasin de cerf-volants, ...")
      end

      it 'should include public POIs' do
        brussels = subject.restrict(img: "brussels-1").tuple_extract
        brussels.img_description.should eq("On voit ici la ville de Bruxelles, ...")
      end

      it 'should include sensible POIs' do
        delirium = subject.restrict(img: "delirium-1").tuple_extract
        delirium.img_description.should eq("Le fameux Delirium Cafe, ...")
      end

      it 'should not include private POIs' do
        subject.restrict(img: "chocolate-1").should be_empty
      end
    end

    context 'when a child/en' do
      let(:viewpoint){ Viewpoint[user_id: 'mdelsol'] }

      it 'should include owned POIS' do
        kites = subject.restrict(img: "chocolate-1").tuple_extract
        kites.img_description.should eq("My preferred chocolate shop is there!")
      end

      it 'should include public POIs' do
        brussels = subject.restrict(img: "brussels-1").tuple_extract
        brussels.img_description.should eq("You can see Brussels here, ...")
      end

      it 'should not include sensible POIs' do
        subject.restrict(img: "delirium-1").should be_empty
      end

      it 'should not include private POIs' do
        subject.restrict(img: "kites-1").should be_empty
      end
    end
    
  end
end
