# Overview

Experiments with globalization APIs and alpine-based dotnet docker images.

## Relevant links

* [Sample Dockerfile enabling globalization APIs](https://github.com/dotnet/dotnet-docker/blob/main/samples/dotnetapp/Dockerfile.alpine-x64#L19)
* [aspnet-Dockerfile](https://github.com/dotnet/dotnet-docker/blob/656df82a9c18cb78f200d66e8aee20826c0d17fb/src/aspnet/7.0/alpine3.17/amd64/Dockerfile)
* [LC_ALL and LANG Stackoverflow](https://unix.stackexchange.com/q/87745)

## Sample output

```console
$ ./demo.sh
Preparing runtime image dockerehonda/dotnet/sdk-plain
Preparing runtime image dockerehonda/dotnet/runtime-plain
Preparing runtime image dockerehonda/dotnet/aspnet-plain
Preparing runtime image dockerehonda/dotnet/sdk-icu-half
Preparing runtime image dockerehonda/dotnet/runtime-icu-half
Preparing runtime image dockerehonda/dotnet/aspnet-icu-half
Preparing runtime image dockerehonda/dotnet/sdk-icu-full
Preparing runtime image dockerehonda/dotnet/runtime-icu-full
Preparing runtime image dockerehonda/dotnet/aspnet-icu-full
Preparing runtime image dockerehonda/dotnet/sdk-lc-all
Preparing runtime image dockerehonda/dotnet/runtime-lc-all
Preparing runtime image dockerehonda/dotnet/aspnet-lc-all

Preparing application image dockerehonda/dotnet-alpine-icu-console/sdk-plain
Preparing application image dockerehonda/dotnet-alpine-icu-console/runtime-plain
Preparing application image dockerehonda/dotnet-alpine-icu-console/aspnet-plain
Preparing application image dockerehonda/dotnet-alpine-icu-console/sdk-icu-half
Preparing application image dockerehonda/dotnet-alpine-icu-console/runtime-icu-half
Preparing application image dockerehonda/dotnet-alpine-icu-console/aspnet-icu-half
Preparing application image dockerehonda/dotnet-alpine-icu-console/sdk-icu-full
Preparing application image dockerehonda/dotnet-alpine-icu-console/runtime-icu-full
Preparing application image dockerehonda/dotnet-alpine-icu-console/aspnet-icu-full
Preparing application image dockerehonda/dotnet-alpine-icu-console/sdk-lc-all
Preparing application image dockerehonda/dotnet-alpine-icu-console/runtime-lc-all
Preparing application image dockerehonda/dotnet-alpine-icu-console/aspnet-lc-all

Running application image dockerehonda/dotnet-alpine-icu-console/sdk-plain
icu-data-full-72.1-r1 x86_64 {icu} (MIT ICU Unicode-TOU) [installed]
icu-libs-72.1-r1 x86_64 {icu} (MIT ICU Unicode-TOU) [installed]
DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = false
en - 1.5 - ✅
de - 1,5 - ✅

Running application image dockerehonda/dotnet-alpine-icu-console/runtime-plain
DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = true
Unhandled exception. System.Globalization.CultureNotFoundException: Only the invariant culture is supported in globalization-invariant mode. See https://aka.ms/GlobalizationInvariantMode for more information. (Parameter 'name')
en is an invalid culture identifier.
   at System.Globalization.CultureInfo..ctor(String name, Boolean useUserOverride)
   at System.Globalization.CultureInfo.CreateSpecificCulture(String name)
   at Program.<<Main>$>g__CheckGlobalization|0_0(String cultureName, Double number, String expectedGlobalizedNumberRepresentation) in /src/DotnetAlpineIcu.Console/Program.cs:line 8
   at Program.<Main>$(String[] args) in /src/DotnetAlpineIcu.Console/Program.cs:line 3
Aborted
134

Running application image dockerehonda/dotnet-alpine-icu-console/aspnet-plain
DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = true
Unhandled exception. System.Globalization.CultureNotFoundException: Only the invariant culture is supported in globalization-invariant mode. See https://aka.ms/GlobalizationInvariantMode for more information. (Parameter 'name')
en is an invalid culture identifier.
   at System.Globalization.CultureInfo..ctor(String name, Boolean useUserOverride)
   at System.Globalization.CultureInfo.CreateSpecificCulture(String name)
   at Program.<<Main>$>g__CheckGlobalization|0_0(String cultureName, Double number, String expectedGlobalizedNumberRepresentation) in /src/DotnetAlpineIcu.Console/Program.cs:line 8
   at Program.<Main>$(String[] args) in /src/DotnetAlpineIcu.Console/Program.cs:line 3
134
Aborted

Running application image dockerehonda/dotnet-alpine-icu-console/sdk-icu-half
icu-data-full-72.1-r1 x86_64 {icu} (MIT ICU Unicode-TOU) [installed]
icu-libs-72.1-r1 x86_64 {icu} (MIT ICU Unicode-TOU) [installed]
DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = false
en - 1.5 - ✅
de - 1,5 - ✅

Running application image dockerehonda/dotnet-alpine-icu-console/runtime-icu-half
icu-libs-72.1-r1 x86_64 {icu} (MIT ICU Unicode-TOU) [installed]
icu-data-en-72.1-r1 x86_64 {icu} (MIT ICU Unicode-TOU) [installed]
DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = false
en - 1.5 - ✅
de - 1.5 - ❌

Running application image dockerehonda/dotnet-alpine-icu-console/aspnet-icu-half
icu-libs-72.1-r1 x86_64 {icu} (MIT ICU Unicode-TOU) [installed]
icu-data-en-72.1-r1 x86_64 {icu} (MIT ICU Unicode-TOU) [installed]
DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = false
en - 1.5 - ✅
de - 1.5 - ❌

Running application image dockerehonda/dotnet-alpine-icu-console/sdk-icu-full
icu-data-full-72.1-r1 x86_64 {icu} (MIT ICU Unicode-TOU) [installed]
icu-libs-72.1-r1 x86_64 {icu} (MIT ICU Unicode-TOU) [installed]
DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = false
en - 1.5 - ✅
de - 1,5 - ✅

Running application image dockerehonda/dotnet-alpine-icu-console/runtime-icu-full
icu-data-full-72.1-r1 x86_64 {icu} (MIT ICU Unicode-TOU) [installed]
icu-libs-72.1-r1 x86_64 {icu} (MIT ICU Unicode-TOU) [installed]
DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = false
en - 1.5 - ✅
de - 1,5 - ✅

Running application image dockerehonda/dotnet-alpine-icu-console/aspnet-icu-full
icu-data-full-72.1-r1 x86_64 {icu} (MIT ICU Unicode-TOU) [installed]
icu-libs-72.1-r1 x86_64 {icu} (MIT ICU Unicode-TOU) [installed]
DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = false
en - 1.5 - ✅
de - 1,5 - ✅

Running application image dockerehonda/dotnet-alpine-icu-console/sdk-lc-all
icu-data-full-72.1-r1 x86_64 {icu} (MIT ICU Unicode-TOU) [installed]
icu-libs-72.1-r1 x86_64 {icu} (MIT ICU Unicode-TOU) [installed]
DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = false
LC_ALL = en_US.UTF-8
LANG = en_US.UTF-8
en - 1.5 - ✅
de - 1,5 - ✅

Running application image dockerehonda/dotnet-alpine-icu-console/runtime-lc-all
icu-data-full-72.1-r1 x86_64 {icu} (MIT ICU Unicode-TOU) [installed]
icu-libs-72.1-r1 x86_64 {icu} (MIT ICU Unicode-TOU) [installed]
DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = false
LC_ALL = en_US.UTF-8
LANG = en_US.UTF-8
en - 1.5 - ✅
de - 1,5 - ✅

Running application image dockerehonda/dotnet-alpine-icu-console/aspnet-lc-all
icu-data-full-72.1-r1 x86_64 {icu} (MIT ICU Unicode-TOU) [installed]
icu-libs-72.1-r1 x86_64 {icu} (MIT ICU Unicode-TOU) [installed]
DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = false
LC_ALL = en_US.UTF-8
LANG = en_US.UTF-8
en - 1.5 - ✅
de - 1,5 - ✅
```
