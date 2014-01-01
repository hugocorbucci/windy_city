require 'active_support/all'
require 'pry'

class Baddies < BasicObject
	def self.method_missing(name, args={})
		return Baddy.new_baddy(args.merge(name: name.to_s) )
	end

	class Baddy
		def self.validate args
			throw ArgumentError.new unless args[:display_name] && args[:hp]
		end

		def self.new_baddy args={}
			validate args
			return new_baddy_subclass_created_with args
		end

		def self.new_baddy_subclass_created_with args
			new_class = Class.new(self) do
				args.each do |attribute, value|
					define_method("#{attribute}" ) { || instance_variable_get "@#{attribute}" }
					define_method("#{attribute}=") { |new_value| instance_variable_set "@#{attribute}", new_value }
				end
				define_method("initialize") do
					args.each do |attribute, value|
						instance_variable_set("@#{attribute}", value)
					end
				end
			end
			Object.const_set args[:name].classify, new_class
			new_class
		end

		def do_attack_on subject
			if instance_variables.include? "@attack" && @attack.respond_to?(:execute_on)
				attack.execute_on(subject)
			else
				puts "This #{@name.downcase} sadly does not know how to attack. :/"
			end
		end
	end
end
