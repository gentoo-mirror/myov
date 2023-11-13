pipeline {

    agent {
        node {
            label 'linux'
        }
    }

    stages {

        stage("test") {
            agent {
                node {
                    // Only x64 only because of OCI container used for Earthly.
                    label 'earthly && linux && x64'
                }
            }

            options {
                timeout(time: 16, unit: "MINUTES")
            }

            steps {
                sh "earthly +test"
            }
        }

    }

}
