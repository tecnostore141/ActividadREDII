MV1
# 1. Asegúrate que tu Registry esté corriendo (si no lo está)
docker start registry || docker run -d -p 5000:5000 --restart=always --name registry registry:2

# 2. Construir y Subir ARTICUNO
cd ~/web/articuno
docker build -t articuno-local .
docker tag articuno-local 192.168.1.102:5000/articuno:latest
docker push 192.168.1.102:5000/articuno:latest

# 3. Construir y Subir SEADRA
cd ~/web/seadra
docker build -t seadra-local .
docker tag seadra-local 192.168.1.102:5000/seadra:latest
docker push 192.168.1.102:5000/seadra:latest

# 4. (Opcional) Si el repo tiene configuración de DNS y quieres actualizarla:
# cd ~/dns ... (comandos de build/run del DNS)


*******************************************************************************************************
MV2
# 1. Bajar las imágenes actualizadas desde la MV1
docker pull 192.168.1.102:5000/articuno:latest
docker pull 192.168.1.102:5000/seadra:latest

# 2. Limpiar contenedores viejos (por si acaso)
docker rm -f articuno_container seadra_container proxy_container

# 3. Levantar Sitios Web
docker run -d --name articuno_container --restart unless-stopped 192.168.1.102:5000/articuno:latest
docker run -d --name seadra_container --restart unless-stopped 192.168.1.102:5000/seadra:latest

# 4. Levantar el Proxy (Usando la carpeta del repo clonado)
cd ~/proyecto/proxy

# Construir imagen del proxy (usa el Dockerfile y default.conf del repo)
docker build -t proyecto-reverse-proxy .

# Ejecutar Proxy enlazado
docker run -d -p 80:80 -p 443:443 --name proxy_container --restart unless-stopped --link articuno_container --link seadra_container proyecto-reverse-proxy
