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

#remove the old risen3d build setup folder if it exists
if [ -d "$BDIR/risen3d" ]
then
	echo "found, removing the old risen3d build folder"
    rm -r $BDIR/risen3d
else
	echo "not found"
fi
echo ---------starting to create the dhtp for risen3d and compatible engines---------
mkdir $BDIR/risen3d
mkdir $BDIR/risen3d/data
echo ---------copying textures---------
cp -r $BDIR/textures $BDIR/risen3d/data/textures
cp -r $BDIR/flats $BDIR/risen3d/data/textures/flats
cd $BDIR/risen3d/data/textures/flats
echo ---------renaming and moving the flats---------
for i in $(ls); do mv $i ../flat-$i; done
cd $BDIR/risen3d/data/textures
rm -r flats
cd $BDIR/risen3d/data/textures/doom2
for i in $(ls); do mv $i ../$i; done
cd $BDIR/risen3d/data/textures
rm -r doom2
cd $BDIR
echo ---------copying readmes---------
cp $BDIR/README_FLATS.txt $BDIR/risen3d/README_FLATS.txt
cp $BDIR/README_WALLS.txt $BDIR/risen3d/README_WALLS.txt
cp $BDIR/README_WALLS_DOOM1.txt $BDIR/risen3d/README_WALLS_DOOM1.txt
cp $BDIR/README_WALLS_DOOM2.txt $BDIR/risen3d/README_WALLS_DOOM2.txt
cp $BDIR/README_WALLS_PLUTONIA.txt $BDIR/risen3d/README_WALLS_PLUTONIA.txt
cp $BDIR/README_WALLS_TNT.txt $BDIR/risen3d/README_WALLS_TNT.txt
cd $BDIR/risen3d
echo ---------ziping pack---------
zip -r risen3d . -i \*.png \*.txt
echo ---------renaming, adding date of compile, and moving to the built folder---------
mv risen3d.zip ../built/r3d-dhtp-20$mydate.zip
cd ..
echo ---------Complete---------
