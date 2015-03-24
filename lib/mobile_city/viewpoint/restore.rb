module MobileCity
  module Viewpoint
    #
    # This viewpoint restores foreign keys, supposing that `pois` and
    # `user_profiles` have been restricted using Privacy/Ethics.
    #
    # The following restorations are done:
    #   * `poi_owners`  on visible `pois` and `user_profiles`
    #   * `poi_images`  on visible `pois`
    #
    # The following restorations are not done, because it leads to an infinite
    # definition cycle when composed with Contextualized:
    #   * `poi_descriptions`
    #   * `poi_image_descriptions`
    # This will be fixed when alf-viewpoint will provide explicit `up` support.
    #
    module Restore
      include Alf::Viewpoint
      expects Native

      # Only (poi, user) pairs for visible POIs and visible owners
      def poi_owners
        intersect(
          matching(super, poi_ids),
          matching(super, user_profiles))
      end

      # Only POI descriptions for visible POIs
      # def poi_descriptions
      #   matching(super, poi_ids)
      # end

      # Only images of visible POIs
      def poi_images
        matching(super, poi_ids)
      end

      # Only image descriptions of visible images
      # def poi_image_descriptions
      #   matching(super, project(poi_images, [:img]))
      # end

    protected

      # Utility projection on ids of visible POIs
      def poi_ids
        project(pois, [:poi])
      end

    end # module Restore
  end # module Viewpoint
end # module MobileCity
