note
	description: "Class with useful File features."
	date: "$Date$"
	revision: "$Revision$"

class
	FLUENT_FILE

create
	make_with_path

feature {NONE} -- Intialization

	make_with_path (a_path: PATH)
		do
			path := a_path
		ensure
			path_set: path = a_path
		end

	path: PATH
			-- Current PATH to File or Directory.

feature -- Iteration

	each_file (action: PROCEDURE [ANY, TUPLE [PATH]])
			-- Apply `action' to every file.
		require -- from TRAVERSABLE
			action_exists: action /= Void
		local
			a_dir: DIRECTORY
		do
			create a_dir.make_with_path (path)
			if a_dir.exists and then a_dir.is_readable then
				across
					a_dir.entries as ic
				loop
					action.call ([ic.item])
				end
			end
		end

end
