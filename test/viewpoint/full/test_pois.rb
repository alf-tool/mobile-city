require 'test_helper'
module MobileCity
  describe Viewpoint, "pois" do
    include ViewpointHelpers

    subject{
      query{ pois }
    }

    context 'when a adult/fr' do
      let(:viewpoint){ Viewpoint[user_id: 'blambeau'] }

      it 'should include owned POIS' do
        kites = subject.restrict(poi: "kites").tuple_extract
        kites.poi_description.should eq("Magasin de cerf-volants")
      end

      it 'should include public POIs' do
        brussels = subject.restrict(poi: "brussels").tuple_extract
        brussels.poi_description.should eq("Bruxelles")
      end

      it 'should include sensible POIs' do
        delirium = subject.restrict(poi: "delirium").tuple_extract
        delirium.poi_description.should eq("Le Delirium Cafe")
      end

      it 'should not include private POIs' do
        subject.restrict(poi: "chocolate").should be_empty
      end
    end

    context 'when a child/en' do
      let(:viewpoint){ Viewpoint[user_id: 'mdelsol'] }

      it 'should include owned POIS' do
        kites = subject.restrict(poi: "chocolate").tuple_extract
        kites.poi_description.should eq("Chocolate shop")
      end

      it 'should include public POIs' do
        brussels = subject.restrict(poi: "brussels").tuple_extract
        brussels.poi_description.should eq("Brussels (the city)")
      end

      it 'should not include sensible POIs' do
        subject.restrict(poi: "delirium").should be_empty
      end

      it 'should not include private POIs' do
        subject.restrict(poi: "kites").should be_empty
      end
    end

  end
end
