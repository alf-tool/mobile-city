require 'alf-core'
require 'alf-sequel'
require 'alf-rack'
require 'path'
require 'rack/accept'
require 'sinatra/base'
require 'wlang'
require 'json'

require_relative 'ext/alf'
require_relative 'ext/rack'

require_relative 'mobile_city/viewpoint'
require_relative 'mobile_city/web_app'
require_relative 'mobile_city/app'
require_relative 'mobile_city/explorer'

module MobileCity

  DEFAULT_OPTIONS = {
    migrations_folder: Path.dir/"../migrations"
  }

  def self.database(connspec, options = {})
    Alf.database(connspec, DEFAULT_OPTIONS.merge(options))
  end

  # Alf database on the seeds folder
  SEEDS_DB = database(Path.dir/"../seeds/base")

  # Alf database on the SQLite file
  SQLITE_DB = database(Path.dir/"../mobile-city.db")

end
