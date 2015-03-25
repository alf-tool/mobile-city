module MobileCity
  class Viewpoint
    class Geolized < Viewpoint

      def user_profiles
        up.user_profiles
      end

      def pois
        restrict(up.pois, eq(:poi, context[:place]) | eq(:parent, context[:place]))
      end

      def poi_descriptions
        matching(up.poi_descriptions, pois)
      end

      def poi_images
        matching(up.poi_images, pois)
      end

      def poi_image_descriptions
        matching(up.poi_image_descriptions, poi_images)
      end

      def poi_owners
        matching(up.poi_owners, pois)
      end

    end # class Geolized
  end # class Viewpoint
end # module MobileCity
