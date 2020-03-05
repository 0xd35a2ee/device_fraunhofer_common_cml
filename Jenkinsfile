pipeline {
   agent any
   options { checkoutToSubdirectory('trustme/cml') }
   stages {

      /*First stage: Download trustme's source. trustme is a multi-repo project.*/
      stage('Download Repositories') {
        steps {
             sh 'repo init -u https://github.com/trustm3/trustme_main.git -b master -m ids-x86-yocto.xml'
             sh 'repo sync -j8'
             sh '''
               echo branch name from Jenkins: ${BRANCH_NAME}
               cd ${WORKSPACE}/trustme/cml
               if [ ! -z $(git branch --list ${BRANCH_NAME}) ]; then
                  git branch -D ${BRANCH_NAME}
               fi
               git checkout -b ${BRANCH_NAME}
             '''
         }
      }

      stage('Inspect the Codebase') {
          parallel {
              stage('Code Format & Style') {
                  steps {
                      sh '${WORKSPACE}/trustme/cml/scripts/ci/check-if-code-is-formatted.sh'
                  }
              }

              /*
                Intentionally mark the static code analysis stage as skipped
                We want to show that we are performing static code analysis, but not
                as part of Jenkins's pipeline.
               */
              stage('Static Code Analysis') {
                  when {
                      expression {
                          return false
                      }
                  }
                  steps {
                      sh '''
                        echo "Static Code Analysis is performed using Semmle."
                        echo "Please check GitHub's project for results from Semmle's analysis."
                      '''
                  }
              }
          }
      }

      /*
      stage('Codebase') {
         parallel {
            stage('Build') {
               agent { dockerfile {
                  dir 'trustme/build/yocto/docker'
                  args '--entrypoint=\'\' -v /yocto_mirror:/source_mirror'
                  reuseNode true
               } }
               steps {
                  sh '''
                     export LC_ALL=en_US.UTF-8
                     export LANG=en_US.UTF-8
                     export LANGUAGE=en_US.UTF-8
                     if [ -d out-yocto/conf ]; then
                        rm -r out-yocto/conf
                     fi
                     . init_ws.sh out-yocto

                     echo Using branch name ${BRANCH_NAME} in bbappend files
                     cd ${WORKSPACE}/out-yocto
                     echo "BRANCH = \\\"${BRANCH_NAME}\\\"" > cmld_git.bbappend.jenkins
                     cat cmld_git.bbappend >> cmld_git.bbappend.jenkins
                     rm cmld_git.bbappend
                     cp cmld_git.bbappend.jenkins cmld_git.bbappend

                     echo "SOURCE_MIRROR_URL ?= \\\"file:///source_mirror/sources/\\\"" >> conf/local.conf
                     echo "INHERIT += \\\"own-mirrors\\\"" >> conf/local.conf
                     echo "BB_GENERATE_MIRROR_TARBALLS = \\\"1\\\"" >> conf/local.conf

                     bitbake trustx-cml-initramfs multiconfig:container:trustx-core
                  '''
               }
            }
         }
      }
      stage('Deploy') {
         agent { dockerfile {
            dir 'trustme/build/yocto/docker'
            args '--entrypoint=\'\' -v /tmp:/tmp'
            reuseNode true
         } }
         steps {
            sh '''
               export LC_ALL=en_US.UTF-8
               export LANG=en_US.UTF-8
               export LANGUAGE=en_US.UTF-8
               . init_ws.sh out-yocto
               rm cmld_git.bbappend
               cp cmld_git.bbappend.jenkins cmld_git.bbappend

               bitbake trustx-cml
            '''
         }
      }
      stage('Update_Mirror') {
         agent { dockerfile {
            dir 'trustme/build/yocto/docker'
            args '--entrypoint=\'\' -v /yocto_mirror:/source_mirror'
            reuseNode true
         } }
         steps {
            sh '''
               export LC_ALL=en_US.UTF-8
               export LANG=en_US.UTF-8
               export LANGUAGE=en_US.UTF-8

               if [ ! -d /source_mirror/sources ]; then
                  mkdir /source_mirror/sources
               fi
               for i in out-yocto/downloads/*; do
                  if [ -f $i ] && [ ! -L $i ]; then
                     cp -v $i /source_mirror/sources/
                  fi
               done
            '''
         }
      }*/
   }
   // post {
   //   always {
   //      archiveArtifacts artifacts: 'out-yocto/tmp/deploy/images/**/trustme_image/trustmeimage.img', fingerprint: true
   //   }
   // }
}
