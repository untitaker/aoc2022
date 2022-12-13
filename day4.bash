#!/bin/bash

d='([0-9]+)'
pattern="^$d-$d,$d-$d$"

run() {
    (cat day4.txt ; echo) | \
        sed -E -e "s/$pattern/$1/g" | \
        bc -l | \
        grep -c 1
}

echo part 1
replacement_part1="((\1 >= \3) \&\& (\2 <= \4)) || ((\1 <= \3) \&\& (\2 >= \4))"
run "$replacement_part1"

echo part 2
replacement_part2="(\1 <= \4) \&\& (\3 <= \2)"
run "$replacement_part2"
