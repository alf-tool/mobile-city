require 'test_helper'
module MobileCity::Viewpoint
  describe Contextualized, "poi_images" do
    include ViewpointHelpers

    let(:viewpoint){ Contextualized[user_id: 'blambeau'] }

    subject{
      query{ poi_images }
    }

    it 'should inline descriptions in user language' do
      subject.restrict(img: "brussels-1").tuple_extract[:img_description].should eq("On voit ici la ville de Bruxelles, ...")
    end

  end
end
