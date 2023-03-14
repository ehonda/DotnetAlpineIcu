ARG runtimeImage=sdk

FROM ehonda/dotnet/${runtimeImage}-icu-half

RUN apk --no-cache add icu-data-full
