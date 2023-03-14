ARG runtimeImage=ehonda/dotnet/sdk-icu-half

FROM mcr.microsoft.com/dotnet/sdk:7.0-alpine AS build

WORKDIR /src

COPY . .

RUN dotnet publish -c Release -o /src/publish

FROM ${runtimeImage} AS runtime

WORKDIR /app

COPY --from=build /src/publish .
COPY --from=build /src/entrypoint.sh /bin

ENTRYPOINT [ "/bin/sh", "-c", "/bin/entrypoint.sh" ]
