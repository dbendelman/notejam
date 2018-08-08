pipeline {
    agent any
    stages {

        stage('Build') {
            steps {
                git url: 'https://github.com/dbendelman/notejam', branch: "$BRANCH_NAME"
                sh "bash flask/deploy/build.sh"
            }
        }

        stage('Publish') {
            steps {
                git url: 'https://github.com/dbendelman/notejam', branch: "$BRANCH_NAME"
                sh "bash flask/deploy/publish.sh"
            }
        }

        stage('Test') {
            steps {
                git url: 'https://github.com/dbendelman/notejam', branch: "$BRANCH_NAME"
                sh "bash flask/deploy/test.sh"
            }
        }

        stage('Deploy') {
            when {
                expression { env.BRANCH_NAME == 'master' }
            }
            steps {
                git url: 'https://github.com/dbendelman/notejam', branch: "$BRANCH_NAME"
                sh "bash flask/deploy/deploy.sh"
            }
        }

    }
}
