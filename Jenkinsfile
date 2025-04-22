pipeline {
    agent {
        label 'Build'  // Ensure this matches your node label in Jenkins
    }
    stages {
        stage("Installing Git and Docker") {
            steps {
                // Update package list and install Docker and Git
                sh "sudo apt update -y"
                sh "sudo apt install docker.io git -y"  // Use docker.io package on Ubuntu
                sh "sudo systemctl start docker"  // Start Docker service
                sh "sudo systemctl enable docker"  // Enable Docker to start on boot
                sh "sudo systemctl status docker"  // Check if Docker is running
            }
        }
        stage("Pull, Build, Verify image") {
            steps {
                // Pull code from GitHub and build Docker image
                sh 'echo "Pulling Dockerfile from GitHub"'
                sh 'sudo git clone https://github.com/deepak-devautomation09/Devops_Jenkins_Project.git'  // Replace with your actual GitHub repo URL
                sh 'echo "Building Docker image and checking status"'
                sh 'sudo docker build -t mynewimage:v$BUILD_NUMBER .'  // Build the Docker image with a unique version tag
                sh 'sudo docker images | grep "mynewimage"'  // Verify if image is built successfully
            }
        }
        stage("Approval Required") {
            steps {
                script {
                    input message: 'Do you want to proceed to the next stage?', ok: 'Yes'  // Pause for manual approval
                }
            }
        }
        stage("Build Container") {
            steps {
                // Create and run Docker container from the built image
                sh 'echo "Building Docker container"'
                sh "echo $BUILD_NUMBER"  // Output the build number (a Jenkins predefined variable)
                sh 'sudo docker run -d --name container_$BUILD_NUMBER -p 30$BUILD_NUMBER:3000 mynewimage:v$BUILD_NUMBER'  // Run container with dynamic port mapping
                sh 'sudo docker ps -a | grep $BUILD_NUMBER'  // Verify if the container is running
            }
        }
        stage("Clean Workspace") {
            steps {
                cleanWs()  // Clean up the workspace after execution
            }
        }
    }
}
