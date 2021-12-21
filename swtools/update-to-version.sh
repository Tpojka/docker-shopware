#!/bin/bash

curl -L  https://raw.githubusercontent.com/Tpojka/shopware-tools/master/update-shop.sh > ./update-shop.sh
chmod +x ./update-shop.sh
./update-shop.sh $1
rm ./update-shop.sh
