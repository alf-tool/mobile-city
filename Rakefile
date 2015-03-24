require "rspec/core/rake_task"

desc "Run rspec integration tests"
RSpec::Core::RakeTask.new(:test) do |t|
  t.pattern = "test/**/test_*.rb"
  t.rspec_opts = ["--color", "--backtrace", "-Ilib", "-Itest"]
end

desc "Create the SQLite version of MobileCity"
task :"create-sqlite" do
  $:.unshift File.expand_path('../lib', __FILE__)
  require 'mobile_city'

  file = Path.dir/"mobile-city.db"
  file.unlink rescue nil

  MobileCity::SQLITE_DB.connect do |conn|
    conn.migrate!
    MobileCity::SEEDS_DB.connect do |seeds|
      MobileCity::Viewpoint::Native.members.each do |member|
        conn.relvar(member).affect(seeds.query(member))
      end
    end
  end
end

task :default => :test
