#!/bin/bash
exec &> td3-SAUVAJON-THOMAS.log
echo "TD MongoDB Thomas SAUVAJON"

echo ""
echo ""

echo "Partie 1 : Insertions"
mongoimport --db stores_demo --collection customer < customer.json
mongoimport --db stores_demo --collection cust_calls < cust_calls.json
mongoimport --db stores_demo --collection orders < orders.json

echo ""
echo ""

echo "Partie 2 : Recherches"
mongo stores_demo --eval 'db.customer.find({ "customer_num": { $gt:101 }})'
mongo stores_demo --eval 'db.orders.find({ "order_num": { $gte: 1003, $lte: 1006 }})'
mongo stores_demo --eval 'db.cust_calls.find({ "user_id": /j$/ })'
mongo stores_demo --eval 'db.orders.find().sort({ "order_date": +1}).limit(1)'

echo ""
echo ""

echo "Partie 3 : Index"
mongo stores_demo --eval 'db.customer.createIndex({ "customer_num": 1 })'
mongo stores_demo --eval 'db.customer.createIndex({ "customer_num": 1, "call_dtime": 1, "user_id": 1 })'
mongo stores_demo --eval 'db.customer.explain().find({ "customer_num": { $gt: 101 }}).finish().queryPlanner.winningPlan.inputStage.indexName'
mongo stores_demo --eval 'db.cust_calls.explain().find({ user_id: /j$/ }).finish()'

echo ""
echo ""

echo "Partie 4 : Migration"
mongo stores_demo --eval 'db.cust_calls.deleteMany({ "customer_num": 121 }); db.cust_calls.count()'
mongo stores_demo --eval 'db.customer.update({ "customer_num": 101}, { $set: { "fname": "Laurent", "lname": "Revel" }})'
