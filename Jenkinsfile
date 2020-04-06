pipeline {
  agent { label 'mainci-jenkins-slave' }
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  triggers {
    cron('@daily')
  }
  stages {
    stage('Build') {
      steps {
        sh 'docker build -t nickpack/jenkins-jnlp-docker-python:latest .'
      }
    }
    stage('Publish') {
      when {
        branch 'master'
      }
      steps {
        withDockerRegistry([ credentialsId: "docker", url: "" ]) {
          sh 'docker push nickpack/jenkins-jnlp-docker-python:latest'
        }
      }
    }
  }
}
