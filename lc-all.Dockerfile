ARG runtimeImage=sdk

FROM dockerehonda/dotnet/${runtimeImage}-icu-full

ARG locale=en_US.UTF-8

ENV LC_ALL=${locale} \
    LANG=${locale}
