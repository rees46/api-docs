pipeline {
    agent any

    parameters {

      string(name: 'CHANNEL_NAME',
             description: 'Default Slack channel to send messages to',
             defaultValue: '#dev-builds')

      string(name: 'BASE_URL',
             description: 'Default Slack BASE URL',
             defaultValue: 'https://rees46.slack.com/services/hooks/jenkins-ci')

      string(name: 'TOKEN_ID',
             description: 'Default Slack secret Credential token id (from jenkins Credential)',
             defaultValue: 'rees46_slack_id')

    }	
    
    environment {
      // Slack configuration
      SLACK_COLOR_DANGER  = '#E01563'
      SLACK_COLOR_INFO    = '#6ECADC'
      SLACK_COLOR_WARNING = '#FFC300'
      SLACK_COLOR_GOOD    = '#3EB991'
    }
    	
    stages {
        stage('Build') {
            steps {
              echo "Sending message to Slack"
              slackSend (color: "${env.SLACK_COLOR_INFO}",
                    channel: "${params.CHANNEL_NAME}",
                    baseUrl: "${params.BASE_URL}",
                    tokenCredentialId: "${params.TOKEN_ID}",
                    message: "*STARTED:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n More info at: ${env.BUILD_URL}")
              sh 'bin/prepare_for_jenkins'
            }
        }
        stage('Testing') {
            steps {
                sh 'bin/testing'
            }
        }
        stage('Deploy') {
            steps {
                sh 'bin/deploy'
                slackSend channel: "#dev-builds", message: "Build is ok: ${env.JOB_NAME} ${env.BUILD_NUMBER} commit: ${env.GIT_COMMIT} by  ${env.GIT_AUTHOR_NAME}"

            }
        }



    }
    post {
      failure {
        echo "Sending message to Slack"
        slackSend (color: "${env.SLACK_COLOR_DANGER}",
                    channel: "${params.CHANNEL_NAME}",
                    baseUrl: "${params.BASE_URL}",
                    tokenCredentialId: "${params.TOKEN_ID}",
                    message: "*FAILED:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n More info at: ${env.BUILD_URL}")
      }

      success {
        echo "Sending message to Slack"
        slackSend (color: "${env.SLACK_COLOR_GOOD}",
                    channel: "${params.CHANNEL_NAME}",
                    baseUrl: "${params.BASE_URL}",
                    tokenCredentialId: "${params.TOKEN_ID}",
                    message: "*SUCCESS:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n More info at: ${env.BUILD_URL}")
      }	
    }
}
