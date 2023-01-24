# Backup Spigot
Created by Daniel Kravec, by Daniel Kravec

## Description
This is a simple script that will backup your spigot server. It will create a folder with the date of the backup as the name.

## Flags
| Flags | Description |
| --- | --- |
| -f | Force backup, even if it exists for today. Will delete. |
| -h | Show the help menu. |

## Version History
### v1.0 (1.2023.01.18)
- This is the first version of the backup script.

### v1.0.1 (2.2023.01.18)
- Added echos to see what is activly happening.

### v1.0.2 (3.2023.01.18)
- Added a check to see if the backup directory, if not it will create it.
- Added a check to see if there is a backup directory for today, if there is, it will delete it \*as long as there is a -f flag. Stands for force.

### v1.0.3 (4.2023.01.18)
- Fixed a bug where it wouldnt unzip the tar due to the name of the directory that was created.

### v1.0.4 (5.2023.01.18)
- Added better error messages.

### v1.0.5 (6.2023.01.24)
- Fixed error at launch
- removed else then, to just else