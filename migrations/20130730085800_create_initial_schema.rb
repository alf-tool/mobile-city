Sequel.migration do
  up do
    create_table(:user_profiles) do
      String :user
      String :name
      String :lang
      String :age_group
      primary_key [:user]
    end
    create_table(:pois) do
      String  :poi
      String  :name
      Boolean :sensible
      String  :parent
      primary_key [:poi]
      foreign_key [:parent], :pois, :null=>false, :key=>[:poi], :deferrable=>true
    end
    create_table(:poi_owners) do
      String :poi
      String :user
      foreign_key [:poi], :pois, :null=>false, :key=>[:poi], :deferrable=>true
      foreign_key [:user], :user_profiles, :null=>false, :key=>[:user], :deferrable=>true
      primary_key [:poi]
    end
    create_table(:poi_descriptions) do
      String :poi
      String :lang
      String :age_group
      String :poi_description
      primary_key [:poi, :lang, :age_group]
      foreign_key [:poi], :pois, :null=>false, :key=>[:poi], :deferrable=>true
    end
    create_table(:poi_images) do
      String :img
      String :poi
      String :url
      primary_key [:img]
      foreign_key [:poi], :pois, :null=>false, :key=>[:poi], :deferrable=>true
    end
    create_table(:poi_image_descriptions) do
      String :img
      String :lang
      String :age_group
      String :img_description
      primary_key [:img, :lang, :age_group]
      foreign_key [:img], :poi_images, :null=>false, :key=>[:img], :deferrable=>true
    end
  end
end
