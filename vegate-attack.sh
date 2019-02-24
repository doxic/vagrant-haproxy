#!/bin/bash

# Trap interrupts and exit instead of continuing the loop
trap "echo Exited!; ./bin/vegeta plot results.$NOW.gob > plot.$NOW.html; exit;" SIGINT SIGTERM

NOW=`date +%Y-%m-%d.%H:%M`
for rate in $(seq 200 100 10000); do
    echo "Rate: $rate"
    ./bin/vegeta attack -duration=30s -rate $rate -targets targets.txt >> results.$NOW.gob
done

./bin/vegeta plot results.$NOW.gob > plot.$NOW.html
