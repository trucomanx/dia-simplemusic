
cd ..
make shapes
cd deb

################################################################################
INSTALLPATH='output'
SRCPATH='..'

################################################################################
mkdir -p $INSTALLPATH/usr/share/dia/shapes/dia-simplemusic/
mkdir -p $INSTALLPATH/usr/share/dia/sheets/
cp -v -f $SRCPATH/dia-shapes/shapes/dia-simplemusic/*.png   $INSTALLPATH/usr/share/dia/shapes/dia-simplemusic/
cp -v -f $SRCPATH/dia-shapes/shapes/dia-simplemusic/*.shape $INSTALLPATH/usr/share/dia/shapes/dia-simplemusic/
cp -v -f $SRCPATH/dia-shapes/sheets/*.sheet                   $INSTALLPATH/usr/share/dia/sheets/

################################################################################
cd ..
make clean
cd deb

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
mkdir -p $INSTALLPATH/DEBIAN

cat control.input > tmp.tmp 
sed -i "s/@APPVERSION@/${APPVERSION}/g"  tmp.tmp 
sed -i "s/@APPFILENAME@/${APPFILENAME}/g"  tmp.tmp 
sed -i "s/@APPARCH@/${APPARCH}/g"  tmp.tmp 
sed -i "s/@APPSUMMARY@/${APPSUMMARY}/g"  tmp.tmp 
sed -i "s/@APPDESCRIPTION@/${APPDESCRIPTION}/g" tmp.tmp 
mv -f tmp.tmp $INSTALLPATH/DEBIAN/control

echo ""
DEBFILENAME="${APPFILENAME}-${APPVERSION}_${APPARCH}".deb
echo "Creating $DEBFILENAME"
dpkg-deb --build $INSTALLPATH $DEBFILENAME

echo ""
rm -f -r "${INSTALLPATH}"


if [ -f "$DEBFILENAME" ]
then
    echo "Package $DEBFILENAME created!!!........[OK]"
    echo ""
    echo "sudo dpkg -i $DEBFILENAME"
####    gksudo  --message "Package $DEBFILENAME created!!!Dou you like install de package? If yes, enter the password" \
####            dpkg -i $DEBFILENAME
else
	echo "$DEBFILENAME not found."
fi
echo ""




