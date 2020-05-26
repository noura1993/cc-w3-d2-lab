require('pry')
require_relative('models/property')

property1 = Property.new({
    'address' => '123 Edinburgh',
    'value' => 160_000,
    'number_of_bedrooms' => 3,
    'year_built' => 2010
})

property2 = Property.new({
    'address'=> '123 Glasgow',
    'value' => 200_000,
    'number_of_bedrooms' => 3,
    'year_built' => 2012
})


binding.pry

nil