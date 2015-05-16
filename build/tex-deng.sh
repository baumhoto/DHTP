#!/bin/bash
#this file is released into the public domain, do what you will with it, i'm not responsible for what hapens with you using it#

#get date
export mydate=`date +%y%m%d`

#build directory base
SDIR="$( cd "$( dirname "$0" )" && pwd )" #Get the scripts directory
cd "$(echo $SDIR)" #cd to the scripts dir
cd ../ #go up one level to where the DHTP base folder is
BDIR=$(pwd) #set the base directory to the current directory
echo $BDIR #print base dir (Example = /media/lvm/Art/DHTP)
echo "$BDIR/Info"
#starting Doomsday pack
#remove the old Info file if it exists
echo "looking for $BDIR/Info"
if [ -f "$BDIR/Info" ]
then
	echo "found, removing old Info file"
    rm Info
else
	"not found"
fi
#create the new Info file
echo "Creating the Info file"
cat > Info << EOF
name: Doom High-resolution Texture Project

language english (
  version: 20$mydate
  summary: This pack replaces doom's textures, with high resolution versions.
  contact: eunbolt@gmail.com
  author: see the README files contained in the pk3
  license: Do not redistribute

  readme: Overview is defined in the metadata.
)

# Require a certain game component:
component: game-jdoom

EOF
#remove the old Doomsday build setup folder if it exists

echo "looking for $BDIR/doomsday"
if [ -d "$BDIR/doomsday" ]
then
	echo "found, removing the old doomsday build folder"
    rm -r $BDIR/doomsday
else
	echo "not found"
fi
echo ---------starting to create the dhtp for the doomsday engine and compatible engines---------
#create the new doomsday folder
echo "Creating the doomsday folder"
mkdir $BDIR/doomsday
echo ---------copying textures---------
cp -r $BDIR/textures $BDIR/doomsday/textures
cp $BDIR/doomsday/textures/doom1/* $BDIR/doomsday/textures
rm -r $BDIR/doomsday/textures/doom1
echo ---------copying flats---------
cp -r $BDIR/flats $BDIR/doomsday/flats
echo ---------copying readmes---------
cp $BDIR/README_FLATS.txt $BDIR/doomsday/README_FLATS.txt
cp $BDIR/README_WALLS.txt $BDIR/doomsday/README_WALLS.txt
cp $BDIR/README_WALLS_DOOM1.txt $BDIR/doomsday/README_WALLS_DOOM1.txt
cp $BDIR/README_WALLS_DOOM2.txt $BDIR/doomsday/README_WALLS_DOOM2.txt
cp $BDIR/README_WALLS_PLUTONIA.txt $BDIR/doomsday/README_WALLS_PLUTONIA.txt
cp $BDIR/README_WALLS_TNT.txt $BDIR/doomsday/README_WALLS_TNT.txt
cp $BDIR/definitions/dhtp-doom1lights.ded $BDIR/doomsday/dhtp-doom1lights.ded
cp $BDIR/definitions/dhtp-doom2lights.ded $BDIR/doomsday/dhtp-doom2lights.ded
cp $BDIR/definitions/dhtp-doom2lights.ded $BDIR/doomsday/dhtp-doom2-plutlights.ded
cp $BDIR/definitions/dhtp-doom2lights.ded $BDIR/doomsday/dhtp-doom2tntlights.ded
cp $BDIR/Info $BDIR/doomsday/Info
cp -r $BDIR/shinemaps/lightmaps $BDIR/doomsday
cp $BDIR/dhtp-shinmaps.ded $BDIR/doomsday/dhtp-shinmaps.ded
cd $BDIR/doomsday
echo ---------ziping pack---------
zip -r doomsday . -i Info \*.png \*.ded \*.txt
echo ---------renaming, adding date of compile, and moving to the built folder---------
mv doomsday.zip ../build/deng-dhtp-20$mydate.pk3
echo ---------Complete---------
