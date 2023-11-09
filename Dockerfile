FROM eclipse-temurin:17-jdk-alpine AS build

WORKDIR /app

COPY gradle gradle

COPY build.gradle settings.gradle gradlew ./

COPY src src

RUN ./gradlew build -x test

RUN mkdir -p build/libs/dependency && (cd build/libs/dependency; jar -xf ../*-SNAPSHOT.jar)

FROM eclipse-temurin:17-jdk-alpine 
VOLUME /tmp

ARG DEPENDENCY=/app/build/libs/dependency

COPY --from=build ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY --from=build ${DEPENDENCY}/META-INF /app/META-INF
COPY --from=build ${DEPENDENCY}/BOOT-INF/classes /app

EXPOSE 8000

ENTRYPOINT ["java","-cp","app:app/lib/*", "com.javaappforecs.JavaAppForEcsApplication"]

