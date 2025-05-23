FROM warriortrading/mvn_jdk11_compiler:IMAGE-5 AS builder

WORKDIR /workspace
# config s3 private repository
ARG AWS_ACCESS_KEY_ID="***AWS_ACCESS_KEY_ID***"
ARG AWS_SECRET_ACCESS_KEY="***AWS_SECRET_ACCESS_KEY***"
ARG AWS_REGION="***AWS_REGION***"
ARG LIBA_VERSION="***LIBA_VERSION***"
RUN echo "<settings> \n\
   <servers> \n\
      <server> \n\
         <id>warriortrading.private.repository</id> \n\
         <username>${AWS_ACCESS_KEY_ID}</username> \n\
         <password>${AWS_SECRET_ACCESS_KEY}</password> \n\
         <configuration> \n\
            <region>${AWS_REGION}</region> \n\
            <publicRepository>false</publicRepository> \n\
         </configuration> \n\
      </server> \n\
   </servers> \n\
</settings> \n" \
   >~/.m2/settings.xml


COPY pom.xml pom.xml
COPY src/ src/

RUN mvn clean package -Dmaven.test.skip=true -Dliba_version=${LIBA_VERSION}
WORKDIR /workspace/target
RUN ls -l /workspace/target
RUN java -jar serviceCApp-1.0-SNAPSHOT.jar
