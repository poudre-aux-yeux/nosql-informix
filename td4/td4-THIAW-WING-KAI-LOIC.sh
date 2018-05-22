#!/bin/bash

echo "TP de Loïc THIAW-WING-KAÏ" >> td4-THIAW-WING-KAI-LOIC.log


echo "Question 1" >> td4-THIAW-WING-KAI-LOIC.log
echo "Convertir les instructions SQL Informix suivantes, en instruction find MongoDB" >> td4-THIAW-WING-KAI-LOIC.log
mongo epsinosql --eval 'db.customer.createIndex( { company: "text" } )' >> td4-THIAW-WING-KAI-LOIC.log
mongo epsinosql --eval 'db.customer.find({ $text: { $search: "Sports -town"} })' >> td4-THIAW-WING-KAI-LOIC.log
mongo epsinosql --eval 'db.cust_calls.createIndex( { call_descr: "text" } )' >> td4-THIAW-WING-KAI-LOIC.log
mongo epsinosql --eval 'db.cust_calls.find({ $text: { $search: "hero watch tennis"} })' >> td4-THIAW-WING-KAI-LOIC.log
echo "------------------------------------------------------------------------------" >> td4-THIAW-WING-KAI-LOIC.log
echo "------------------------------------------------------------------------------" >> td4-THIAW-WING-KAI-LOIC.log


echo "Question 2" >> td4-THIAW-WING-KAI-LOIC.log
echo "Corriger les instructions MongoDB suivantes afin qu’elles fonctionnent sur les collections : __CUSTOMER__ et __ORDERS__ afin de récupérer les documents dont les champs sont null ou vide" >> td4-THIAW-WING-KAI-LOIC.log
mongo epsinosql --eval '' >> td4-THIAW-WING-KAI-LOIC.log
mongo epsinosql --eval '' >> td4-THIAW-WING-KAI-LOIC.log
echo "------------------------------------------------------------------------------" >> td4-THIAW-WING-KAI-LOIC.log
echo "------------------------------------------------------------------------------" >> td4-THIAW-WING-KAI-LOIC.log


echo "Question 3" >> td4-THIAW-WING-KAI-LOIC.log
echo "Corriger les instructions suivantes afin qu’elles retournent seulement les champs _id , fname et lname__ dans la collection __CUSTOMER__ (ces requêtes retournent chacune un document)" >> td4-THIAW-WING-KAI-LOIC.log
mongo epsinosql --eval '' >> td4-THIAW-WING-KAI-LOIC.log
mongo epsinosql --eval '' >> td4-THIAW-WING-KAI-LOIC.log
mongo epsinosql --eval '' >> td4-THIAW-WING-KAI-LOIC.log
echo "------------------------------------------------------------------------------" >> td4-THIAW-WING-KAI-LOIC.log
echo "------------------------------------------------------------------------------" >> td4-THIAW-WING-KAI-LOIC.log

echo "TP de Loïc THIAW-WING-KAÏ" >> td4-THIAW-WING-KAI-LOIC.log
