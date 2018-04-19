mongoimport --db database --collection customer < customer.json >> td3-NOM-PRENOM.log
mongoimport --db database --collection cust_calls < cust_calls.json >> td3-NOM-PRENOM.log
mongoimport --db database --collection orders < orders.json >> td3-NOM-PRENOM.log

mongo database --eval 'db.customer.find( {customer_num: { $gt:101 } } )' >> td3-NOM-PRENOM.log
mongo database --eval 'db.orders.find( {order_num: { $gte:1003, $lte:1006 } } )' >> td3-NOM-PRENOM.log
mongo database --eval 'db.cust_calls.find({"user_id": /j$/})' >> td3-NOM-PRENOM.log
mongo database --eval 'db.orders.find().sort({order_date:+1}).limit(1)' >> td3-NOM-PRENOM.log

mongo database --eval 'db.customer.createIndex({ "customer_num": 1 })' >> td3-NOM-PRENOM.log
mongo database --eval 'db.customer.createIndex({ "customer_num": 1, "call_dtime": 1, "user_id": 1 })' >> td3-NOM-PRENOM.log
mongo database --eval 'db.customer.explain().find({customer_num: {$gt: 101}})' >> td3-NOM-PRENOM.log
mongo database --eval 'db.cust_calls.explain().find({user_id: /j$/})' >> td3-NOM-PRENOM.log
