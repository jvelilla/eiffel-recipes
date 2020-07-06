note
	description: "Summary description for {PERSON}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PERSON

inherit

	ANY
		redefine
			out
		end


create
	make

feature {NONE} -- Implementation

	make (a_name: STRING; a_country: STRING)
		do
			name := a_name
			country := a_country
		end


feature -- Access

	country: STRING

	name: STRING


feature -- Output


	out: STRING
		do
			Result := "Name: "
			Result.append (name)
			Result.append (" - ")
			Result.append ("Country: ")
			Result.append (country)
		end

end
