#!/bin/bash


FILENAME=$1
if [ -z $1 ]
  then
    FILENAME='dia-simplemusic.sheet';
fi

SEARCHDIR=$2
if [ -z $2 ]
  then
    SEARCHDIR='../shapes/dia-simplemusic';
fi

DESCRIPTIONFILE=$3
if [ -z $1 ]
  then
    DESCRIPTIONFILE='../../DESCRIPTION';
fi

echo 'param1: '${FILENAME}
echo 'param2: '${SEARCHDIR}
echo 'param2: '${DESCRIPTIONFILE}

################################################################################
SHAPEFILES=`find ${SEARCHDIR}  -depth  -type f -name '*.shape'|sort -n`
NAME=`grep "^Name: " ${DESCRIPTIONFILE} | cut -f2 -d" "`
DESCRIPTION=`grep "^Description: " ${DESCRIPTIONFILE} | cut -f2 -d":"`

echo '<?xml version="1.0" encoding="UTF-8" standalone="no"?>'> ${FILENAME}
echo '<sheet xmlns="http://www.lysator.liu.se/~alla/dia/dia-sheet-ns">' >> ${FILENAME}
echo '<name>'${NAME}'</name>' >> ${FILENAME}
echo '<description>'${DESCRIPTION}'</description>' >> ${FILENAME}
echo '    ' >> ${FILENAME}
echo '<contents>' >> ${FILENAME}

for i in ${SHAPEFILES[@]}; do
    SHAPENAME=`grep "<name>" $i| cut -f2 -d">"| cut -f1 -d"<"`

    CONFFILE=`basename $i`
    BASNAME="${CONFFILE%.*}"
    CONFFILE=`dirname $i`'/'${BASNAME}'.conf'

    #if [ -f ${CONFFILE} ]; then
        echo '    <object name="'${SHAPENAME}'">' >> ${FILENAME}
        SHAPEDESC=`grep "Description:" ${CONFFILE}| cut -f2 -d":"`
        echo '    <description>'${SHAPEDESC}'</description>' >> ${FILENAME}
        echo '    </object>' >> ${FILENAME}
        echo '    ' >> ${FILENAME}
    #fi
    

done

echo '</contents>' >> ${FILENAME}
echo '</sheet>' >> ${FILENAME}

