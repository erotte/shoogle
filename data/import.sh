#!/bin/bash
curl 'http://localhost:8983/solr/update/csv?commit=true&separator=;&trim=true&f.availablesizes.split=true&f.availablesizes.separator=%20' -H 'Content-type:text/plain; charset=utf-8' --data-binary @4_products.csv

