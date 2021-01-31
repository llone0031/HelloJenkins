FROM mcr.microsoft.com/dotnet/core/sdk:3.1-buster AS build

WORKDIR /src
COPY ["HelloJenkins/HelloJenkins.csproj", "HelloJenkins/"]
RUN dotnet restore "HelloJenkins/HelloJenkins.csproj"
COPY . .

WORKDIR "/src/HelloJenkins"
RUN dotnet publish "HelloJenkins.csproj" -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/core/sdk:3.1-buster AS final
WORKDIR /app
EXPOSE 80
EXPOSE 443
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "HelloJenkins.dll"]
