module Model
	def self.generate() #file_path
		#CodeGeneration.class_eval('title :Tidning') 
		CodeGeneration.class_eval('attribute :name, String')
	end
	
	class CodeGeneration
		def self.title(class_name)
			Object.const_set(class_name, Class.new)	
		end
		
		def attribute(att_name, att_type)
		#http://maxivak.com/ruby-metaprogramming-and-own-attr_accessor/#codesyntax_6
			define_method(att_name) do
				instance_variable_get("@#{att_name}")
			end
			
			define_method("#{att_name}=") do |value|
				if value.is_a? att:_type
					instance_variable_set("@#{att_name}", value)
				else
					raise ArgumentError.new("invalid type")
				end				
			end
			
			#self.class_eval("def #{att_name}=(value); @#{att_name} = value; end")
			#self.class_eval("def #{att_name}; @#{att_name}; end")
		end
	end
	
	
end