require 'mobile_city'

db = MobileCity.connect

puts db.pois
  .restrict(sensible: false)
  .allbut([:sensible])
  .image(db.poi_descriptions, :descriptions)
  .hierarchize
  .to_text
