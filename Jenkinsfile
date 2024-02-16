pipeline {
    agent {
        node {
            // Only x64 only because of OCI container used for Earthly.
            label 'earthly && linux && x64'
        }
    }

    stages {
        stage("test") {
            options {
                timeout(time: 20, unit: "MINUTES")
            }

            steps {
                sh "earthly +test"
            }
        }
    }
}
