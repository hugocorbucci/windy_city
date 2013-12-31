require 'test/unit'
require_relative '../lib/baddies.rb'

describe "Drunk Bears fan" do
	it "has drank at least two beers" do
		drunk_bears_fan = Baddies.drunk_bears_fans(display_name:'DBF', hp: 20, beers_drank:3).new
		assert drunk_bears_fan.beers_drank >= 2
	end
end
