#!/usr/bin/env groovy
// Jenkinsfile
// Build and test a Maven project

node {
  checkout scm

  // -v /var/run/docker.sock:/var/run/docker.sock
  docker.image('ruby:2.3.3').inside('-u root') {
    stage('Install Puppet') {
      sh 'gem install puppet --no-ri --no-rdoc'
      sh '/usr/local/bundle/bin/puppet module install autostructure-image_build'
      sh '/usr/local/bundle/bin/puppet docker dockerfile > Dockerfile'
    }
  }

  stage('Build Container') {
     def image = docker.build('docker-local.docker.azcender.com/phpexample:latest')
     image.push()
  }

  deleteDir()
}
