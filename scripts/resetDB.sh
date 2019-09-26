#! /bin/bash

./postgres.sh
./graphql.sh &
./persistence.sh &

wait
echo
echo "Complete"
