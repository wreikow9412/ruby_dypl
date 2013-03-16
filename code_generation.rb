module Model

	def self.generate(file_path)
	  file_name = File.basename(file_path)
		f= File.open()
		l = f.readlines
		class_name = l.map{ |e| e.split}.select{|el| el[0] =~/title/}.flatten[1].gsub(":","")
	  class_name = Object.const_set(class_name, Class.new)
	  
	  #find attributes:
	  #l.map{|e| e.split}.select{|el| el[0] =~/attribute/}.map{|ele|ele[1].gsub(",","").gsub(":","").to_sym}

	end

=begin
	def extract_title_as_classname(array_of_lines)
		array_of_lines.map{ |e| e.split}.select{|el| el[0] =~/title/}.flatten[1].gsub(":","")
	end
=end

end