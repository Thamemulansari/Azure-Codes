pipeline {
agent any

  environment {
    TF_IN_AUTOMATION = 'true'
    TF_LOG = 'TRACE'
    TF_LOG_PATH = '/tmp/TF.log'
    SERVER_NAME="${params.servername}"
    LOCATION = "${params.loc}"
  }

  parameters {
        string(name: 'servername', defaultValue: '', description: 'Input the Virtual Machine Name.')
    }

  stages {
    stage('New-Check-Out') {
         steps {
            sh '''
            az login --identity
            rm -rf Azure-Codes
            '''
            checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: 'Azure-Codes' ]], userRemoteConfigs: [[credentialsId:'1141b5b2-34ce-4407-b823-9e10f6fb28bf',url: 'https://github.com/Thamemulansari/Azure-Codes.git']]])
            sh '''
            pwd
            ls
            '''
         }
    }
    stage('Terraform plan') {
      when {
        expression { params.action == 'Plan' }
        }
      steps {
        sh '''
        cd ${LOCATION}
        #!/bin/sh
        {
          ENVLI="$(terragrunt workspace list | grep ${SERVER_NAME})"
        } || {
          ENVLI=""
        }
        if [ -z $ENVLI ]
          then
            terragrunt workspace new ${SERVER_NAME}
            terragrunt workspace list
            terragrunt workspace select ${SERVER_NAME}
            terragrunt plan --var-file="${SERVER_NAME}.tfvars"
          else
            echo "Terraform workspace found !! Proceeding with existing workspace"
            terragrunt workspace list
            terragrunt workspace select ${SERVER_NAME}
            terragrunt plan --var-file="${SERVER_NAME}.tfvars"
        fi
        '''
        sh '''
            rm -rf Azure-Codes
        '''
      }
    }

    stage('Terraform apply') {
      when {
        expression { params.action == 'Apply' }
        }
      steps {
        sh '''
        cd ${LOCATION}
        #!/bin/sh
        {
          ENVLI="$(terragrunt workspace list | grep ${SERVER_NAME})"
        } || {
          ENVLI=""
        }
        if [ -z $ENVLI ]
          then
            terragrunt workspace new ${SERVER_NAME}
            terragrunt workspace list
            terragrunt workspace select ${SERVER_NAME}
            terragrunt apply --var-file="${SERVER_NAME}.tfvars" --auto-approve
          else
            echo "Terraform workspace found !! Proceeding with existing workspace"
            terragrunt workspace list
            terragrunt workspace select ${SERVER_NAME}
            terragrunt apply --var-file="${SERVER_NAME}.tfvars" --auto-approve
        fi
        '''
        sh '''
            rm -rf Azure-Codes
        '''        
      }
    }
    stage('Terraform destroy') {
      when {
        expression { params.action == 'Destroy' }
        }
      steps {
        sh '''
        cd ${LOCATION}
        #!/bin/sh
        {
          ENVLI="$(terragrunt workspace list | grep ${SERVER_NAME})"
        } || {
          ENVLI=""
        }
        if [ -z $ENVLI ]
          then
            echo "The Resource is not Manged by Terraform"
          else
            echo "Terraform workspace found !! Proceeding with existing workspace"
            terragrunt workspace list
            terragrunt workspace select ${SERVER_NAME}
            terragrunt destroy --var-file="${SERVER_NAME}.tfvars" --auto-approve
            terragrunt workspace select default
            terragrunt workspace delete ${SERVER_NAME}
        fi
        '''
        sh '''
            rm -rf Azure-Codes
        '''        
      }
    }

  }
}
