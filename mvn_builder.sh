#!/bin/bash
echo "Maven Builder Adoptium Temurin OpenJDK8"

export MAVEN_ARGS="-e -B -DskipTests -Djava.net.preferIPv4Stack=true -Dmaven.repo.local=/opt/maven/.m2 -s configuration/settings.xml --log-file=/workspace/source/build.log"
if [ ! -z "$MVN_ARGS" ]
then	
	export MAVEN_ARGS="$MAVEN_ARGS $MVN_ARGS"
fi

if [ -z "$MVN_SSL" ]
then	
	export MAVEN_SSL="-Dmaven.wagon.http.ssl.insecure=false"
else	
	export MAVEN_SSL="-Dmaven.wagon.http.ssl.insecure=$MVN_SSL"
fi

if [ -z "$MVN_GOALS" ]
then	
	export MAVEN_GOALS="clean install"
else	
	export MAVEN_GOALS="$MVN_GOALS"
fi

echo "INFO exec mvn $MAVEN_ARGS $MAVEN_SSL $MAVEN_GOALS"
mvn $MAVEN_ARGS $MAVEN_SSL $MAVEN_GOALS
echo "View logs in build.log"
cat /workspace/source/build.log