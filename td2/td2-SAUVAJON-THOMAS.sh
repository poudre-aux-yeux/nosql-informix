#!/usr/bin/env bash
# Note : après avoir installé Informix sur un Centos et un Debian,
# dans les 2 cas `dbaccessdemo7` a échoué sans message d'erreur explicite.
# Je n'ai donc pas pu tester ce script

# Note 2 : s'il n'y a aucune ligne dans les tables (résultat retourné: []),
# j'ai fait le choix de quand même inscrire ce résultat dans un fichier JSON.
# L'autre approche aurait été, donc, de se dire que [] signifie pas de données
# et donc pas de retour avec un code 0.

# On initialise un code de retour à 1.
# Si au moins une des requêtes renvoie des résultats, on passe cette
# variable à 0 afin de renvoyer, en fin de script, un code retour correspondant.
returncode=1

# si le web service renvoie bien un résultat (données de la table orders)
if orders=`curl -s -H "Content-Type: application/json" -H "Accept: application/json" http://localhost:27018/stores_demo/orders` then
  # on écrit le contenu de la variable (les données de la table orders) dans un fichier, orders.json
  $orders > orders.json
  # on souhaite, selon l'énoncé, un code retour à 0 si au moins une des 2 tables a renvoyé un résultat
  returncode=0
fi

# pareil, pour le client
if customer=`curl -s -H -H "Content-Type: application/json" "Accept: application/json" http://localhost:27018/stores_demo/customer` then
  # on écrit le résultat dans le fichier customer.json
  $customer > customer.json
  # pareil que pour les commandes
  returncode=0
fi

# On retourne le code d'erreur
exit $returncode
