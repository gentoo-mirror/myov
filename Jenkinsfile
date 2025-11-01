// Documentation: https://www.jenkins.io/doc/book/pipeline/jenkinsfile/

pipeline
{
    agent
    {
        node
        {
            // Only x64 only because of OCI container used for Earthly.
            label 'earthly && linux && x64'
        }
    }

    environment
    {
        TERM = "dumb"
    }

    stages
    {
        stage("checkout")
        {
            steps
            {
                checkout scm
            }
        }

        stage("test")
        {
            options
            {
                timeout(time: 20, unit: "MINUTES")
            }

            steps
            {
                sh "earthly +test"
            }
        }
    }
}
