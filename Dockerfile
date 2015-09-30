FROM debian:jessie
MAINTAINER Petr Vitek "rattus.PV@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

# Basic packages + cleanup
RUN apt-get update && apt-get install -y --no-install-recommends \
	supervisor \
	postfix \
	sasl2-bin && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy supervisor configuration
COPY ./config/supervisor.conf /etc/supervisor/conf.d/supervisord-postfix.conf

# postfix startup and config
COPY ./postfix.sh /opt/postfix.sh

# The following options set parameters needed by Postfix to enable, Cyrus-SASL support for authentication of mail clients.
COPY ./postfix-configure.sh /opt/postfix-configure-sasl.sh

RUN chmod +x /opt/postfix.sh && \
	chmod +x /opt/postfix-configure-sasl.sh && \
	postconf -F '*/*/chroot = n' && \
	postconf -e smtpd_sasl_auth_enable=yes && \
	postconf -e broken_sasl_auth_clients=yes && \
	postconf -e smtpd_recipient_restrictions=permit_sasl_authenticated,reject_unauth_destination

EXPOSE 25

#run supervisord with explicit config file
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord-postfix.conf", "-n"]
