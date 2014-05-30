FROM quay.io/democracyworks/base
MAINTAINER TurboVote <dev@turbovote.org>

RUN apt-get install -y curl default-jre-headless

# Download the latest .deb and install
RUN curl http://aphyr.com/riemann/riemann_0.2.5_all.deb > /tmp/riemann_0.2.5_all.deb
RUN dpkg -i /tmp/riemann_0.2.5_all.deb

# Expose the ports for inbound events and websockets
EXPOSE 5555/udp

ADD riemann.config /etc/riemann/riemann.config
ADD run.sh /run.sh

CMD ["/run.sh"]