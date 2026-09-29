# Build Stage
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src
COPY ["BlazorApp/BlazorApp.csproj", "BlazorApp/"]
COPY ["BlazorApp.Client/BlazorApp.Client.csproj", "BlazorApp.Client/"]
RUN dotnet restore "BlazorApp/BlazorApp.csproj"
COPY . .
RUN dotnet build "BlazorApp/BlazorApp.csproj" -c Release -o /app/build

# Publish Stage
FROM build AS publish
RUN dotnet publish "BlazorApp/BlazorApp.csproj" -c Release -o /app/publish /p:UseAppHost=false

# Final/Runtime Stage
FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS base
WORKDIR /app
EXPOSE 8080
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "BlazorApp.dll"]


