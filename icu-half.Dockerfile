ARG runtimeImage=sdk

FROM mcr.microsoft.com/dotnet/${runtimeImage}:7.0-alpine

RUN apk --no-cache add icu-libs

ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false
