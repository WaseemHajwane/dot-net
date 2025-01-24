pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Checking out from GitHub...'
                git branch: 'main', url: 'https://github.com/WaseemHajwane/dot-net.git'
            }
        }
        stage('Restore Dependencies') {
            steps {
                echo 'Restoring dependencies...'
                bat 'dotnet restore TestProject/TestProject.sln'
            }
        }
        stage('Build') {
            steps {
                echo 'Building the solution...'
                bat 'dotnet build TestProject/TestProject.sln --configuration Release'
            }
        }
        stage('Publish') {
            steps {
                echo 'Publishing the application...'
                bat 'dotnet publish TestProject/TestProject.sln --configuration Release --output TestProject/publish'
            }
        }
        stage('Debug Workspace') {
            steps {
                echo 'Listing all files in the workspace...'
                bat 'dir /s'
            }
        }
        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                bat '''
                docker build -t testproject:latest -f TestProject/Dockerfile .
                '''
            }
        }
        stage('Run Docker Container') {
            steps {
                echo 'Stopping and removing existing container (if any)...'
                script {
                    try {
                        bat 'docker stop testproject'
                        bat 'docker rm testproject'
                    } catch (Exception e) {
                        echo 'No existing container to stop or remove.'
                    }
                }

                echo 'Running the Docker container...'
                bat '''
                docker run -d --name testproject -p 8081:80 testproject:latest
                '''
            }
        }
    }

    post {
        success {
            echo 'Pipeline executed successfully. Application is deployed using Docker.'
        }
        failure {
            echo 'Pipeline failed. Please check the logs.'
        }
    }
}
