pipeline {
    agent any
    tools {
        jdk 'jdk17'
        maven 'maven3'
    }
    triggers {
        cron('H 6 * * *')
    }
    parameters {
        string(name: 'TAGS', defaultValue: '', description: 'Optional, e.g. @smoke')
    }
    stages {
        stage('API tests') {
            steps {
                script {
                    def tagArg = params.TAGS ? "-Dkarate.options=\"--tags ${params.TAGS}\"" : ''
                    sh "mvn -B test ${tagArg}"
                }
            }
        }
    }
    post {
        always {
            junit 'target/surefire-reports/*.xml'
            archiveArtifacts artifacts: 'target/karate-reports/**', allowEmptyArchive: true
        }
    }
}
