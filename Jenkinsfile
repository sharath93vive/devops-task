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
      sh 'docker ps -a -q --filter="name=devops-task" | wc -l
          if [ $? -eq 0 ]; then
	        echo "Stoppping and deleting previous container " $(docker ps -a -q --filter="name=devops-task")
	        docker rm $(docker stop $(docker ps -a -q --filter="name=devops-task"))
          else
	        echo "No previous container running"
          fi'
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
