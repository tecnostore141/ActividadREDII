FROM nginx:alpine

# Eliminar configuración por defecto
RUN rm /etc/nginx/conf.d/default.conf

# Copiar nuestra configuración
COPY default.conf /etc/nginx/conf.d/

# Copiar certificados
COPY certs/ /etc/nginx/certs/
