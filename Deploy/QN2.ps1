# this script is created for the TRC assessment Question No 2
# Given the docker is already configured and installed on the system
# this script stops all the running docker process delets existing coantainers pulls down the TRC website container image from the docker hub run the docker and launches the deployed web in localhost.
# Additinally i have added few catch to handles errors like process not exited properly, container name conflicts

try{
    docker stop $(docker ps -aq)
    docker pull avsek12/trc_assessment:1.0.0 | docker rm $(docker ps -aq) |  docker run --name trcweb -dp 80:80 avsek12/trc_assessment:1.0.0 }
       
        catch{
        Write-Host $_.Exception.Message 
        docker stop -f $(docker ps -aq) | docker rm -f $(docker ps -aq) | docker rmi $(docker images -q)
       
       }
       
      Start-Process http://127.0.0.1:80