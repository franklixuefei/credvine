# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

require 'csv'

puts "Importing countries..."
CSV.foreach(Rails.root.join("countries.csv")) do |row|
  Country.create! do |country|
    country.id = row[0]
    country.name = row[1]
  end
end

puts "Importing states..."
CSV.foreach(Rails.root.join("states.csv")) do |row|
  State.create(:name => row[0], :country_id => row[2])
end

puts "Importing catagories..."
CSV.foreach(Rails.root.join("business_catagory.csv")) do |row|
  BusinessCatagory.create! do |business|
    business.business = row[0]
  end
end

puts "Importing Email Templates..."
CSV.foreach(Rails.root.join("email_templates.csv")) do |row|
  Temptext.create! do |temp|
    temp.cust_init = row[0]
    temp.cust_success = row[1]
    temp.frien_welc_ref = row[2]
    temp.frien_post_redemp = row[3]
    temp.header_message = row[4]
  end
end

puts "Importing Incentive Types..."
CSV.foreach(Rails.root.join("incentive_types.csv")) do |row|
  IncentiveType.create! do |inc_t|
    inc_t.type_of_incentive = row[0]
    inc_t.type_of_incentive_exp = row[1]
  end
  IncentiveTypeCsi.create! do |inc_t|
    inc_t.type_of_incentive = row[0]
    inc_t.type_of_incentive_exp = row[1]
  end
  IncentiveTypeFi.create! do |inc_t|
    inc_t.type_of_incentive = row[0]
    inc_t.type_of_incentive_exp = row[1]
  end
end