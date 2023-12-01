FROM quay.io/keycloak/keycloak:19.0 as builder

ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_DB=postgres
RUN curl -sL https://github.com/aerogear/keycloak-metrics-spi/releases/download/2.5.3/keycloak-metrics-spi-2.5.3.jar -o /opt/keycloak/providers/keycloak-metrics-spi-2.5.3.jar
RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:19.0
COPY --from=builder /opt/keycloak/ /opt/keycloak/
WORKDIR /opt/keycloak
ENV KC_PROXY=edge
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]