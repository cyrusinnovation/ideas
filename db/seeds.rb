# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
Category.create([{:name => 'Solution'}, {:name => 'Problem'}, { :name => 'Focus' }, { :name => 'Technology' }, {:name => 'Approach'}, {:name => 'Trend'}])
