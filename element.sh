#periodic table elements search program

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z "$1" ]] 
then
  echo "Please provide an element as an argument."
  exit

else

  if [[ $1 = ^[0-9]+$ ]]
  then
    GET_ELEMENT_INFO=$($ PSQL "SELECT properties.atomic_number, elements.name, elements.symbol, types.type, properties.atomic_mass, properties.melting_point_celsius, properties.boiling_point_celsius FROM properties FULL JOIN types USING (type_id) FULL JOIN elements USING (atomic_number);")
  fi
fi

