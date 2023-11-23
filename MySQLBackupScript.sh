#!/bin/bash

# Ime baze
# Zamjeniti s imenom baze
database_name="---"

cd "$(dirname -- "$0")"

function log_message() {
	# Get the current date and time
	log_timestamp=$(date +"%Y-%m-%d %H:%M:%S")

	# Log the message with timestamp to blah.log
	echo "$log_timestamp		 $1" | tee -a history.log
}

function backup_database() {
	# Trenutno vrijeme
	date_time=$(date +"%d-%m-%y_%H:%M:%S")
	log_message "$date_time"
	# Ime baze
	database_name="$1"
	time="$2"

	# Trenutno vrijeme
	date_time=$(date +"%d-%m-%y_%H:%M:%S")

	# Naziv datoteke backup-a
	backup_file_name="${database_name}_${time}d_${date_time}.sql"

	log_message "Creating backup $backup_file_name"
	# Backup baze
  # zamjeniti AAAAAAA s lozinkom baze
	mysqldump -u root -pAAAAAAA "${database_name}" > "${backup_file_name}"
	# Create a tarball of the backup file
	# Kompresija
	gzip "${backup_file_name}"

	log_message "Created gzip: ${backup_file_name}.gz"
}

for i in 1 7 30; do
	# Construct the file name pattern
	file_pattern="${database_name}_${i}"

	found=0

	# Check if a file starting with the pattern exists
	for file in "${file_pattern}"*; do
		if [ -f "$file" ]; then
			file_mod_time=$(stat -c %Y "$file")
			current_time=$(date +%s)
			age=$(( (current_time - file_mod_time) / 60 / 60 / 24 ))  # Calculate age in days

			if [ "$age" -gt "$i" ]; then
				found=1
				log_message "Found and older than $age days: $file"
				log_message "Removing..."
				rm "$file"*
				log_message "Creating backup..."
				backup_database "$database_name" "$i"
			elif [ "$age" -lt "$i" ]; then
				found=1
				log_message "Found and younger than $age days: $file"
				continue
			fi
		fi
	done
	if [ "$found" -eq 0 ]; then
		log_message "Not found: ${file_pattern}*"
		log_message "Creating backup..."
		backup_database "$database_name" "$i"
	fi
done

