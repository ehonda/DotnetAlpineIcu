ARG runtimeImage=sdk

FROM dockerehonda/dotnet/${runtimeImage}-icu-half

RUN apk --no-cache add icu-data-full
