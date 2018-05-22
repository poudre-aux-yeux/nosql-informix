#!/bin/bash

echo "TP de Loïc THIAW-WING-KAÏ" >> td3-THIAW-WING-KAI-LOIC.log


echo "Question 1" >> td3-THIAW-WING-KAI-LOIC.log
echo "Importer les données" >> td3-THIAW-WING-KAI-LOIC.log
mongoimport --db epsinosql --collection customer < customer.json >> td3-THIAW-WING-KAI-LOIC.log
mongoimport --db epsinosql --collection cust_calls < cust_calls.json >> td3-THIAW-WING-KAI-LOIC.log
mongoimport --db epsinosql --collection orders < orders.json >> td3-THIAW-WING-KAI-LOIC.log
echo "------------------------------------------------------------------------------" >> td3-THIAW-WING-KAI-LOIC.log
echo "------------------------------------------------------------------------------" >> td3-THIAW-WING-KAI-LOIC.log


echo "Question 2" >> td3-THIAW-WING-KAI-LOIC.log
echo "Recherche les enregistrements des collections (customer, orders, cust_call) dans Mongodb" >> td3-THIAW-WING-KAI-LOIC.log
mongo epsinosql --eval 'db.customer.find( {customer_num: { $gt:101 } } )' >> td3-THIAW-WING-KAI-LOIC.log
mongo epsinosql --eval 'db.orders.find( {order_num: { $gte:1003, $lte:1006 } } )' >> td3-THIAW-WING-KAI-LOIC.log
mongo epsinosql --eval 'db.cust_calls.find({"user_id": /j$/})' >> td3-THIAW-WING-KAI-LOIC.log
mongo epsinosql --eval 'db.orders.find().sort({order_date:+1}).limit(1)' >> td3-THIAW-WING-KAI-LOIC.log
echo "------------------------------------------------------------------------------" >> td3-THIAW-WING-KAI-LOIC.log
echo "------------------------------------------------------------------------------" >> td3-THIAW-WING-KAI-LOIC.log


echo "Question 3" >> td3-THIAW-WING-KAI-LOIC.log
echo "Création de deux index (customer, cust_call) dans Mongodb" >> td3-THIAW-WING-KAI-LOIC.log
mongo epsinosql --eval 'db.customer.createIndex({ "customer_num": 1 })' >> td3-THIAW-WING-KAI-LOIC.log
mongo epsinosql --eval 'db.customer.createIndex({ "customer_num": 1, "call_dtime": 1, "user_id": 1 })' >> td3-THIAW-WING-KAI-LOIC.log
mongo epsinosql --eval 'db.customer.explain().find({customer_num: {$gt: 101}})' >> td3-THIAW-WING-KAI-LOIC.log
mongo epsinosql --eval 'db.cust_calls.explain().find({user_id: /j$/})' >> td3-THIAW-WING-KAI-LOIC.log
echo "------------------------------------------------------------------------------" >> td3-THIAW-WING-KAI-LOIC.log
echo "------------------------------------------------------------------------------" >> td3-THIAW-WING-KAI-LOIC.log


echo "Question 4" >> td3-THIAW-WING-KAI-LOIC.log
echo "Migration SQL vers Mongodb. Convertir en commande MONGODB les instructions SQL suivantes" >> td3-THIAW-WING-KAI-LOIC.log
mongo epsinosql --eval 'db.cust_calls.deleteMany({customer_num: 121})' >> td3-THIAW-WING-KAI-LOIC.log
mongo epsinosql --eval 'db.cust_calls.count()' >> td3-THIAW-WING-KAI-LOIC.log
mongo epsinosql --eval 'db.customer.update({customer_num: 101}, {$set: { "fname": "Laurent" , "lname": "Revel"}})' >> td3-THIAW-WING-KAI-LOIC.log
echo "------------------------------------------------------------------------------" >> td3-THIAW-WING-KAI-LOIC.log
echo "------------------------------------------------------------------------------" >> td3-THIAW-WING-KAI-LOIC.log

echo "TP de Loïc THIAW-WING-KAÏ" >> td3-THIAW-WING-KAI-LOIC.log
