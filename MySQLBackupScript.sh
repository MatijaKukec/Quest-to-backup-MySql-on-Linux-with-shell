#!/bin/bash

# podaci o bazi
MYSQL_USER="root"
MYSQL_PASSWORD="AAAAAAA"
DATABASE_NAME="Baza_Podataka"

cd "$(dirname -- "$0")"

# Funkcija za logiranje
function log_message() {
	# Get the current date and time
	log_timestamp=$(date +"%Y-%m-%d %H:%M:%S")

	# Log the message with timestamp to blah.log
	echo "$log_timestamp		 $1" | tee -a History.log
}

function backup_database() {
	# Provjeri da li postoje alati za napraviti backup i kompresiju
	command -v mysqldump >/dev/null 2>&1 || { log_message "Error: mysqldump not found. Install MySQL client."; exit 1; }
	command -v gzip >/dev/null 2>&1 || { log_message "Error: gzip not found. Install gzip."; exit 1; }
	
	# Trenutno vrijeme
	date_time=$(date +"%d-%m-%y_%H:%M:%S")
	log_message "$date_time"
	# Ime baze
	DATABASE_NAME="$1"
	time="$2"

	# Trenutno vrijeme
	date_time=$(date +"%d-%m-%y_%H:%M:%S")

	# Naziv datoteke backup-a
	backup_file_name="${DATABASE_NAME}_${time}d_${date_time}.sql"

	log_message "Creating backup $backup_file_name"
	# Backup baze

	mysqldump -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" "${database_name}" > "${backup_file_name}" || { log_message "Error: mysqldump command failed"; exit 1; }

	# Kompresija
	
	gzip "${backup_file_name}" || { log_message "Error: gzip compression failed"; exit 1; }

	log_message "Created gzip: ${backup_file_name}.gz"
}

for i in 1 7 30; do
	# stvori naziv za datoteku
	file_pattern="${DATABASE_NAME}_${i}"

	found=0

	# provjeri da li datoteka postoji
	for file in "${file_pattern}"*; do
		if [ -f "$file" ]; then
			file_mod_time=$(stat -c %Y "$file")
			current_time=$(date +%s)
			age=$(( (current_time - file_mod_time) / 60 / 60 / 24 ))  # Izračun u danima

			if [ "$age" -gt "$i" ]; then
				found=1
				log_message "Found and older than $age days: $file"
				log_message "Removing..."
				rm "$file"*
				log_message "Creating backup..."
				backup_database "$DATABASE_NAME" "$i"
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
		backup_database "$DATABASE_NAME" "$i"
	fi
done

