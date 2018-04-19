# nosql-informix

## Informix

- Lancer la BDD : `su - informix`
- Voir si informix est online : `onstat -`
- Changer la variable locale : `DB_LOCALE=en_us.8859-1`
- Créer la BDD démo : `dbaccessdemo7`
#- Nom de la BDD : `dbschema –d stores_demo –t customer -ss`
- Acceder a la BDD : `dbaccess`
- ` ./informixToJson.sh stores_demo`

## MongoDB

- Installer MongoDB : 
  - Créer le fihier mongodb-org-3.6.repo : `mkdir /etc/yum.repos.d/mongodb-org-3.6.repo`
  - Insérer le texte suivant :  
```
[mongodb-org-3.6]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.6/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.6.asc
```  
- Installer MongoDB : `sudo yum install -y mongodb-org`
- Lancer MongoDB : `mongo --host 127.0.0.1:27017`

```sh
mongoimport --db stores_demo --collection customer < customer.json
mongoimport --db stores_demo --collection cust_calls < cust_calls.json
mongoimport --db stores_demo --collection orders < orders.json
```

###2 - Recherche les enregistrements des collections (customer, orders, cust_call) dans Mongodb.

```
db.customer.find( {customer_num: { $gt:101 } } )
db.orders.find( {order_num: { $gte:1003, $lte:1006 } } )
db.cust_calls.find({"user_id": /j$/})
db.orders.find().sort({order_date:+1}).limit(1)
```
