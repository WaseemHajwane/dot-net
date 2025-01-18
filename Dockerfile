# Step 1: Use a base image with the runtime environment
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app

# Step 2: Use a base image with the SDK environment for build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy the project files and restore dependencies
COPY TestProject/TestProject.sln ./
COPY TestProject/ ./TestProject/
RUN dotnet restore TestProject/TestProject.sln

# Build the project
RUN dotnet publish TestProject/TestProject.sln --configuration Release --output /app/publish

# Step 3: Copy build artifacts to the runtime image
FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .

# Step 4: Define entry point for the container
ENTRYPOINT ["dotnet", "TestProject.dll"]
