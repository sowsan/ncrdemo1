FROM mcr.microsoft.com/dotnet/core/aspnet:3.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/core/sdk:3.0 AS build
WORKDIR /src
COPY ["web1.csproj", "."]
RUN dotnet restore "web1.csproj"
COPY . .
RUN dotnet build "web1.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "web1.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "web1.dll"]