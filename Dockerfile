# ------------------------------------------------------------------------------
#               NOTE: THIS DOCKERFILE IS GENERATED BY OCI IMAGES PROJECT
#
#                       PLEASE DO NOT EDIT IT DIRECTLY.
# ------------------------------------------------------------------------------
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

FROM registry.access.redhat.com/ubi8/ubi:8.5

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en'
ARG MAVEN_VERSION=3.6.3
ARG SHA=c35a1803a6e70a126e80b2b3ae33eed961f83ed74d18fcd16909b2d44d7dada3203f1ffe726c17ef8dcca2dcaa9fca676987befeadc9b9f759967a8cb77181c0
ARG BASE_URL=https://apache.osuosl.org/maven/maven-3/3.6.3/binaries

RUN dnf install -y tzdata openssl curl ca-certificates fontconfig glibc-langpack-en gzip tar \
    && dnf update -y; dnf clean all

LABEL name="Builder Cloud Apps Adoptium Temurin OpenJDK11" \
      vendor="Adoptium Temurin OpenJDK11" \
      version="jdk8u312-b07" \
      release="8" \
      run="docker run --rm -ti <image_name:tag> -v /workspace/source" \
      summary="Adoptium Temurin OpenJDK8 Docker Image for OpenJDK with hotspot and ubi8" \
      description="For more information on this image please see "
	  
ENV JAVA_VERSION jdk8u312-b07

RUN set -eux; \
    ARCH="$(uname -m)"; \
    case "${ARCH}" in \
       aarch64|arm64) \
         ESUM='87ff502eba3008cac71edeb9595398a73dc14883fe3072d152e731bf0877897e'; \
         BINARY_URL='https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u312-b07/OpenJDK8U-jdk_aarch64_linux_hotspot_8u312b07.tar.gz'; \
         ;; \
       ppc64el|ppc64le) \
         ESUM='ddce3f067eab6fd98bb2a8ea3d18de6b09ea41d10382c76ad22bd3e7895951cf'; \
         BINARY_URL='https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u312-b07/OpenJDK8U-jdk_ppc64le_linux_hotspot_8u312b07.tar.gz'; \
         ;; \
       amd64|x86_64) \
         ESUM='699981083983b60a7eeb511ad640fae3ae4b879de5a3980fe837e8ade9c34a08'; \
         BINARY_URL='https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u312-b07/OpenJDK8U-jdk_x64_linux_hotspot_8u312b07.tar.gz'; \
         ;; \
       *) \
         echo "Unsupported arch: ${ARCH}"; \
         exit 1; \
         ;; \
    esac; \
	curl -kLfsSo /tmp/openjdk.tar.gz ${BINARY_URL}; \
    echo "${ESUM} */tmp/openjdk.tar.gz" | sha256sum -c -; \
    mkdir -p /opt/java/openjdk; \
	mkdir -p /opt/maven; \
	mkdir -p /opt/builder; \
    cd /opt/java/openjdk; \
    tar -xf /tmp/openjdk.tar.gz --strip-components=1; \
    rm -rf /tmp/openjdk.tar.gz; \
	mkdir -p /usr/share/maven /usr/share/maven/ref; \
	curl -kfsSL -o /tmp/apache-maven.tar.gz ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz; \
	echo "${SHA}  /tmp/apache-maven.tar.gz" | sha512sum -c -; \
	tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1; \
	rm -f /tmp/apache-maven.tar.gz; \
	ln -s /usr/share/maven/bin/mvn /usr/bin/mvn;

ENV JAVA_HOME=/opt/java/openjdk \
    PATH="/opt/java/openjdk/bin:$PATH"
	ARG BUILD_VERSION=
	ENV MAVEN_HOME=/usr/share/maven
	ENV MAVEN_CONFIG=/opt/maven/.m2	
    ENV MAVEN_CLEAR_REPO="false"
	WORKDIR /workspace/source
	COPY /mvn_builder.sh /opt/builder
	CMD ["/bin/bash","/opt/builder/mvn_builder.sh","run"]