#!/bin/bash

API_KEY="c5fdebb786aa4c1218a28a1c7395df26"
CITY="Kolkata"

WEATHER=$(curl -s "http://api.openweathermap.org/data/2.5/weather?q=${CITY}&appid=${API_KEY}&units=metric")

TEMPERATURE=$(echo $WEATHER | jq '.main.temp')
TEMP=$((TEMPERATURE))
NEAREST_INT=$(printf "%.0f" "$TEMPERATURE")
echo " $NEAREST_INT°C"