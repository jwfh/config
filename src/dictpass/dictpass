#!/usr/bin/env sh

# No copyright. Released under the public domain.
# You really should have shuf(1) or shuffle(1) installed. Crazy fast.
shuff(){ 
    if [ $(command -v shuf) ]; then
        shuf -n "$1"
    elif [ $(command -v shuffle) ]; then
        shuffle -f /dev/stdin -p "$1"
    else
        awk 'BEGIN{
            "od -tu4 -N4 -A n /dev/urandom" | getline
            srand(0+$0)
        }
        {print rand()"\t"$0}' | sort -n | cut -f 2 | head -n "$1"
    fi
}
gen_monkey_pass(){
    I=0
    [ $(printf "$1" | grep -E '[0-9]+') ] && NUM="$1" || NUM="1"
    until [ "$I" -eq "$NUM" ]; do
        I=$((I+1))
        LC_CTYPE=C strings /dev/urandom | \
            grep -o '[a-hjkmnp-z2-9-]' | head -n 16 | paste -s -d \\0 /dev/stdin
    done | column
}
gen_xkcd_pass(){
    I=0
    [ $(printf "$1" | grep -E '[0-9]+') ] && NUM="$1" || NUM="1"
    [ $(uname) = "SunOS" ] && FILE="/usr/dict/words" || FILE="/usr/share/dict/words"
    DICT=$(LC_CTYPE=C grep -E '^[a-zA-Z]{3,6}$' "$FILE")
    until [ "$I" -eq "$NUM" ]; do
        I=$((I+1))
        WORDS=$(printf "$DICT" | shuff 5 | paste -s -d ' ' /dev/stdin)
        XKCD=$(printf "$WORDS" | sed 's/ //g')
        printf "$XKCD ($WORDS)" | awk '{x=$1;$1="";printf "%-36s %s\n", x, $0}'
    done | column
}
gen_xkcd_pass
