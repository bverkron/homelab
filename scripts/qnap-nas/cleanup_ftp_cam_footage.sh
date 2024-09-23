#!/bin/bash
# BV: Source -> https://forum.qnap.com/viewtopic.php?f=25&t=126533&start=15
#
# delete-old-stuff.sh
#
# This version was coded on 2016/11/19 by OneCD and you can blame him if it all goes horribly wrong. ;)
#
# Recursively remove all files from the specified paths if the last-modification age exceeds a threshold.
# Then remove all empty directories from the same path.
#
# Tested with QTS 4.2.2 #20161102 on QNAP NAS with 'Entware-ng' and 'GNU findutils'.

default_age="30"    # delete file if it was last-modified more than this many days ago.
verbose=true        # if 'true', show messages. Change to 'false' to hide output.
errors=true         # if 'true', show errors. Change to 'false' to hide output.
dryrun=true         # if 'true', don't delete anything - only show what would be deleted. Change to 'false' to actually delete stuff.

find_bin="/opt/bin/find"

if [ ! -e "$find_bin" ] ; then
    [ "$errors" == "true" ] && echo "! find binary not found at expected location! :("
    exit 1
fi

if [ -z "$(${find_bin} --version | grep -F "GNU findutils")" ] ; then
    [ "$errors" == "true" ] && echo "! find binary is not GNU find! :("
    exit 1
fi

DeleteOldDirs()
    {

    # $1 = path to find old files in.
    # $2 = (optional) non-default age to check for.

    [ "$verbose" == "true" ] && echo

    if [ ! -n "$1" ] || [ -z "${1// }" ] ; then
        [ "$errors" == "true" ] && echo "! A path was not specified! :("
        return 1
    fi

    if [ "$1" == "/" ] ; then
        [ "$errors" == "true" ] && echo "! No, you don't want to do that. :)"
        return 1
    fi

    [ -n "$2" ] && age="$2" || age="$default_age"

    if [ "$dryrun" == "true" ] ; then
        [ "$verbose" == "true" ] && echo "- showing files older than [$age] days in [$1] ..."
        "$find_bin" "$1" -type f -mtime +${age} -exec echo {} \;
    else
        [ "$verbose" == "true" ] && echo "- deleting files older than [$age] days in [$1] ..."
        # BV: TO DO: account for verbose setting in echo portion of this command. Right now it will echo all deleted files regardless of verbose setting
        # This was done as a quick fix to get output confirmation of deleted files but breaks verbose=false scenarios 
        "$find_bin" "$1" -type f -mtime +${age} -exec rm {} \; -exec echo {} \;

        [ "$verbose" == "true" ] && echo "- deleting empty directories from [$1] ..."
        "$find_bin" "$1" -type d -empty -delete
    fi

    }

# Specify your paths here. Must end with '/'. Optionally specify a different age in days. Some examples are:
# DeleteOldDirs "/share/Public/"

# And some examples of paths that will be REJECTED:
# DeleteOldDirs ""
# DeleteOldDirs " "
# DeleteOldDirs "/"

# Put delete commands you want to actually run here. Commands above this will be dry runs... 
dryrun=false
DeleteOldDirs "/share/MD0_DATA/ftp/cams/" 10