FROM quay.io/democracyworks/base
MAINTAINER TurboVote <dev@turbovote.org>

RUN apt-get install -y curl default-jre-headless ruby1.9.1 ruby1.9.1-dev patch make g++

# Download the latest .deb and install
RUN curl http://aphyr.com/riemann/riemann_0.2.5_all.deb > /tmp/riemann_0.2.5_all.deb
RUN dpkg -i /tmp/riemann_0.2.5_all.deb

RUN gem install riemann-dash

# Expose the ports for inbound events and websockets
EXPOSE 5555/udp 5556 4567

ADD riemann.config /etc/riemann/riemann.config
ADD config.rb /config.rb
ADD run.sh /run.sh

CMD ["/run.sh"]