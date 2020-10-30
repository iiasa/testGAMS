pipeline {
    agent any
    stages {
        stage('Clean') {
            steps {
                sh 'make clean'
            }
        }
        stage('Build') {
            steps {
                sh 'make build'
            }
        }
        stage('Check') {
            steps {
                sh 'make check'
            }
        }
    }
    post {
        success {
            sh 'make coverage'
            cobertura coberturaReportFile: 'cobertura.xml'
        }
        always {
            junit(
                allowEmptyResults: true,
                testResults: 'testGAMS.Rcheck/tests/junit_result.xml'
            )
        }
    }
}
