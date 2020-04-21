FROM alpine:3.11

RUN apk update && apk --no-cache add python3 curl bind-tools iproute2 iptables ipvsadm
RUN pip3 install --no-cache-dir --upgrade pip && \
  pip3 install --no-cache-dir -q Flask==0.12.4 requests==2.21.0

ADD demo.py /usr/local/bin/

ENV DEPLOYENV='Production' RELEASE='Stable' PS1="[\u@\h \w]\\$ "

EXPOSE 80

VOLUME ["/apps/data"]

ENTRYPOINT python3 /usr/local/bin/demo.py
