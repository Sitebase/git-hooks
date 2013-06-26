#!/bin/bash

# Hook for the Git time tracker that we use
hacking=$(git config --local timetrack.hacking)
git timetrack -p > /dev/null
spent=$(git config --local timetrack.spent)
git config --local --remove-section timetrack 2> /dev/null

if [ $spent ]
then
    git notes --ref timetracker add -m "Time-spent: $spent"

    if [ $hacking ]
    then
        git config --local timetrack.start $(date +%s)
        git config --local timetrack.hacking $hacking
    fi
fi