SUCCESS_STAGE = 'build'
STEPS = 'build Testing REES46 PersonaClick Kameleoon'
def stepPublisher(step, style) {
   rabbitMQPublisher(rabbitName: 'rabbit', exchange: '', routingKey: 'notification', conversion: false,
      data: "{\"type\":\"deploy\",\"project\":\"${JOB_NAME}\",\"style\":\"${style}\",\"step\":\"${step}\",\"message\":\"${GIT_COMMIT_MSG}\",\"commit\":\"${GIT_COMMIT}\",\"url\":\"${COMMIT_URL}\",\"author\":\"${GIT_COMMIT_AUTHOR}\",\"console\":\"${BUILD_URL}console\",\"steps\":\"${STEPS}\"}")
}

pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
              sh 'bin/prepare_for_jenkins'
              script {
                env.GIT_COMMIT_MSG = sh (script: 'git log -1 --pretty=%B ${GIT_COMMIT}', returnStdout: true).trim()
                env.GIT_COMMIT_AUTHOR = sh (script: 'git log -1 --pretty=%an ${GIT_COMMIT}', returnStdout: true).trim()
                env.COMMIT_URL = "https://github.com/rees46/api-reference/commit/${GIT_COMMIT}"
              }
            }
        }
        stage('Testing') {
            steps {
                script {
                    SUCCESS_STAGE = 'testing'
                }
                stepPublisher(SUCCESS_STAGE, 'SECONDARY')
                sh 'bin/testing'
            }
        }
        stage('REES46') {
            steps {
                script {
                    SUCCESS_STAGE = 'rees46'
                }
                stepPublisher(SUCCESS_STAGE, 'SECONDARY')
                sh 'bin/deploy_r46'
            }
        }
        stage('PersonaClick') {
            steps {
                script {
                    SUCCESS_STAGE = 'PersonaClick'
                }
                stepPublisher(SUCCESS_STAGE, 'SECONDARY')
                sh 'bin/deploy_pc'
            }
        }
        stage('Kameleoon') {
            steps {
                script {
                    SUCCESS_STAGE = 'Kameleoon'
                }
                stepPublisher(SUCCESS_STAGE, 'SECONDARY')
		            sh 'bin/deploy_kameleoon'
            }
        }

    }
    post {
      failure {
        stepPublisher(SUCCESS_STAGE, 'ERROR')
      }

      aborted {
        stepPublisher(SUCCESS_STAGE, 'WARNING')
      }

      success {
        stepPublisher(SUCCESS_STAGE, 'SUCCESS')
      }
    }
}
