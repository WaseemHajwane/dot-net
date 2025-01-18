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
                echo 'Publishing the application to the specified path...'
                bat '''
                dotnet publish TestProject/TestProject.sln --configuration Release --output D:\\DemoNetProject\\TestProject\\TestProject\\bin\\Release\\net8.0\\publish
                '''
            }
        }
    }

    post {
        success {
            echo 'Pipeline executed successfully. Application is published to the IIS site directory.'
        }
        failure {
            echo 'Pipeline failed. Please check the logs.'
        }
    }
}
