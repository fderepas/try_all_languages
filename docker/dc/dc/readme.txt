To launch locally a docker :
   docker run -it --rm --mount type=bind,source=`pwd`,target=/mnt/out tal-dc
To copy back source code
   cd /home/tal/bc*/dc && make clean && rm -rf *~ /mnt/out/dc && cd ../ && cp -r dc /mnt/out/


