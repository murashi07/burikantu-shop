FROM maven:3.9.4-eclipse-temurin-21 AS build

WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline

COPY src ./src
RUN mvn clean package -DskipTests

FROM eclipse-temurin:21-jre

WORKDIR /app

COPY --from=build /app/target/burikantu_Shop_App-0.0.1-SNAPSHOT.jar .

EXPOSE 9090

ENTRYPOINT ["java","-jar","/app/burikantu_Shop_App-0.0.1-SNAPSHOT.jar"]
