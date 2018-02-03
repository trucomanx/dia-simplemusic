SRCPATH='..'

################################################################################
echo ''
APPVERSION=$(grep 'Version: ' $SRCPATH/DESCRIPTION | cut -d' ' -f2)
echo 'version:'$APPVERSION
APPFILENAME=$(grep 'Name: ' $SRCPATH/DESCRIPTION | cut -d' ' -f2)
echo 'package:'$APPFILENAME
APPARCH='all'
echo 'Arquitecture:'$APPARCH
APPSUMMARY=$(grep 'Title: ' $SRCPATH/DESCRIPTION | cut -d: -f2)
echo 'Summary:'$APPSUMMARY
APPDESCRIPTION=$(grep 'Description: ' $SRCPATH/DESCRIPTION | cut -d: -f2)
echo 'Description:'$APPDESCRIPTION
echo ''

################################################################################

cd ..
make shapes
cd dist

################################################################################
if [ -z $1 ]; then
    INSTALLPATH="${APPFILENAME}-${APPVERSION}"
else
    INSTALLPATH="$1"
fi
DISTFILENAME="${INSTALLPATH}.tar.gz"
echo 'Dist filename:'$DISTFILENAME

################################################################################
mkdir -p $INSTALLPATH/shapes/dia-simplemusic/
mkdir -p $INSTALLPATH/sheets/
cp -f $SRCPATH/dia-shapes/shapes/dia-simplemusic/*.png   $INSTALLPATH/shapes/dia-simplemusic/
cp -f $SRCPATH/dia-shapes/shapes/dia-simplemusic/*.shape $INSTALLPATH/shapes/dia-simplemusic/
cp -f $SRCPATH/dia-shapes/sheets/*.sheet                   $INSTALLPATH/sheets/

################################################################################
cd ..
make clean
cd dist



################################################################################
cat README.md.in > tmp.tmp 
sed -i "s/@DISTFILENAME@/${DISTFILENAME}/g"  tmp.tmp 
sed -i "s/@APPVERSION@/${APPVERSION}/g"  tmp.tmp 
sed -i "s/@APPFILENAME@/${APPFILENAME}/g"  tmp.tmp 
sed -i "s/@APPARCH@/${APPARCH}/g"  tmp.tmp 
sed -i "s/@APPSUMMARY@/${APPSUMMARY}/g"  tmp.tmp 
sed -i "s/@APPDESCRIPTION@/${APPDESCRIPTION}/g" tmp.tmp 
mv -f tmp.tmp $INSTALLPATH/README.md

if [ -z $1 ]; then
    tar -czvf "${DISTFILENAME}" "${INSTALLPATH}/"
    rm -f -r "${INSTALLPATH}"
fi

