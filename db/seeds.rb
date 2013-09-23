# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

[
  ['Customer Order', '2013-05-11', 'Picking', 'Kasia Kavalski', Time.now - 2.hours, 10, 'LE11 3LH', 'BED'],
  ['Customer Order', '2013-06-18', 'QA', 'Judy Hill', Time.now - 1.hour, 8, 'LE11 3LH', 'BED'],
  ['Consigment Order', '2013-07-21', 'Dispatching', 'Sean Ryan', Time.now - 4.hours, 100, 'CH-1885', 'AIG'],
  ['Consigment Order', '2013-02-01', 'Dispatching', 'Sean Ryan', Time.now - 3.hours, 10, 'CH-1885', 'AIG'],
  ['Customer Order', '2013-04-01', 'Released', nil, Time.now - 1.hour, 6, 'KT24 3LK', 'BGS'],
  ['BOM Build (internal)', '2013-08-02', 'Building', 'Lynne Ryan', Time.now - 30.minutes, 2, nil, nil],
  ['Stock Check', '2013-07-11', 'Counting', 'Sean Ryan', Time.now - 2.days, nil, nil]
].each do |(job_type, created_at, status, operator, status_changed_at, pick, destination, school)|
  Job.create({ job_type: job_type, created_at: created_at, status: status, operator: operator, status_changed_at: status_changed_at, pick: pick, destination: destination, school: school }, without_protection: true)
end
