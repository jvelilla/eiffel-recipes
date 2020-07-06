note
	description: "Summary description for {PERSON_COMPARATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PERSON_COMPARATOR

inherit

	PART_COMPARATOR [PERSON]

feature

	less_than (u, v: PERSON): BOOLEAN
			-- Is `u' considered less than `v'?
		do
			Result := u.name < v.name
		end

end
