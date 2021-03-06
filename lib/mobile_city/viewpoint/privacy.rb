module MobileCity
  class Viewpoint
    class Privacy < Viewpoint

      def user_profiles
        restrict(up.user_profiles, user: context[:user])
      end

      def pois
        union(public_pois, owned_pois)
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
        matching(up.poi_owners, user_profiles)
      end

    private

      def public_pois
        not_matching(up.pois, up.poi_owners)
      end

      def owned_pois
        matching(up.pois, matching(up.poi_owners, user_profiles))
      end

    end # class Privacy
  end # class Viewpoint
end # module MobileCity
