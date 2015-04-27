note
	description: "[
	
	def make_multiplier_of(n):
	    def multiplier(x):
	        return x * n
	    return multiplier		
		http://www.programiz.com/python-programming/closure

	]"
	date: "$Date$"
	revision: "$Revision$"

class
	CLOSURES

feature -- Use the closure

	Times3:FUNCTION [ANY, TUPLE[INTEGER], INTEGER]
			-- Use: i := Times3 (10)
			-- print (i.out)
			-- 30
		do
			Result := make_multiplier_of (3)
		end


feature -- Closure

	make_multiplier_of (n: INTEGER): FUNCTION[ANY, TUPLE[INTEGER], INTEGER]
			-- Defining a multipling clousure.
		do
			Result := agent multiplier (?, n)
		end


	multiplier (x,n: INTEGER):INTEGER
			-- Multiply x * n
		do
			Result := x * n
		ensure
			multiplied: Result = x * n
		end


end
