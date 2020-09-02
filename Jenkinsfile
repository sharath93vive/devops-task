properties([pipelineTriggers([githubPush()])])

try {

  stage('Checkout'){
    node('master'){
        checkout([$class: 'GitSCM', branches: [[name: 'master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/sharath93vive/devops-task.git']]])
    }
  }
  stage('Build'){
      node('master'){
       sh "docker build -t sharath94z/devops-task:${BUILD_NUMBER} ."
    }
  }

  stage('Destroy'){
    node('master'){
      sh ./container-destroy.sh
    }
  }

  stage('Deploy') {
    node('master'){
        sh "docker run -d -p 8085:5000 --name devops-task sharath94z/devops-task:${BUILD_NUMBER}"
    }
  }

	}
catch (err){
    currentBuild.result = "FAILURE"
    throw err
}
