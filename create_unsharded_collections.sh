#!/bin/sh

DATAROOT="/vagrant/unsharded"
IMPORT="/usr/bin/mongoimport"

if [ ! -d $DATAROOT ]; then
    exit 0;
fi

for db in `ls "${DATAROOT}"`
do
    for col in `ls "${DATAROOT}/${db}"`
    do
        ${IMPORT} --host localhost --db "${db}" --collection "${col}" < "${DATAROOT}/${db}/${col}" || exit 1
    done
done

exit 0

