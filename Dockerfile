# Utilizar una imagen de base que incluya Java y Liquibase
FROM liquibase/liquibase:3.10

# Descargar los archivos JAR del controlador MongoDB directamente desde Maven Central
RUN curl -L -o /liquibase/lib/mongodb-driver-core-4.9.1.jar https://repo1.maven.org/maven2/org/mongodb/mongodb-driver-core/4.9.1/mongodb-driver-core-4.9.1.jar
RUN curl -L -o /liquibase/lib/mongodb-driver-sync-4.9.1.jar https://repo1.maven.org/maven2/org/mongodb/mongodb-driver-sync/4.9.1/mongodb-driver-sync-4.9.1.jar

# Definir el directorio de trabajo en el contenedor
WORKDIR /liquibase/changelog

# Ejecutar el comando para aplicar los cambios usando Liquibase con el controlador MongoDB
CMD ["liquibase", "--classpath=/liquibase/changelog:/liquibase/lib/mongodb-driver-core-4.9.1.jar:/liquibase/lib/mongodb-driver-sync-4.9.1.jar", "--url=mongodb://192.168.2.149:27077/devops", "--changeLogFile=/liquibase/changelog/my_app-wrapper.xml", "--username=devops", "--password=devops9095", "update"]