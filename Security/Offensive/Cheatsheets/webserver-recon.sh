#!/usr/bin/env bash

# UNTESTED

# getopts
# getopts OPTSTRING VARNAME [ARGS...]
#
# OPTSTRING
# `h` - check for option `-h` WITHOUT parameters; error on unsupported options;
# `h:` - check for option `-h` WITH parameter; error on unsupported options;
# `abc:` - check for options `-a` `-b`  `-c`; GIVES error on unsupported options;
# `:abc` - check for options `-a` `-b`  `-c`; SILENCES errors on unsupported options;

while getopts ":ht:p:" option; do
    case $otpion in
        h) echo "usage $0 [-t] 10.10.10.10 [-p] 1-100]"; exit ;;
        t) target=true ;;
        p) ports=true ;;
        ?) echo "error:  option - $OPTARG is not implemented"; exit  ;;
    esac
done

# Remove options from positional parameters.
#
#  OPTIND
# Return the index of the next argument to be processed.
# Index starts at 1.

shift $(( OPTIND - 1))

all_opts=()

$target && all_opts+=(-t)
$ports && all_opts+=(-p)

# Format output
# `%s` - Represents the location of the substitution
# `${}` - Output variable  in string
# `array[@]` - Expand to each line
# `array[*]` - One argument

printf '%s\n' "${all_opts[@]}"

# Scan ports and save result to file
nc -nv -w 1 -z $target $ports 2>&1 | awk '/succeeded!${printf "%s\t%s\n", $5, $4}' port-scan 2>&1

# If Port 80 retrieve home page
