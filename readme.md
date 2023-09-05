# Backup Spigot
Created by Daniel Kravec, by Daniel Kravec

## Description
This is a simple script that will backup your spigot server. It will create a folder with the date of the backup as the name.

## Usage

1. Edit varibles

Change the varibles, according to your spigot+docker setup.

| Varibles | Description |
| -- | -- |
| backupDir | Location where you want to save the copy of the minecraft files. |
| mainDir | The directory where the orginal minecraft files are stored for the container. |
| dockerName | Name of your docker container containing spigot run. |
| fileName | Name of your backup zip file (default is the date). |

---

2. Run file

After running this command, the script will run and copy all the data into a .zip file


I. without any flags

```bash main.bash```

II. with flags

```bash main.bash (flag1) (flag2) (more)```



## Flags
| Flags | Description |
| --- | --- |
| -s | Creates secondary backup for today if exists. |
| -f | Force backup, even if it exists for today. **!!Will delete existing backup from current day!!** |
| -h | Show the help menu. |
| -u | Unzip the tar right away. |
| -v | Shows current version of script. |
| -c | Clears the terminal before running script. |

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

### v1.1.1 (9.2023.01.26)
- Attempt to fix error with v1.1, causing it mess up the math.

### v1.1.2 (10.2023.01.26)
- Updated script logic when deciding a filename.

### v1.1.3 (11.2023.02.02)
- Fixed bug where tar wouldn't unzip into folder, due to how line was written with varibles.

### v1.1.4 (12.2023.09.03)
- Now supports different docker container names.
- Added how to run script in readme.

### v1.1.5 (13.2023.09.04)
- Created a help menu within the script.
- Changed way script is run.
  - clears terminal by default
  - Has startRun() and endRun() functions, to make it easier to understand the script.

### v1.2 (14.2023.09.05)
- Added version checking to script. (-v)
- Added comments to each function.
- Doesn't clear terminal by default, but can be done with (-c) flag.
- Mutiple flags can be added. (ex. -c -v -f)
  - Flags can be added in any order.
  - Flags will be ran in a specific order after.
- added future updates, and errors known to readme.

---
### future updates
- option to not unzip 
- change directory for backup just for one backup

### errors known:
- tar: .: file changed as we read it
- some commands are unavalible (currently commented )
