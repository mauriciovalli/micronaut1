FROM maven as maven
WORKDIR /code
COPY . /code/
RUN mvn package -Dmaven.test.skip=true

FROM ghcr.io/graalvm/graalvm-ce:java8-21.1.0 AS build
RUN gu install native-image
WORKDIR /build
COPY --from=maven /code/target/*.jar .
RUN native-image -jar micronaut1-0.1.jar -H:Name=output

FROM scratch
COPY --from=build /build/output /opt/output
CMD ["/opt/output"]