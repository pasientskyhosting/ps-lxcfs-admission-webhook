#!/bin/bash
# Cleanup
nsenter -m/proc/1/ns/mnt fusermount -u /var/lib/lxcfs 2> /dev/null || true
nsenter -m/proc/1/ns/mnt [ -L /etc/mtab ] || \
        sed -i "/^lxcfs \/var\/lib\/lxcfs fuse.lxcfs/d" /etc/mtab

# Prepare
mkdir -p /usr/local/lib/lxcfs /var/lib/lxcfs

# Update lxcfs
cp -f /lxcfs/lxcfs /usr/local/bin/lxcfs
cp -f /lxcfs/liblxcfs.so /lxcfs/lib64/liblxcfs.so
cp -n /usr/lib64/libfuse.so.2.9.2 /lxcfs/lib64/libfuse.so.2
cp -n /usr/lib64/libulockmgr.so.1.0.1 /lxcfs/lib64/libulockmgr.so.1

# Mount
exec nsenter -m/proc/1/ns/mnt /opt/bin/lxcfs /var/lib/lxcfs/
