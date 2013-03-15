module Model

	def self.generate()
	
		f= File.open('person.txt')
		l = f.readlines
		class_name = l.map{ |e| e.split}.select{|el| el[0] =~/title/}.flatten[1].gsub(":","")
	  class_name = Object.const_set(class_name, Class.new)
		#class_name.class
	end

end