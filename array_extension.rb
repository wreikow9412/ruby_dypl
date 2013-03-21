	class Array
		def select_first(args)
=begin
			res = nil
			keys_array = nil
			arr = false
			if args.values.first.class  == Array 
				keys_array= args.values.first
				arr = true
			end 
			
			each do |ele|
			    if arr == true #if array
			 		keys_array.each do |num|
			 			puts num
						if ele.send(args.keys.first) == num
						#res = ele
						#break
							return ele
						end
					end
				elsif  (args.has_key? :name) && (args.has_key? :interval) 
					if (args.has_key? :min) && (args.has_key? :max)
						min = args[:interval][:min]
			            max = args[:interval][:max]
			            puts min, max
			        end
				elsif ele.send(args.keys.first) == args.values.first #if not array 
					return ele
				
				end
			#res
		    end
=end
			if args.keys.include? :interval
				if args[:interval].include? :min
					detect do |v|
						v.send(args[:name].to_sym).to_i >= args[:interval][:min].to_i && v.send(args[:name].to_sym).to_i <= args[:interval][:max].to_i 
					end
				else
					detect do |v|
						v.send(args[:name].to_sym).to_i <= args[:interval][:max].to_i
					end
				end
			else
				key = args.keys.first.to_sym
				detect { |v| Array(args[key]).include? v.send(key) }
			end
		end
		 
		def select_all(args)	
		 if args.keys.include? :interval
				if args[:interval].include? :min
					select do |v|
						v.send(args[:name].to_sym).to_i >= args[:interval][:min].to_i && v.send(args[:name].to_sym).to_i <= args[:interval][:max].to_i 
					end
				else
					select do |v|
						v.send(args[:name].to_sym).to_i <= args[:interval][:max].to_i
					end
				end
		 else
				key = args.keys.first.to_sym
				select { |v| Array(args[key]).include? v.send(key) }
		 end
			
		#:name => 'Tobias'
		#:name => ['Tobias', 'Johan'] 
		#:name => :age, :interval => { :min => 30, :max => 32 } 
			
		end
	 end

		def method_missing(symbol,*args) #*args is array
			if symbol.id2name =~ /^select_(first|all)_where_(\w*)_is$/
			   method = %/
					def #{symbol.to_s}(args) 
						select_#{$1}(:#{$2} => args)
					end
				/
				puts method
				Array.class_eval(method)
				return send(symbol, args[0])
			elsif symbol.id2name =~ /^select_(first|all)_where_(\w*)_is_in$/
				Array.class_eval(%/
					def #{symbol.to_s}(value, value2) 
						select_#{$1}(:name => :#{$2}, :interval => {:min => value, :max => value2})
					end
				/)				
				return send(symbol, args[0], args[1])
			else
				return super #returning method_missing
			end
			
	 	 	
	 	#select_first(args) 
	 	#select_all(args)
	 end 
	
