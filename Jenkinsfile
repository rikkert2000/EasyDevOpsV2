pipeline {
    agent any
    
    environment {
        // Definieer de omgeving variabelen indien nodig
    }

    stages {
        stage('Checkout') {
            steps {
                // Haal de code op uit de GitHub repository
                git credentialsId: '1d59f8ec-3763-44db-becd-9bee64c89704', url: 'https://github.com/rikkert2000/EasyDevOpsV2.git'

            }
        }
        
        stage('Install Dependencies') {
            steps {
                script {
                    // Installeer de benodigde afhankelijkheden (bijvoorbeeld voor een Node.js app)
                    sh 'npm install'
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    // Bouw de frontend applicatie
                    sh 'npm run build'
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // Voer de tests uit
                    sh 'npm run test'
                }
            }
        }

        stage('Security Scan') {
            steps {
                script {
                    // Voer een security scan uit, bijvoorbeeld met OWASP Dependency-Check
                    sh 'dependency-check --project EasyDevOpsV2 --scan .'
                }
            }
        }
    }

    post {
        always {
            // Acties die altijd uitgevoerd worden na de pipeline, bijvoorbeeld schoonmaken
            echo 'Pipeline voltooid.'
        }

        success {
            echo 'De build is succesvol!'
        }

        failure {
            echo 'Er is een fout opgetreden in de build.'
        }
    }
} 
//gr
