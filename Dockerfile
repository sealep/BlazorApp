# Build Stage
FROM ://microsoft.com AS build
WORKDIR /src
COPY ["BlazorApp.csproj", "./"]
RUN dotnet restore "BlazorApp.csproj"
COPY . .
RUN dotnet build "BlazorApp.csproj" -c Release -o /app/build

# Publish Stage
FROM build AS publish
RUN dotnet publish "BlazorApp.csproj" -c Release -o /app/publish /p:UseAppHost=false

# Final/Runtime Stage
FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS base
WORKDIR /app
EXPOSE 8080
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "BlazorApp.dll"]
