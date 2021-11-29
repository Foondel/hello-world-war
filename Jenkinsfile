pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sh 'mvn -f pom.xml clean package'
      }
    }

    stage('SonarCube-test') {
      steps {
        sh '''export SONAR_TOKEN="f56f70c41841c6584787d8bb2540c713aa00499b"
mvn verify org.sonarsource.scanner.maven:sonar-maven-plugin:sonar -Dsonar.projectKey=Foondel_hello-world-war'''
      }
    }

    stage('docker build') {
      steps {
        sh 'docker build -t hello_world_war .'
      }
    }

    stage('docker tag') {
      steps {
        sh 'docker tag hello_world_war:latest 192.168.1.224:8123/hello_world_war:latest'
      }
    }

    stage('docker push') {
      steps {
        nexusPublisher(nexusInstanceId: '192.168.1.224:8123', nexusRepositoryId: 'hello_world_war', tagName: 'latest')
      }
    }

  }
  environment {
    NEXUS_VERSION = 'nexus3'
    NEXUS_PROTOCOL = 'http'
    NEXUS_URL = '192.168.1.224:8123'
    NEXUS_REPOSITORY = 'hello_world_war'
    NEXUS_CREDENTIAL_ID = 'nexus'
  }
}