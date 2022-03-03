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
  * removed - 
    * the "mailer" function
    * "script running" check and notification via the "mailer"
    * the "Removing Spaces" code, random file contents are no longer filtered
    * the MD5 file creation
* quantities of folders and files are now kept in variables
* random file size range is now kept in variables
* the name of the containing folder is now kept in a variable
* the bulk of the `stdout` messages can now be muted
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

## Credits

The original source was obtained from https://github.com/eliranbz/bash_create_random_files_and_folders. It provided insight into `mktemp()` and `/dev/urandom`.
