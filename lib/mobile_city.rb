require 'alf-core'
require 'alf-sequel'
require 'path'

require_relative 'mobile_city/viewpoint'
require_relative 'mobile_city/relvarer'

module MobileCity

  DEFAULT_OPTIONS = {
    viewpoint: Viewpoint::Native,
    migrations_folder: Path.dir/"../migrations"
  }

  def self.database(connspec, options = {})
    Alf.database(connspec, DEFAULT_OPTIONS.merge(options))
  end

  # Alf database on the seeds folder
  SEEDS_DB = database(Path.dir/"../seeds/base")

  # Alf database on the SQLite file
  SQLITE_DB = database(Path.dir/"../mobile-city.db")

  def self.connect(options = {})
    options = DEFAULT_OPTIONS.merge(options)
    Relvarer.new(SQLITE_DB.connection(options), options[:viewpoint])
  end

end
