#!/bin/bash

# check for input
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
  exit
fi

# query
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
ELEMENT=$($PSQL "SELECT atomic_number, symbol, name, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number::text='$1' OR symbol='$1' OR name='$1';")

# if element input doesn't exist
if [[ -z $ELEMENT ]]
then
  echo "I could not find that element in the database."
  exit
fi

# format and output information
IFS="|" read ATOMIC_NUMBER SYMBOL NAME TYPE MASS MELT BOIL <<< "$ELEMENT"
echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
