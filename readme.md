# Backup Spigot
Created by Daniel Kravec, by Daniel Kravec

## Description
This is a simple script that will backup your spigot server. It will create a folder with the date of the backup as the name.

## Flags
| Flags | Description |
| --- | --- |
| -s | Creates secondary backup for today if exists. |
| -f | Force backup, even if it exists for today. **!!Will delete existing backup from current day!!** |
| -h | Show the help menu. |
| -u | Unzip the tar right away. |

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

### v1.0.6 (7.2023.01.25)
- Added option "-u", so it unzips if wanted.

### v1.1 (8.2023.01.26)
- Worked on Jan 25, and 26.
- Created an -s option, so it will save the previous backup for the same day.
- Rewrote structure of code, each section has a decicated function. 
- commented -u code, until can have mutiple options
- future updates:
    - option to not unzip (nearly ready)
    - mutiple options 
    - temp directories for backup location/main location
