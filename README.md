# nosql-informix

## Informix

- Changer l'utilisateur à informix : `su - informix`
- Voir si informix est online : `onstat -`
- Démarrer informix : `oninit -y`
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

### Commandes MongoDB

- `show dbs` affiche les différentes bases de données
- `use MyDatabase` permet de se connecter à la base de données __MyDatabase__
- `show collections` permet d'afficher les différents tables de la BDD

---

## TD 3

### Question 1

- Lancer les commandes suivantes :
```sh
mongoimport --db stores_demo --collection customer < informix-tables/customer.json
mongoimport --db stores_demo --collection cust_calls < informix-tables/cust_calls.json
mongoimport --db stores_demo --collection orders < informix-tables/orders.json
```

### Question 2 : Recherche les enregistrements des collections (customer, orders, cust_call) dans Mongodb

1. customer : dont customer_num > 101
2. orders : dont order_num between 1003 and 1006
3. cust_calls : dont user_id like ‘%j’
4. orders : le 1e enregistrement en triant par order_date (par ordre croissant)

```js
db.customer.find( {customer_num: { $gt:101 } } )
db.orders.find( {order_num: { $gte:1003, $lte:1006 } } )
db.cust_calls.find({"user_id": /j$/})
db.orders.find().sort({order_date:+1}).limit(1)
```

### Question 3 : Création de deux index (customer, cust_call) dans Mongodb

1. Unique sur la colonne : customer_num de la collection customer
2. Unique sur les colonnes : customer_num + call_dtime + user_id de la collection cust_calls
3. Vérifier que votre index est bien utilisé dans l’instruction 2a puis 2c

```js
db.customer.createIndex({ "customer_num": 1 })
db.customer.createIndex({ "customer_num": 1, "call_dtime": 1, "user_id": 1 })
db.customer.explain().find({customer_num: {$gt: 101}})
db.cust_calls.explain().find({user_id: /j$/})
```

### Question 4 : Migration SQL vers Mongodb. Convertir en commande MONGODB les instructions SQL suivantes

1. DELETE FROM CUST_CALLS WHERE customer_num = 121; 
2. SELECT COUNT(*) FROM CUST_CALLS;
3. UPDATE FROM CUSTOMER SET FNAME = "Laurent" AND LNAME = "Revel" WHERE CUSTOMER_NUM = 101;

```js
db.cust_calls.deleteMany({customer_num: 121})
db.cust_calls.count()
db.customer.update({customer_num: 101}, {$set: { "fname": "Laurent" , "lname": "Revel"}})
```

---

## TD 4

### Question 1

1. SELECT * FROM customer WHERE company MATCHES "*Sports*"and NOT MATCHES "town*"
2. SELECT * FROM cust_calls WHERE call_descr MATCHES "*hero watch*"or MATCHES "tennis*"

```sql

```

### Question 2

### Question 3
