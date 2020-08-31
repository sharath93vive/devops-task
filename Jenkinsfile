properties([
	parameters([
        string(defaultValue: "master", description: 'Which Git Branch to clone?', name: 'GIT_BRANCH')
	])
])

try {

  stage('Checkout'){
    node('master'){
        checkout([$class: 'GitSCM', branches: [[name: '*/$GIT_BRANCH']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/sharath93vive/devops-task.git']]])
    }
  }
  stage('Build'){
      node('master'){
       sh "docker build -t sharath94z/devops-task:${BUILD_NUMBER} ."
    }
  }

  stage('Deploy') {
    node('master'){
        sh "docker run -d -p 8085:5000 sharath94z/devops-task:{BUILD_NUMBER}"
    }
  }

	}
catch (err){
    currentBuild.result = "FAILURE"
    throw err
}