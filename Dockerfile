FROM quay.io/democracyworks/base
MAINTAINER TurboVote <dev@turbovote.org>

RUN apt-get update
RUN apt-get install -y curl default-jre-headless

# Download the latest .deb and install
RUN curl https://aphyr.com/riemann/riemann_0.2.8_all.deb > /tmp/riemann_0.2.8_all.deb
RUN dpkg -i /tmp/riemann_0.2.8_all.deb

# Expose the ports for inbound events and websockets
EXPOSE 5555/udp 5555

ADD riemann.config /etc/riemann/riemann.config
ADD run.sh /run.sh

CMD ["/run.sh"]