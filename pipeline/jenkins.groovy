pipeline {
    agent any

    parameters {
        choice(name: 'OS', choices: ['linux', 'darwin', 'windows'], description: 'OS')
        choice(name: 'ARCH', choices: ['amd64', 'arm', '386'], description: 'ARCH')
    }

    environment {
        REPO = 'https://github.com/pauldon2/ptbot'
        BRANCH = 'develop'
        GITHUB = credentials('github')
        TARGETARCH = "${params.ARCH}"
        TARGETOS = "${params.OS}"
    }

    stages {
        stage('clone') {
            steps {
                echo 'Clone Repository'
                git branch: "${BRANCH}", url: "${REPO}"
            }
        }

        stage('image') {
            steps {
                echo "Building image started"
                sh "printenv"
                sh "make image"
            }
        }

        stage('login to GHCR') {
            steps {
                sh "echo $GITHUB_PSW | docker login ghcr.io -u $GITHUB_USR --password-stdin"
            }
        }
        
        stage('push image') {
            steps {
              sh "make push"
            }
        } 
    }
}