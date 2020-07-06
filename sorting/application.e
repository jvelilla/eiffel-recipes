note
	description: "sorting application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS_32

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
			example_array_of_integers
			example_array_of_person
		end

feature -- Sorting Array of Integers

	example_array_of_integers
		local
			l_array: ARRAY [INTEGER]
		do
			l_array := generate_array (50)
			print ("Unsorted%N")
			l_array.do_all (agent do_print)
			sort_array (l_array)
			io.put_new_line
			print ("Sorted%N")
			l_array.do_all (agent do_print)

				-- Reverse sort			
			l_array := generate_array (50)
			print ("%NUnsorted%N")
			l_array.do_all (agent do_print)
			reverse_sort_array (l_array)
			io.put_new_line
			print ("Reverse Sorted%N")
			l_array.do_all (agent do_print)
		end

	sort_array (array: INDEXABLE [INTEGER, INTEGER])
	    local
	        l_sorter: SORTER [INTEGER]
	    do
	        create {QUICK_SORTER [INTEGER]} l_sorter.make (
	        (create {AGENT_EQUALITY_TESTER [INTEGER]}.make (
                agent (a_int1, a_int2: INTEGER): BOOLEAN
                    do
                        Result := a_int1 < a_int2
                    end))
	        )
	        l_sorter.sort (array)
	    end

	reverse_sort_array (array: INDEXABLE [INTEGER, INTEGER])
	    local
	        l_sorter: SORTER [INTEGER]
	    do
	        create {QUICK_SORTER [INTEGER]} l_sorter.make (
	        (create {AGENT_EQUALITY_TESTER [INTEGER]}.make (
                agent (a_int1, a_int2: INTEGER): BOOLEAN
                    do
                        Result := a_int1 < a_int2
                    end))
	        )
	        l_sorter.reverse_sort (array)
	    end

	generate_array (n: INTEGER): ARRAY [INTEGER]
		local
			random: RANDOM
		do
			create random.make
			create Result.make_filled (0, 1, n)
			across 1 |..| n as ic loop
				random.forth
				Result [ic.item] := random.item \\ 500
			end
		end

	do_print (a_integer: INTEGER)
		do
			print (a_integer)
			print (" ")
		end


feature -- Sorting Array of Person

	example_array_of_person
		local
			l_array: ARRAY [PERSON]
		do
			l_array := generate_array_of_person
			print ("Unsorted%N")
			l_array.do_all (agent do_print_person)
			sort_array_person (l_array)
			io.put_new_line
			print ("Sorted%N")
			l_array.do_all (agent do_print_person)

				-- Reverse sort			
			l_array := generate_array_of_person
			print ("%NUnsorted%N")
			l_array.do_all (agent do_print_person)
			reverse_sort_array_person (l_array)
			io.put_new_line
			print ("Reverse Sorted%N")
			l_array.do_all (agent do_print_person)
		end

	sort_array_person (array: INDEXABLE [PERSON, INTEGER])
	    local
	        l_sorter: SORTER [PERSON]
	    do
	        create {QUICK_SORTER [PERSON]} l_sorter.make (create {PERSON_COMPARATOR})
	        l_sorter.sort (array)
	    end

	 reverse_sort_array_person (array: INDEXABLE [PERSON, INTEGER])
	    local
	        l_sorter: SORTER [PERSON]
	    do
	        create {QUICK_SORTER [PERSON]} l_sorter.make (create {PERSON_COMPARATOR})
	        l_sorter.reverse_sort (array)
	    end


	 generate_array_of_person: ARRAY [PERSON]
	 	do
	 		create Result.make_empty
	 		Result.force (create {PERSON}.make ("Jhon", "USA"), 1)
	 		Result.force (create {PERSON}.make ("Peter", "Australia"), 2)
	 		Result.force (create {PERSON}.make ("Michael", "Germany"), 3)
	 		Result.force (create {PERSON}.make ("Alan", "France"), 4)
	 	end

	do_print_person (a_person: PERSON)
		do
			print (a_person.out)
			print (" ")
		end


end
