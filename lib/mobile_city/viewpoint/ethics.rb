module MobileCity
  class Viewpoint
    class Ethics < Viewpoint

      def user_profiles
        up.user_profiles
      end

      def pois
        ite(adult?, up.pois, restrict(up.pois, sensible: false))
      end

      def poi_descriptions
        on_age_group(matching(up.poi_descriptions, pois))
      end

      def poi_images
        matching(up.poi_images, pois)
      end

      def poi_image_descriptions
        on_age_group(matching(up.poi_image_descriptions, poi_images))
      end

      def poi_owners
        matching(up.poi_owners, pois)
      end

    private

      def adult?
        restrict(age_group, age_group: "adult")
      end

      def age_group
        project(restrict(up.user_profiles, user: context[:user]), [:age_group])
      end

      def ite(test, r, s)
        union(matching(r, project(test, [])), s)
      end

      def on_age_group(r)
        allbut(matching(r, age_group), [:age_group])
      end

    end # class Ethics
  end # class Viewpoint
end # module MobileCity
