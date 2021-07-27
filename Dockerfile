FROM maven as maven
WORKDIR /code
COPY . /code/
RUN mvn package -Dmaven.test.skip=true

FROM ghcr.io/graalvm/graalvm-ce:java8-21.1.0 AS build
RUN gu install native-image
WORKDIR /build
COPY --from=maven /code/target/*.jar .
RUN native-image --verbose -J-Xmx6g -jar micronaut1-0.1.jar -H:Name=application --no-fallback

FROM frolvlad/alpine-glibc:alpine-3.12
EXPOSE 8080
RUN apk update && apk add libstdc++
COPY --from=build /build/application /app/application
ENTRYPOINT ["/app/application"]

#FROM scratch
#EXPOSE 8080
#CMD ["/app/application"]