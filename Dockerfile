FROM alpine:latest

ADD bin/lxcfs-admission-webhook /lxcfs-admission-webhook
ENTRYPOINT ["./lxcfs-admission-webhook"]
