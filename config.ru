$:.unshift File.expand_path('../lib', __FILE__)
require 'mobile_city'
require 'mobile_city/explorer'
require 'mobile_city/app'
map '/explorer' do
  run MobileCity::Explorer
end
run MobileCity::App
