pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "my-opencart"  // Name for the Docker image
        DOCKER_TAG = "latest"         // Tag for the Docker image
        DOCKER_HUB_CREDENTIALS = 'docker-hub-credentials'  // Jenkins credentials ID for Docker Hub
        GIT_REPO = "https://github.com/yourusername/your-opencart-repo.git"  // Replace with your GitHub repo
    }

    stages {
        stage('Clone repository') {
            steps {
                // Clone the GitHub repository
                git branch: 'main', url: "${env.GIT_REPO}"
            }
        }

        stage('Build Docker image') {
            steps {
                script {
                    // Build the Docker image from the Dockerfile
                    sh "docker build -t ${env.DOCKER_IMAGE}:${env.DOCKER_TAG} ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    // Log in to Docker Hub
                    withCredentials([usernamePassword(credentialsId: "${env.DOCKER_HUB_CREDENTIALS}", usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh "echo ${DOCKER_PASS} | docker login -u ${DOCKER_USER} --password-stdin"
                    }
                    // Push the image to Docker Hub
                    sh "docker push ${env.DOCKER_IMAGE}:${env.DOCKER_TAG}"
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Run the container
                    sh "docker run -d -p 8080:80 ${env.DOCKER_IMAGE}:${env.DOCKER_TAG}"
                }
            }
        }
    }

    post {
        always {
            // Clean up Docker environment
            sh 'docker system prune -f'
        }
    }
}
