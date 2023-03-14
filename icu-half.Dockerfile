ARG runtimeImage=sdk

FROM dockerehonda/dotnet/${runtimeImage}-plain

RUN apk --no-cache add icu-libs

ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false
