note
	description: "Files and Directory Recipes."
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit

	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Create a directoy
		local
			l_dir: DIRECTORY
			l_path: PATH
			l_fluent: FLUENT_FILE
		do

				-- Directories
			create l_path.make_current
			l_path := l_path.extended ("dir")

				-- Fluent File API
			create l_fluent.make_with_path (create {PATH}.make_from_string ("into_eiffel.txt"))
			l_fluent.each_file (agent  (path: PATH)
				do
					print (path.name)
					io.put_new_line
				end)
			create l_dir.make_with_path (l_path)

				-- Print both files and directories.
			entries (l_dir)
			each_dir (l_dir)
			each_file (l_dir)
			print ("%N========Recursive Directories ===========%N")
			each_recursive_dir (l_dir)

				-- Reading the Content

			create l_path.make_from_string ("into_eiffel.txt")
			read_file_line_by_line (l_path)
			create l_path.make_from_string ("no_file.txt")
			read_file_line_by_line (l_path)
			create l_path.make_from_string ("into_eiffel.txt")
			read_file_to_string (l_path)
			create l_path.make_from_string ("into_eiffel.txt")
			read_file_to_collecton (l_path)


				-- Write Content

			write_text_to_file
			append_data_to_file
			merge_file
		end

feature -- File, Directory: READ

	entries (a_dir: DIRECTORY)
			-- Show entires for the current directory `a_dir'.
		require
			a_dir.exists
		do
			print ("%N======== Files and Directories ===========%N")
			across
				a_dir.entries as ic
			loop
				print (ic.item.name)
				io.put_new_line
			end
		end

	each_dir (a_dir: DIRECTORY)
			-- Show only directories for the current directory `a_dir'.
		require
			exists: a_dir.exists
		local
			file: FILE
		do
			print ("%N========Directories ===========%N")
			across
				a_dir.entries as ic
			loop
				create {RAW_FILE} file.make_with_path (a_dir.path.extended_path (ic.item))
				if file.is_directory then
					print (ic.item.name)
					io.put_new_line
				end
			end
		end

	each_file (a_dir: DIRECTORY)
			-- Show only files for the current directory `a_dir'.
		require
			exists: a_dir.exists
		local
			file: FILE
		do
			print ("%N========Files ===========%N")
			across
				a_dir.entries as ic
			loop
				create {RAW_FILE} file.make_with_path (a_dir.path.extended_path (ic.item))
				if not file.is_directory then
					print (ic.item.name)
					io.put_new_line
				end
			end
		end

	each_recursive_dir (a_dir: DIRECTORY)
			-- Show how to traverse the entire directory tree starting at directory `a_dir'.
		local
			dir: DIRECTORY
			entry: PATH
		do
			across
				a_dir.entries as ic
			loop
				entry := ic.item
				if not (entry.is_current_symbol or else entry.is_parent_symbol) then
					create dir.make_with_path (a_dir.path.extended_path (entry))
					if dir.exists then
						print (dir.path.name)
						io.put_new_line
						each_recursive_dir (dir)
					end
				end
			end
		end

	read_file_line_by_line (a_path: PATH)
			-- Show how to read a file line by line.
			-- For binary files you can use {RAW_FILE}.
		local
			l_file: FILE
		do
			print ("============= Read file line by line====================")
			create {PLAIN_TEXT_FILE} l_file.make_with_path (a_path)
			if l_file.exists and then l_file.is_readable then
				l_file.open_read
				from
				until
					l_file.end_of_file
				loop
					l_file.read_line
					print (l_file.last_string)
					io.put_new_line
				end
				l_file.close
			else
				io.error.put_string ("Could not read, the file:[" + a_path.name + " ] does not exist")
				io.put_new_line
			end
		end

	read_file_to_string (a_path: PATH)
			-- Show how to read a file into a string
			-- For binary files you can use {RAW_FILE}.
		local
			l_file: FILE
			l_content: STRING
		do
			print ("============= Read file into string ====================")
			create {PLAIN_TEXT_FILE} l_file.make_with_path (a_path)
			if l_file.exists and then l_file.is_readable then
				l_file.open_read
				l_file.read_stream (l_file.count)
				l_content := l_file.last_string
				print (l_content)
				io.put_new_line
				l_file.close
			else
				io.error.put_string ("Could not read, the file:[" + a_path.name + " ] does not exist")
				io.put_new_line
			end
		end

	read_file_to_collecton (a_path: PATH)
			-- Show how to read a file into a Collection, ie LIST[STRING]
			-- For binary files you can use {RAW_FILE}.
		local
			l_file: FILE
			l_collection: LIST [STRING]
			l_string: STRING
		do
			print ("============= Read file into a collection ====================")
			create {PLAIN_TEXT_FILE} l_file.make_with_path (a_path)
			create {ARRAYED_LIST [STRING]} l_collection.make (10)
			if l_file.exists and then l_file.is_readable then
				l_file.open_read
				from
				until
					l_file.end_of_file
				loop
					l_file.read_line
					l_string := l_file.last_string.twin
					l_collection.force (l_string)
				end
				l_file.close
			else
				io.error.put_string ("Could not read, the file:[" + a_path.name + " ] does not exist")
				io.put_new_line
			end
			if l_collection.is_empty then
				print ("The collection is empty")
			else
					-- Iterate over the collection of lines
				across
					l_collection as ic
				loop
					print (ic.item)
					io.put_new_line
				end
			end
		end

feature -- File, Directory: Write


	write_text_to_file
			-- Show how to write text to a File
		local
			l_file: PLAIN_TEXT_FILE
		do
			create l_file.make_open_write("file.txt")
				-- Open the file `hello' for writing;
				-- create it if it does not exist
				-- Note: if the file exist, you will lost all the existig info.

				-- Write
			if l_file.exists and then l_file.is_access_writable then
				l_file.put_string ("Example: how to write text to a file")
				l_file.close
			end

				-- Read the file `file.txt'
			create l_file.make_open_read("file.txt")
			if l_file.exists and then l_file.is_readable then
				l_file.read_stream (l_file.count)
				io.put_new_line
				print (l_file.last_string)
				l_file.close
			end
		end

	append_data_to_file
			-- Show how to append data to a file
		local
				l_file: PLAIN_TEXT_FILE
		do
			create l_file.make_open_append ("new.text")
				-- Open the file `hello' for append;

			if l_file.exists and then l_file.is_writable then
				l_file.put_string ("This is a string line")
				l_file.put_new_line
				l_file.put_boolean (True)
				l_file.put_new_line
				l_file.put_integer (10)
				l_file.close
			end
		end


	merge_file
			-- Show how to merge files.
		local
			l_file: RAW_FILE
			l_merged_file: RAW_FILE
			l_path: PATH
			l_dir: DIRECTORY
		do
				-- Path merge
			create l_path.make_current
			l_path := l_path.extended ("merge")
			create l_dir.make_with_path (l_path)

			create l_merged_file.make_with_path (l_path.extended ("merged.log"))

			across
				l_dir.entries as ic
			loop
				create l_file.make_with_path (l_dir.path.extended_path (ic.item))
				if not l_file.is_directory and then l_file.is_closed then
					l_merged_file.append (l_file)
						-- I got the following exeption
						-- if (amount != fread(buffer, sizeof(char), amount, other))
						--		eise_io("FILE: unable to read appended file.");	
--					l_merged_file.open_append
--					l_file.open_read
--					l_file.read_stream (l_file.count)
--					l_merged_file.put_string (l_file.last_string)
--					l_file.close
--					l_merged_file.close
				end
			end
		end
end
