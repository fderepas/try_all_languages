#!/bin/bash
testcountmax=$3
testcountmax=$((testcountmax-1))
cd $2
rm -rf file out outo
# create a 1M file named "file"
# that we are going to mount
# to limit data output
dd if=/dev/zero of=file bs=1000 count=10000
mkfs.ext3 file
mkdir outo
u=$USER
sudo mount -o loop file outo
sudo chown $u outo
sudo chmod -R 777 outo
# Launch docker and kill with signal 9 after 60 seconds if not finished.
# Directory ./in is mounted under /mnt/in in read only
#   in the docker machine.
# Directory ./outo is mounted under /mnt/out 
#   in the docker machine.
# We launch script
# /bin/sh /home/tal/launch.sh $testcountmax
# on image tal-$1:latest
#timeout --preserve-status --foreground -s 9 -k 60 
timeout --preserve-status -s 9 60 \
	docker run --mount \
	type=bind,source=`pwd`/in,target=/mnt/in,ro \
	--mount \
	type=bind,source=`pwd`/outo,target=/mnt/out \
	--network none \
	--name tal-$1-$$ --rm \
	tal-$1:latest /bin/sh /home/tal/launch.sh $testcountmax
cp -r outo out
for testcount in `seq 0 1 $countNbTest`
do
    touch out/out$testcount.txt
    touch out/err$testcount.txt
    if [ ! -f out/errcode$testcount.txt ]; then
	echo 1 > out/errcode$testcount.txt
    fi
done

sudo umount outo
rm -rf file outo
