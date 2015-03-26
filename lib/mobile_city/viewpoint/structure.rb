module MobileCity
  class Viewpoint
    class Structure < Viewpoint

      def user_profiles
        super
      end

      def pois
        hierarchize(
          image(up.pois, up.poi_images, :images),
          [:poi], [:parent], :nearby)
      end

    end # class Structure
  end # class Viewpoint
end # module MobileCity
