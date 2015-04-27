note
	description : "Eiffel Agents"
	date        : "$Date$"
	revision    : "$Revision$"


class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
			closure_1
		end


	closure_1
		local
			c: CLOSURES
			f: FUNCTION [ANY, TUPLE[INTEGER], INTEGER]
		do
			create c
			f := c.Times3
			check
				expected_30: f (10) = 30
				expected_30: f (15) = 45
			end
		end
end
