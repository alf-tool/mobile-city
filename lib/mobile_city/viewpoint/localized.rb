module MobileCity
  class Viewpoint
    class Localized < Viewpoint

      def user_profiles
        up.user_profiles
      end

      def pois
        up.pois
      end

      def poi_descriptions
        abstract(up.poi_descriptions, lang: context[:lang])
      end

      def poi_images
        up.poi_images
      end

      def poi_image_descriptions
        abstract(up.poi_image_descriptions, lang: context[:lang])
      end

      def poi_owners
        up.poi_owners
      end

    private

      def abstract(r, on)
        allbut(restrict(r, on), on.keys)
      end

    end # class Localized
  end # class Viewpoint
end # module MobileCity
