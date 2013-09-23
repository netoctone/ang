# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

[
  ['Customer Order', '2013-05-11', 'Picking', 'Kasia Kavalski', Time.now - 2.hours, '0021', 10, 'LE11 3LH', 'Yes', 'BED'],
  ['Customer Order', '2013-06-18', 'QA', 'Judy Hill', Time.now - 1.hour, 8, '0022', 'LE11 3LH', 'No', 'BED'],
  ['Consigment Order', '2013-07-21', 'Dispatching', 'Sean Ryan', Time.now - 4.hours, '0021', 100, 'CH-1885', 'Yes', 'AIG'],
  ['Consigment Order', '2013-02-01', 'Dispatching', 'Sean Ryan', Time.now - 3.hours, '0021', 10, 'CH-1885', 'Yes', 'AIG'],
  ['Customer Order', '2013-04-01', 'Released', nil, Time.now - 1.hour, '0123', 6, 'KT24 3LK', 'Yes', 'BGS'],
  ['BOM Build (internal)', '2013-08-02', 'Building', 'Lynne Ryan', Time.now - 30.minutes, '0001', 2, nil, nil, nil],
  ['Stock Check', '2013-07-11', 'Counting', 'Sean Ryan', Time.now - 2.days, nil, nil, nil, nil]
].each do |(job_type, created_at, status, operator, status_changed_at, trolley, pick, destination, tags, school)|
  Job.create({
    job_type: job_type,
    created_at: created_at,
    status: status,
    operator: operator,
    status_changed_at: status_changed_at,
    trolley: trolley,
    pick: pick,
    destination: destination,
    tags: tags,
    school: school
  }, without_protection: true)
end
