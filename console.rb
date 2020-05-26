require('pry')
require_relative('./models/property.rb')

Property.delete_all()

property1 = Property.new({
  'address' => '89 Bouverie Road, WESTON UNDER WETHERLEY, CV33 3XG',
  'value' => 120000,
  'bedrooms' => 3,
  'build' => 'detached'
  })

property1.save()

property2 = Property.new({
  'address' => '15 Hart Road, NORTHFLEET,DA10 1ZX',
  'value' => 90000,
  'bedrooms' => 1,
  'build' => 'flat'
  })

property2.save()

property3 = Property.new({
  'address' => '57 Carriers Road, CROESERW, SA13 7GQ',
  'value' => 400000,
  'bedrooms' => 5,
  'build' => 'semi-detached'
  })

property3.save()

property1.delete()

all_the_properties = Property.all()

hart_road = Property.find(property2.id)

carriers_road = Property.find_by_address("57 Carriers Road, CROESERW, SA13 7GQ")

binding.pry
nil