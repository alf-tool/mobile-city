require 'test_helper'
describe 'The constraints on seeds' do

  let(:db){ MobileCity::SEEDS_DB }

  def query(*args, &bl)
    db.connect do |conn|
      conn.query(*args, &bl)
    end
  end

  def is_key!(relvar, attrs)
    all  = query(relvar)
    proj = all.project(attrs)
    all.size.should eq(proj.size)
  end

  context 'pois' do

    it 'has unique id' do
      is_key!(:pois, [:poi])
    end
  end

  context 'poi_owners' do

    it 'has unique id' do
      is_key!(:poi_owners, [:poi])
    end

    it 'has only valid POIs' do
      query{
        not_matching(poi_owners, project(pois, [:poi]))
      }.should be_empty
    end

    it 'has only valid owners' do
      query{
        not_matching(poi_owners, user_profiles)
      }.should be_empty
    end
  end

  context 'poi_descriptions' do

    it 'has unique id' do
      is_key!(:poi_descriptions, [:poi, :lang, :age_group])
    end

    it 'has only valid POIs' do
      query{
        not_matching(poi_descriptions, project(pois, [:poi]))
      }.should be_empty
    end
  end

  context 'poi_images' do

    it 'has unique id' do
      is_key!(:poi_images, [:img])
    end

    it 'has only valid POIs' do
      query{
        not_matching(poi_images, pois)
      }.should be_empty
    end
  end

  context 'poi_image_descriptions' do

    it 'has unique id' do
      is_key!(:poi_image_descriptions, [:img, :lang, :age_group])
    end

    it 'has only valid images' do
      query{
        not_matching(poi_image_descriptions, poi_images)
      }.should be_empty
    end
  end

end
