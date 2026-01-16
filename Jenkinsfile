pipeline {
    agent any

    environment {
        ARM_CLIENT_ID = credentials('ARM_CLIENT_ID')
        ARM_CLIENT_SECRET = credentials('ARM_CLIENT_SECRET')
        ARM_TENANT_ID = credentials('ARM_TENANT_ID')
        ARM_SUBSCRIPTION_ID = credentials('ARM_SUBSCRIPTION_ID')
    }

    stages {
        stage('Checkout code') {
            steps {
                git branch: 'master', url: 'https://azlab6cbe@dev.azure.com/azlab6cbe/rishi-new-project/_git/rishi-new-project'
            }
        }

        stage('Terraform Init') {
            steps {
                // script{
                //     if (isUnix()){
                //     sh 'terraform init'
                // } else{
                //     bat 'terraform init'
                // }
                // }
                bat 'terraform init'
                
            }
        }

        stage('Terraform Plan') {
            steps {
                bat '''
                terraform plan ^
                -var "subscription_id=$ARM_SUBSCRIPTION_ID" ^
                -var "client_id=$ARM_CLIENT_ID" ^
                -var "client_secret=$ARM_CLIENT_SECRET" ^
                -var "tenant_id=$ARM_TENANT_ID"
                '''
            }
        }

        stage('Approval') {
            steps {
                input message: 'Approve to apply changes?', ok: 'Apply'
            }
        }

        stage('Terraform Apply') {
            steps {
                bat '''
                terraform apply -auto-approve ^
                -var "subscription_id=$ARM_SUBSCRIPTION_ID" ^
                -var "client_id=$ARM_CLIENT_ID" ^
                -var "client_secret=$ARM_CLIENT_SECRET" ^
                -var "tenant_id=$ARM_TENANT_ID"
                '''
            }
        }

        // Uncomment and enable this section for Terraform destroy if needed
        /*
        stage('Terraform Destroy') {
            steps {
                input message: 'Approve resource deletion?', ok: 'Destroy'
                bat '''
                terraform destroy -auto-approve ^
                -var "subscription_id=$ARM_SUBSCRIPTION_ID" ^
                -var "client_id=$ARM_CLIENT_ID" ^
                -var "client_secret=$ARM_CLIENT_SECRET" ^
                -var "tenant_id=$ARM_TENANT_ID"
                '''
            }
        }
        */
    }
}
