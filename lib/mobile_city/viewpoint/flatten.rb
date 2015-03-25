module MobileCity
  class Viewpoint
    class Flatten < Viewpoint

      def user_profiles
        super
      end

      def pois
        join(up.pois, up.poi_descriptions)
      end

      def poi_images
        join(up.poi_images, up.poi_image_descriptions)
      end

      def poi_owners
        super
      end

    end # class Flatten
  end # class Viewpoint
end # module MobileCity
