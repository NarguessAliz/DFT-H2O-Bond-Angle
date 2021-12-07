#!/bin/bash

for k in 5 10 15 20 25 30
 	do
		sed "s/kpoint/${k}/g" h2o.in > h2o.new.in
		pw.x <h2o.new.in> h2o.out
		echo "k points =" ${k} "," `cat h2o.out|grep !`
		
	done 
