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
- Importer le repo Git : `git clone https://github.com/poudre-aux-yeux/nosql-informix`
- `cd nosql-informix`

---

### Question 1

- Lancer les commandes suivantes :
```sh
mongoimport --db stores_demo --collection customer < customer.json
mongoimport --db stores_demo --collection cust_calls < cust_calls.json
mongoimport --db stores_demo --collection orders < orders.json
```

### Question 2 : Recherche les enregistrements des collections (customer, orders, cust_call) dans Mongodb

```
db.customer.find( {customer_num: { $gt:101 } } )
db.orders.find( {order_num: { $gte:1003, $lte:1006 } } )
db.cust_calls.find({"user_id": /j$/})
db.orders.find().sort({order_date:+1}).limit(1)
```

### Question 3 : Création de deux index (customer, cust_call) dans Mongodb

### Question 4 : Migration SQL vers Mongodb. Convertir en commande MONGODB les instructions SQL suivantes

- DELETE FROM CUST_CALLS WHERE customer_num = 121; 
- SELECT COUNT(*) FROM CUST_CALLS;
- UPDATE FROM CUSTOMER SET FNAME = "Laurent" AND LNAME = "Revel" WHERE CUSTOMER_NUM = 101;

```sql
db.cust_calls.deleteMany({customer_num: '121'])
db.cust_calls.count()
db.customer.update({customer_num: '121'}, {$set: { "fname": "Laurent" }, {"lname": "Revel"}})
```
