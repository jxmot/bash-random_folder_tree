#!/bin/bash
##
# A bash script that will create a folder tree with files
# in it.
# 
# Ths folders are named with random letters using `mktemp`,
# and the files within them are - 
#   * named randomly
#   * vary in size randomly within a range
#   * have random extensions taken from an array
# 
# Use Case: The folder tree with files that this script creates 
# is used for testing a zip archive utility.
# 
# Original source obtained from - 
#   https://github.com/eliranbz/bash_create_random_files_and_folders
#
# Extremely Modified by - 
#   https://github.com/jxmot
#       * refactored, now has functions for folder & file creation and 
#         for creating the tree that contains them
#         * removed - 
#           * the "mailer" function
#           * "script running" check and notification via the "mailer"
#           * the "Removing Spaces" code, random file contents are no 
#             longer filtered
#           * the MD5 file creation
#       * quantities of folders and files are now kept in variables
#       * random file size range is now kept in variables
#       * the name of the containing folder is now kept in a variable
#       * the bulk of the stdout messages can now be muted
#       * the tree that is created is deeper than the original
#       * fixed and added comments
#       * the current settings will place 30 folders with 310 files in
#         the containing folder
##
# settings, maximum folders and files within
NUMRDIRS=5
NUMRFILES=10
# range of random file sizes
MAXSIZE=10000
MINSIZE=2000
# the containing folder for the random tree
BASENAME=randtree
# extensions for the random files
EXTS=(md log json js php jpg png html css txt)
###########################################################
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
###########################################################
# "mutable" echoing
SILENT=true
mutecho() {
    if [ "$SILENT" = true ]; then
        return
    fi
    echo $1
}
# make randomly named folders
mkrandirs() {
    echo "Creating $NUMRDIRS random folders in $PWD"
    for i in $(seq 1 $NUMRDIRS)
    do
        mutecho $(mktemp -q -d XXXXXXX)
    done
    mutecho "$NUMRDIRS random folders have been created successfully"
}
# create randomly named files, with random oontent and random extensions
mkranfiles() {
    echo "Creating $NUMRFILES random files in $PWD"
    num_EXTS=${#EXTS[*]}
    for i in $(seq 1 $NUMRFILES)
    do
        # Random file extension
        fext="${EXTS[$((RANDOM%num_EXTS))]}"
        # Random file name and extension
		fname=`mktemp -u XXXXXXX."$fext"`
		# Random file size within a specific range
		fsize=$(($MINSIZE + $RANDOM % $MAXSIZE))
		# Add random content to files using allowed chars
        cat /dev/urandom |tr -dc A-Z-a-z-0-9-" " | head -c${1:-$fsize} > $fname
		mutecho $fname
        if [ "$INVEN" = true ]; then
            tmp=${ext_inven[$fext]}
            tmp=$((tmp+=1))
            ext_inven+=([$fext]=$tmp)
        fi
    done
}
# make a filled random folder tree
mkrantree() {
    mkrandirs
    mutecho "Creating $NUMRFILES random files"
    for dir in */;
    do
        cd $dir
        mkranfiles
        mutecho "$NUMRFILES files have been created in the $dir folder."
        mutecho "Changing to parent folder.."
        cd ..
    done
}
###########################################################
# look for the containing folder, create it necessary
if [ ! -d $BASENAME ]; then 
    mkdir $BASENAME
fi 
# enter the containing folder
cd $BASENAME
# put some files in there
mkranfiles
# make a folder tree (with files)
mkrantree
# make a tree in each of the folders
for dir in */;
do
    cd $dir
    mkrantree
    mutecho "Changing to parent folder.."
    cd ..
done
echo "Finshed in $PWD"

# show how many of each file extension we created
if [ "$INVEN" = true ]; then
    echo
    echo "File Extension Counts:"
    for x in "${!ext_inven[@]}"; do printf "[%s] = %s\n" "$x" "${ext_inven[$x]}" ; done
fi
