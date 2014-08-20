require 'rspec'
require 'pg'
require 'active_record'
require 'shoulda-matchers'

require 'product'
require 'cashier'
require 'store'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["test"])

RSpec.configure do |config|
  config.after(:each) do
    Product.all.each { |product| product.destroy }
    Cashier.all.each { |cashier| cashier.destory }
    Store.all.each { |store| store.destory }
  end
end