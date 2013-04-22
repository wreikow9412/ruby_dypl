#authors: Reiko Watanabe, Ayesha Azam (Group 6)
#this is not a complete solution

module Model
	def self.generate(file_path) 
		#CodeGeneration.class_eval('title :Newspaper') 
		#CodeGeneration.class_eval('attribute :name, String')
		
		file_name = File.basename(file_path)
		File.open(file_name).each { |line|
			if line =~ /title :(\w*)$/
				CodeGeneration.title(line)
			elsif line =~ /attribute :([^,]+),(.*)$/
				CodeGeneration.attribute(line)
			elsif line =~ /constraint :([^,]+),\s*'(.*)'$/
				CodeGeneration.constraint(line)
			end
		}
	end
	
	class CodeGeneration
		def self.title(class_name)
			@klass = Object.const_set(class_name, Class.new)	
		end
		
		def self.attribute(att_name, att_type)
		# Took hint from => http://maxivak.com/ruby-metaprogramming-and-own-attr_accessor/#codesyntax_6
			@klass.class_eval do 
				define_method(att_name) do
					instance_variable_get("@#{att_name}")
				end
			end
			
			@klass.class_eval do
				define_method("#{att_name}=") do |value|
					if value.is_a? att:_type
						instance_variable_set("@#{att_name}", value)
					else
						raise ArgumentError.new("invalid type")
					end				
				end
			end
			
			#self.class_eval("def #{att_name}=(value); @#{att_name} = value; end")
			#self.class_eval("def #{att_name}; @#{att_name}; end")
		end
		
		def constraint()
		end
		#title(:Person)
		#attribute(:name, 'String')	
	end	
	
end