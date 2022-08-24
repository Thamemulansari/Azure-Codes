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
            rm -rf CCM-AZURE
            '''
            checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: 'CCM-AZURE' ]], userRemoteConfigs: [[credentialsId: 'e9983fb9-5359-4db7-b641-2bc161c7a0f2', url: 'https://git-codecommit.ap-southeast-1.amazonaws.com/v1/repos/CCM-AZURE']]])
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
            rm -rf CCM-AZURE
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
            rm -rf CCM-AZURE
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