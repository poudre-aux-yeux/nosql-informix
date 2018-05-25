#!/bin/bash

exec &> td4-SAUVAJON-THOMAS.log
echo "TD4 MongoDB Thomas SAUVAJON"

echo ""
echo ""

echo "Partie 1 : Index et recherches"
mongo stores_demo --eval 'db.customer.createIndex( { company: "text" } )'
mongo stores_demo --eval 'db.customer.find({ $text: { $search: "Sports -town"} })'
mongo stores_demo --eval 'db.cust_calls.createIndex( { call_descr: "text" } )'
mongo stores_demo --eval 'db.cust_calls.find({ $text: { $search: "\"hero watch tennis\""} })'

echo ""
echo ""

echo "Partie 2 : Champs nuls ou vides"
mongo stores_demo --eval 'db.customer.find ({ address2: null })'
mongo stores_demo --eval 'db.orders.find( { $or: [ { paid_date : { $type: 11 }}, { paid_date: null }, { paid_date: { $exists: false }}]})'

echo ""
echo ""

echo "Partie 3 : Sélections partielles"
mongo stores_demo --eval 'db.customer.find({ state: "CA", fname: "Arnold" }, { fname: 1, lname: 1 })'
mongo stores_demo --eval 'db.customer.find({ zipcode: "85008" }, { fname: 1, lname: 1 })'

echo ""
echo ""
