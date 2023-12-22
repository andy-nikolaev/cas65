#!/bin/bash
 
version=$(./gradlew -q casVersion)
date=$(date '+%Y%m%d')
WAR='build/libs/cas.war'
 
echo 'Generation version file'
mkdir WEB-INF
string1="$version $date"
echo $string1 > WEB-INF/version
zip -r $WAR WEB-INF/version

#cp pkg/cas/log4j2.xml WEB-INF
#zip -r $WAR WEB-INF/log4j2.xml
rm -rf WEB-INF
 
echo 'Delete conflict files'
zip -d $WAR WEB-INF/lib/bcpkix-jdk15on-1.70.jar
zip -d $WAR WEB-INF/lib/bcprov-jdk15on-1.70.jar
zip -d $WAR WEB-INF/lib/commons-text-1.9.jar

echo 'Update files for fix LDAP error'
zip -d $WAR WEB-INF/lib/cas-server-core-authentication-6.5.5.jar
zip -d $WAR WEB-INF/lib/cas-server-support-ldap-6.5.5.jar

cd extras/ldap
zip -r ../../$WAR WEB-INF
cd ../..

echo 'Update files for CIDRA support'
zip -d $WAR WEB-INF/lib/cas-server-support-radius-core-6.5.5.jar

cd extras/cidra
zip -r ../../$WAR WEB-INF
cd ../..

echo 'Update files for DUO db schema'
zip -d $WAR WEB-INF/lib/cas-server-support-jpa-ticket-registry-6.5.5.jar
zip -d $WAR WEB-INF/lib/cas-server-support-jpa-util-6.5.5.jar

cd extras/duo_universal_fix_db_schema
zip -r ../../$WAR WEB-INF
cd ../..

echo 'Update files for API REST non standart port'
zip -d $WAR WEB-INF/lib/cas-server-core-rest-api-6.5.5.jar

cd extras/rest
zip -r ../../$WAR WEB-INF
cd ../..

echo "Update CVE libs"
zip -d $WAR WEB-INF/lib/h2-1.4.200.jar
zip -d $WAR WEB-INF/lib/hsqldb-2.6.1.jar
zip -d $WAR WEB-INF/lib/postgresql-42.3.2.jar
zip -d $WAR WEB-INF/lib/json-20160810.jar

zip -d $WAR WEB-INF/lib/spring-webmvc-5.3.19.jar
# 26.07.2023
zip -d $WAR WEB-INF/lib/spring-security-config-5.6.1.jar
zip -d $WAR WEB-INF/lib/spring-security-web-5.6.1.jar

echo "Üpdate Groove and Thymeleaf"
zip -d $WAR WEB-INF/lib/groovy-3.0.9.jar
zip -d $WAR WEB-INF/lib/groovy-datetime-3.0.9.jar
zip -d $WAR WEB-INF/lib/groovy-extensions-1.1.0.jar
zip -d $WAR WEB-INF/lib/groovy-groovysh-3.0.9.jar
zip -d $WAR WEB-INF/lib/groovy-json-3.0.9.jar
zip -d $WAR WEB-INF/lib/groovy-jsr223-3.0.9.jar
zip -d $WAR WEB-INF/lib/groovy-sql-3.0.9.jar
zip -d $WAR WEB-INF/lib/groovy-templates-3.0.9.jar
zip -d $WAR WEB-INF/lib/groovy-xml-3.0.9.jar
zip -d $WAR WEB-INF/lib/spring-boot-starter-thymeleaf-2.6.3.jar
zip -d $WAR WEB-INF/lib/thymeleaf-3.0.15.RELEASE.jar
zip -d $WAR WEB-INF/lib/thymeleaf-layout-dialect-3.0.0.jar
zip -d $WAR WEB-INF/lib/thymeleaf-spring5-3.0.15.RELEASE.jar


cd updates
zip -r ../$WAR WEB-INF
cd ..

echo "Create package CAS"
mkdir pkg
mkdir pkg/cas
cp build/libs/cas.war pkg/cas
zip -r pam-cas.$version.$date.zip pkg
rm -rf pkg

