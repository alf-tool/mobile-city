require 'mobile_city'

module ViewpointHelpers

  def connection(options = {})
    options = options.merge(viewpoint: viewpoint)
    MobileCity::SEEDS_DB.connection(options)
  end

  def query(&bl)
    connection.query(&bl)
  end

end