# Adoptium Temurin OpenJDK8 - OCI Image Maven Builder
Custom Images for Java8 Maven Builder for Tekton Task

Image build with default charset _en_US.UTF-8_

WORKDIR ***/workspace/source***

ENTRYPOINT _/bin/bash_

CMD _mvn_builder.sh_

|Environment Vars|Description|
|---|---|
|MVN_ARGS| set adicional maven args: _-Djava.net.preferIPv4Stack=true_|
|MAVEN_SSL| set maven.wagon.http.ssl.insecure by default: _true_|
|MAVEN_GOALS| set maven goals for compiling by fedault: _clean install_|


### Docker run
```
docker run --env MAVEN_SSL="true" -v SOURCE_FOLDER:/workspace/source demonioazteka/jdk8-maven-builder:latest 
```