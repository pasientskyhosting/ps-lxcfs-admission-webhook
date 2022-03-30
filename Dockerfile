FROM alpine:3.15.3

ADD bin/lxcfs-admission-webhook /lxcfs-admission-webhook
ENTRYPOINT ["./lxcfs-admission-webhook"]
