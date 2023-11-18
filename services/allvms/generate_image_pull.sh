#!/bin/bash
echo "#!/bin/bash"
echo "hostIp=\`/sbin/ip route|awk '/default/ { print \$3 }'\`"
for i in `docker images | grep ^tal- | grep -v allvms | grep latest | cut -d ' ' -f 1 | sort`; do
    echo "docker pull \$hostIp:5000/$i:latest"
    echo "docker tag \$hostIp:5000/$i:latest $i:latest"
done
cd /home/admin/vmfrontend
make install
make
