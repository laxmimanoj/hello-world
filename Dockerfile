#Build Stage
FROM microsoft/aspnetcore-build:2 as build-env

LABEL maintainer="laxmimanoj"

WORKDIR /hello-world

COPY *.csproj .

RUN dotnet restore

COPY . .

RUN dotnet publish -o /publish

#Runtime Stage
FROM microsoft/aspnetcore:2 as runtime-env

WORKDIR /publish

COPY --from=build-env /publish .

EXPOSE 8000 

ENTRYPOINT [ "dotnet","hello-world.dll" ]
