pipeline {
    agent none
      stages {
          stage('BrainTumorPredictionDeployment'){
              agent {
                label 'kubernetes_master'
            }
                steps {
                    sh 'sudo kubectl create deployment brain_pod  --image=amitsharma17133129/brain_tumor1:v1' 
                    sh 'sudo kubectl expose deployment brain_pod --type=NodePort  --port=4444'
                    sh 'sudo kubectl get pod -o wide'
                    
                }
        }
         stage('gettingpod'){ 
             agent {
                label 'kubernetes_master'
            }
               steps {
                      sh 'sudo kubectl get pod -o wide '
                      sh 'sudo kubectl get svc'
             }
        }
    }
}
