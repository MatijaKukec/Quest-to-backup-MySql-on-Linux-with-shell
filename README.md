# Quest-to-backup-MySql-on-Linux-with-shell
To use please edit the script with appropriate database name, database user and pasword.

MYSQL_USER="..."
MYSQL_PASSWORD="..."
DATABASE_NAME="..."

You can automate the process and make it daily by entering the commands:
crontab -e
and editing the last line to look like "* * * * * /patho/to/file/MySQLBackupScript.sh" this will make the cronjob to execute bash script every day. 
Instead of /patho/to/file/MySQLBackupScript.sh, enter the folder path to you file. 
You can find it if you position yourself in the folder with script and print the path with pwd.

# Quest-to-backup-MySql-on-Linux-with-shell
To use please edit the script with appropriate database name, database user and pasword.

MYSQL_USER="..."
MYSQL_PASSWORD="..."
DATABASE_NAME="..."

You can automate the process and make it daily by entering the commands:
crontab -e
and editing the last line to look like "* * * * * /patho/to/file/MySQLBackupScript.sh" this will make the cronjob to execute bash script every day. 
Instead of /patho/to/file/MySQLBackupScript.sh, enter the folder path to you file. 
You can find it if you position yourself in the folder with script and print the path with pwd.


# Quest-to-backup-MySql-on-Linux-with-shell
Za uporabu, uredite skriptu s odgovarajućim imenom baze podataka, korisnikom baze podataka i lozinkom.

MYSQL_USER="..."
MYSQL_PASSWORD="..."
DATABASE_NAME="..."

Postupak možete automatizirati i izvoditi svaki dan tako što ćete unijeti sljedeće naredbe:

crontab -e

i uredite posljednji redak tako da izgleda "* * * * * /putanja/do/datoteke/MySQLBackupScript.sh". Ovo će pokretati cronjob za izvršavanje bash skripte svaki dan.

Umjesto /putanja/do/datoteke/MySQLBackupScript.sh, unesite putanju do vaše datoteke. Možete je pronaći tako što ćete se pozicionirati u mapi sa skriptom i ispisati putanju s pwd.
