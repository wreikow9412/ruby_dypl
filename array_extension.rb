#authors: Reiko Watanabe, Ayesha Azam (Group 6)

	class Array
		def select_first(args)

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
	 end 

end