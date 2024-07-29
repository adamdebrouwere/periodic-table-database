#periodic table elements search program

PSQL="psql --username=freecodecamp --dbname=periodic_table -t -c"

if [[ -z "$1" ]] 
then
  echo "Please provide an element as an argument."
  exit
fi

if [[ $1 =~ ^[0-9]+$ ]]
then
  GET_ELEMENT_INFO=$($PSQL "SELECT properties.atomic_number, elements.name, elements.symbol, types.type, properties.atomic_mass, properties.melting_point_celsius, properties.boiling_point_celsius FROM properties FULL JOIN types USING (type_id) FULL JOIN elements USING (atomic_number) WHERE atomic_number = '$1';")
 
elif [[ $1 =~ ^[a-zA-Z]+$ ]]
then
  GET_ELEMENT_INFO=$($PSQL "SELECT properties.atomic_number, elements.name, elements.symbol, types.type, properties.atomic_mass, properties.melting_point_celsius, properties.boiling_point_celsius FROM properties FULL JOIN types USING (type_id) FULL JOIN elements USING (atomic_number) WHERE symbol = '$1' OR name = '$1';")
  
fi

if [[ -z "$GET_ELEMENT_INFO" ]]
then
  echo "I could not find that element in the database."

else
   
  echo "$GET_ELEMENT_INFO" | while read ATOMIC_NUMBER _ NAME _ SYMBOL _ TYPE _ ATOMIC_MASS _ MELTING_POINT _ BOILING_POINT
  do
    echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  done
fi
