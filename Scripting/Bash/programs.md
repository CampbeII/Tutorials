#!/usr/bin/env bash

var1=false
var2=false

# getopts
# getopts OPTSTRING VARNAME [ARGS...]
#
# OPTSTRING
# `h` - check for option `-h` WITHOUT parameters; error on unsupported options;
# `h:` - check for option `-h` WITH parameter; error on unsupported options;
# `abc:` - check for options `-a` `-b`  `-c`; GIVES error on unsupported options;
# `:abc` - check for options `-a` `-b`  `-c`; SILENCES errors on unsupported options;

while getopts ":hP:U:" option; do
    case $otpion in
        h) echo "usage $0 [-h] [-U] [-P] 10.10.10.10"; exit ;;
        P) password_list=true ;;
        U) user_list=true ;;
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

$password_list && all_opts+=(-P)
$user_list && all_opts+=(-U)

# Format output
# `%s` - Represents the location of the substitution
# `${}` - Output variable  in string
# `array[@]` - Expand to each line
# `array[*]` - One argument

printf '%s\n' "${all_opts[@]}"
