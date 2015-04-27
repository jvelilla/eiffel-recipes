note
	description : "project application root class"
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

			if argument_count >= 1 then
				print ("Hello World " + argument (1))
			else
				print ("Hello world")
			end

		end
end
