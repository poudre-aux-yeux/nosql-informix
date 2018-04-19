#!/bin/bash

# [] `|! \$ {}
# $1 est le premier argument, il doit indiquer le nom de la DB
DB=$1

if (test $# -ne 1)
then
        echo "Vous n'avez pas fourni le nombre d'arguments attendu."
        echo " arg 1 : le nom de la base de données IDS 12.10 "
        exit
fi

# Test qu' IDS 12.10 est opérationnel avec la commande onstat

if [ `onstat - | grep 'On-Line' | wc -l ` -eq 1 ] ;
then
   # On teste ensuite que la connexion a la DB est opérationnelle avec
   # l'utilitaire : dbaccess et que les 3 tables :
   #  customer, orders et cust_calls existent bien avec du contenu.
   rm -f customer.json orders.json cust_calls.json
   dbaccess $DB <<! > output-test-db.log
unload to customer.json  select count (*) from customer;
unload to orders.json  select count (*) from orders;
unload to cust_calls.json  select count (*) from cust_calls;
!
   
   # On teste qu'il y a bien 28 enregistrements dans la table customer
   if [ `cat customer.json | grep '28' | wc -l ` -ne 1 ] ;
   then 
      echo "Il manque des enregistrements dans la table : customer,"
      echo "Veuillez re exécuter le script : dbaccessdemo7."
      exit 20
   fi  

   # On teste qu'il y a bien 23 enregistrements dans la table orders
   if [ `cat orders.json | grep '23' | wc -l ` -ne 1 ] ;
   then 
      echo "Il manque des enregistrements dans la table : orders,"
      echo "Veuillez re exécuter le script : dbaccessdemo7."
      exit 30
   fi  

   # On teste qu'il y a bien 7 enregistrements dans la table cust_calls
   if [ `cat cust_calls.json | grep '7' | wc -l ` -ne 1 ] ;
   then 
      echo "Il manque des enregistrements dans la table : cust_calls,"
      echo "Veuillez re exécuter le script : dbaccessdemo7."
      exit 30
   fi  

   # On decharge le contenu de toutes les tables dans un fichier .unl
   #  customer, orders et cust_calls existent bien avec du contenu.
   rm -f customer.json orders.json cust_calls.json
   dbaccess $DB <<! > output-test-db.log

unload to customer.json  select "customer_num:" || customer_num , "fname:" || fname, "lname:" || lname, "company:" || company, "address1:" || address1, "address2:" || address2, "city:" || city, "state:" || state, "zipcode:" || zipcode , "phone:" || phone from customer;

unload to orders.json  select "order_num:" || order_num, "order_date:" || order_date, "customer_num:" || customer_num, "ship_instruct:" || ship_instruct, "backlog:" || backlog, "po_num:" || po_num, "ship_date:" || ship_date, "ship_weight:" || ship_weight, "ship_charge:" || ship_charge, "paid_date:" || paid_date  from orders;

unload to cust_calls.json  select "customer_num:" || customer_num, "call_dtime:" || call_dtime, "user_id:" || user_id , "call_code:" || call_code , "call_descr:" || call_descr , "res_dtime:" || res_dtime , "res_descr:" || res_descr from cust_calls;

!

for i in customer.json cust_calls.json orders.json
do
     # La commande sed va substituer le caractere :  par :" pour les types non numériques 
     sed -i -e 's/time:/time:"/g' $i
     sed -i -e 's/name:/name:"/g' $i
     sed -i -e 's/_date:/_date:"/g' $i
     sed -i -e 's/backlog:/backlog:"/g' $i
     sed -i -e 's/po_num:/po_num:"/g' $i
     sed -i -e 's/company:/company:"/g' $i
     sed -i -e 's/address1:/address1:"/g' $i
     sed -i -e 's/address2:/address2:"/g' $i
     sed -i -e 's/city:/city:"/g' $i
     sed -i -e 's/state:/state:"/g' $i
     sed -i -e 's/code:/code:"/g' $i
     sed -i -e 's/phone:/phone:"/g' $i
     sed -i -e 's/descr:/descr:"/g' $i
     sed -i -e 's/user_id:/user_id:"/g' $i
     # La commande sed va substituer le caractere |  par "   afin de délimiter des données de type caractères
     sed -i -e 's/|/",/g' $i
     # La commande sed va ajouter en fin de ligne le caractere } afin de delimiter le JSON
     sed -i -e 's/$/}/g' $i
     # La commande sed va ajouter en debut de ligne le caractere { afin de delimiter le JSON
     sed -i -e 's/^/{/g' $i
     sed -i -e 's/",/,/' $i
     sed -i -e 's/,}/}/' $i
     sed -i -e 's/,"}/}/' $i
     sed -i -e 's/,",/,/' $i
     sed -i -e 's/",ship_instruct:/,ship_instruct:"/g' $i
     sed -i -e 's/",ship_charge:/,ship_charge:"/g' $i
     sed -i -e 's/customer_num:117",backlog/customer_num:117,backlog/' $i
     sed -i -e 's/\n//g' $i
done 


else
   # La commande onstat - ne retourne pas le mot "On-Line" 
   # parmi tous les caractères de retour
 echo "PROBLEME avec l'instance IDS 12.10 .... elle est non opérationnelle."
 exit 10
fi
