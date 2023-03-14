# Try runtimes: sdk, runtime, aspnet
ARG runtimeImage=sdk

FROM mcr.microsoft.com/dotnet/sdk:7.0-alpine AS build

WORKDIR /src

COPY . .

RUN dotnet publish -c Release -o /src/publish

FROM mcr.microsoft.com/dotnet/${runtimeImage}:7.0-alpine AS runtime

ENV \
    DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8
RUN apk --no-cache add \
    icu-data-full \
    icu-libs

WORKDIR /app

COPY --from=build /src/publish .
COPY --from=build /src/entrypoint.sh /bin

ENTRYPOINT [ "/bin/sh", "-c", "/bin/entrypoint.sh" ]
