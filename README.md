# Create a Random Folder Tree

A bash script that will create a folder tree with files in it.

## Details

Ths folders are named with random letters using `mktemp`, and the files within them are: 
  * named randomly
  * vary in size randomly within a range
  * have random extensions taken from an array

## Use Case

The folder tree with files that this script creates is used for testing a zip archive utility.

## Features

These are the features as compared to its [ancestor](https://github.com/eliranbz/bash_create_random_files_and_folders):
* re-factored, now has functions for folder & file creation and for creating the tree that contains them
  * **removed** - 
    * the "mailer" function
    * "script running" check and notification via the "mailer"
    * the "Removing Spaces" code, random file contents are no longer filtered
    * the MD5 file creation
  * hard coded values -  
    * quantities of folders and files are now kept in variables
    * random file size range is now kept in variables
    * the name of the containing folder is now kept in a variable
* the bulk of the `stdout` messages can now be muted
* renamed some variables
* the tree that is created is deeper than the original
* fixed and added comments
* the current settings will place 30 folders with 310 files in the containing folder

## Settings

```
# settings, maximum folders and files within
NUMRDIRS=5
NUMRFILES=10

# range of random file sizes in bytes
MAXSIZE=10000
MINSIZE=2000

# the containing folder for the random tree
BASENAME=randtree

# extensions for the random files
EXTS=(md log json js php jpg png html css)
```

```
# optional, will increment a count for each EXTS used and 
# show it at the end
INVEN=true
# this will use the EXTS array to build an array of counters
if [ "$INVEN" = true ]; then
    declare -A ext_inven
    for ext in "${EXTS[@]}"
    do
        ext_inven+=(["$ext"]=0)
    done
fi
```

```
# "mutable" echoing
SILENT=true

mutecho() {
    if [ "$SILENT" = true ]; then
        return
    fi
    echo $1
}
```

## Run the Script

This *should* run in most any bash environment. It's been tested under Windows with the Gitbash shell.

**NOTE:** Copy the script into a folder where you want the tree to be created. The script will create a *new* folder with the tree inside of it. The new folder will be named with the value of `BASENAME` in the script.

### Output Example

```
$ ./randtree.sh
Creating 5 random files in /scrap/recursmall_sub/recursmall_sub
Creating 2 random folders in /scrap/recursmall_sub/recursmall_sub
Creating 5 random files in /scrap/recursmall_sub/recursmall_sub/JayWb6z
Creating 5 random files in /scrap/recursmall_sub/recursmall_sub/vFHfuNs
Creating 2 random folders in /scrap/recursmall_sub/recursmall_sub/JayWb6z
Creating 5 random files in /scrap/recursmall_sub/recursmall_sub/JayWb6z/1TU6tMN
Creating 5 random files in /scrap/recursmall_sub/recursmall_sub/JayWb6z/KK4TXlF
Creating 2 random folders in /scrap/recursmall_sub/recursmall_sub/vFHfuNs
Creating 5 random files in /scrap/recursmall_sub/recursmall_sub/vFHfuNs/L5eKZ4y
Creating 5 random files in /scrap/recursmall_sub/recursmall_sub/vFHfuNs/T3ANT2x
Finshed in /scrap/recursmall_sub/recursmall_sub

File Inventory
[html] = 2
[jpg] = 3
[log] = 4
[txt] = 5
[js] = 2
[json] = 6
[php] = 3
[css] = 5
[md] = 2
[png] = 3
```

## Credits

The original source was obtained from https://github.com/eliranbz/bash_create_random_files_and_folders. It provided insight into `mktemp()` and `/dev/urandom`.

---
<img src="http://webexperiment.info/extcounter/mdcount.php?id=bash-random_folder_tree">
