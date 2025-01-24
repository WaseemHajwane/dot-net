# Step 1: Use a base image with the runtime environment
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app

# Step 2: Use a base image with the SDK environment for building the project
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy the project files and restore dependencies
COPY TestProject/ ./TestProject/
RUN dotnet restore TestProject.sln

# Build and publish the project
RUN dotnet publish TestProject.sln --configuration Release --output /app/publish

# Step 3: Use the runtime image for deployment
FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .

# Expose port 80 for the application
EXPOSE 80

# Step 4: Define the entry point for the container
ENTRYPOINT ["dotnet", "TestProject.dll"]
