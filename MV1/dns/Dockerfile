FROM debian:stable-slim

# Actualizar e instalar Bind9
RUN apt-get update && apt-get install -y bind9 bind9-utils bind9-doc

# Copiar archivos de configuración
COPY named.conf.options /etc/bind/
COPY named.conf.local /etc/bind/
COPY db.articuno.com /etc/bind/
COPY db.seadra.com /etc/bind/

# Exponer puertos DNS (UDP y TCP)
EXPOSE 53/udp
EXPOSE 53/tcp

# Comando para ejecutar Bind9 en primer plano
CMD ["/usr/sbin/named", "-g"]
