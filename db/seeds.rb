# -*- encoding : utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'active_record/fixtures'  
  
Fixtures.create_fixtures("#{Rails.root}/test/fixtures", "areas")
Fixtures.create_fixtures("#{Rails.root}/test/fixtures", "sub_areas")
Fixtures.create_fixtures("#{Rails.root}/test/fixtures", "themes")
Fixtures.create_fixtures("#{Rails.root}/test/fixtures", "facilities")
