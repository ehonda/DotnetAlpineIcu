# Try runtimes: sdk, runtime, aspnet
ARG runtimeImage=sdk

FROM mcr.microsoft.com/dotnet/sdk:7.0-alpine AS build

WORKDIR /src

COPY . .

RUN dotnet publish -c Release -o /src/publish

FROM mcr.microsoft.com/dotnet/${runtimeImage}:7.0-alpine AS runtime

WORKDIR /app

COPY --from=build /src/publish .
COPY --from=build /src/entrypoint.sh /bin

ENTRYPOINT [ "/bin/sh", "-c", "/bin/entrypoint.sh" ]
