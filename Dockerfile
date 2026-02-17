FROM mariadb:12.2.2

LABEL org.opencontainers.image.title="openemr-mariadb" \
			org.opencontainers.image.description="MariaDB 12.2.2 image for OpenEMR"

# Configuración recomendada para OpenEMR
COPY mariadb-openemr.cnf /etc/mysql/conf.d/99-openemr.cnf

# Valores base (las credenciales deben pasarse en runtime).
ENV MYSQL_DATABASE=openemr \
		MYSQL_USER=openemr

# Puerto de MariaDB
EXPOSE 3306

# Persistencia de datos
VOLUME ["/var/lib/mysql"]

# Salud básica del contenedor
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=5 \
	CMD mariadb-admin ping -h 127.0.0.1 --silent || exit 1
