FROM ghcr.io/cirruslabs/flutter:3.32.8 AS build

WORKDIR /app

COPY . .

RUN flutter pub get

WORKDIR /app/my_progress_server

RUN dart compile exe bin/main.dart -o bin/server


FROM ghcr.io/cirruslabs/flutter:3.32.8

WORKDIR /app

ENV runmode=production
ENV serverid=default
ENV logging=normal
ENV role=monolith

COPY --from=build /app/my_progress_server/bin/server /app/server
COPY --from=build /app/my_progress_server/config/development.yaml /app/config/development.yaml
COPY --from=build /app/my_progress_server/config/production.yaml /app/config/production.yaml
COPY --from=build /app/my_progress_server/config/staging.yaml /app/config/staging.yaml
COPY --from=build /app/my_progress_server/config/test.yaml /app/config/test.yaml
COPY --from=build /app/my_progress_server/web/ /app/web/
COPY --from=build /app/my_progress_server/migrations/ /app/migrations/
COPY --from=build /app/my_progress_server/lib/src/generated/protocol.yaml /app/lib/src/generated/protocol.yaml

EXPOSE 8080
EXPOSE 8081
EXPOSE 8082

ENTRYPOINT ["/app/server", "--mode=production", "--server-id=default", "--logging=normal", "--role=monolith"]