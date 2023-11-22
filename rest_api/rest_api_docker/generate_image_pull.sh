#!/bin/bash
echo "#!/bin/bash"
for i in `ls docker-registry/ | grep .tar.gz$`; do
    echo "docker load < /mnt/images/$i"
done
echo "cd /home/admin/rest_api_server"
echo "make install"
echo "make"
