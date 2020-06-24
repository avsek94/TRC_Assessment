# TRC_Assessment

## WorkFlow Link 
https://app.lucidchart.com/documents/view/61bd0689-f12b-450a-9f36-c85f125aa728/0_0

### Task 1: Using components and/or languages of your choice, create a simple "Hello, World" site. This site should route all incoming requests to a single page which returns "Hello, World”. Create a Dockerfile which copies and/or installs all components and configuration required to run your site as a container

#### Below are the step i performed to complete task.

1. Created a github Project 
2. Create a static webiste with "Hello World for TRC Assement"
3. Cloned the repo to local machine and setup remote dev environement in cloud.
4. Wrote a Dockerfile to build the website with all the configuration required.
5. Created a interagtion between github and Dockerhub.
6. Wrote a git workflow file docker.yml to checkout, build and push the image to "DockerHub"
7. Validated the commit trigger is working by verifying new image is generated to each commit.

### Task 2: Using any scripting language you’re comfortable with, write a script capable of launching your "Hello, World" container and opening that site in a browser with one command. Include any documentation and error handling you feel is appropriate. You can assume your script will be ran on a system with docker installed by a technical person.

#### Assuming we already have docker installed and configured i wrote a powershell script to pull down the image from my docker registry ran it and launched it on default browser on a local host. name of the script, i created for this is QN2.ps1 Below is the snippet for this script. Added few catches which might come up.

```powershell
try{
    docker stop $(docker ps -aq)
    docker pull avsek12/trcweb | docker rm $(docker ps -aq) |  docker run --name trcweb -dp 80:80 avsek12/trcweb }
       
        catch{
        Write-Host $_.Exception.Message 
        docker stop -f $(docker ps -aq) | docker rm -f $(docker ps -aq) | docker rmi $(docker images -q)
       
       }
       
      Start-Process http://127.0.0.1:80
```

### Take your automation to the next level: Assume you have root access on a freshly provisioned Linux server (Ubuntu). This server could be running in a Public Cloud, on prem as a Virtual Machine, or even a bare metal server. This system does not have Docker installed. Write a script (or modify your existing one) to handle the installation of packages required to run your container, pull a container image (or build your Dockerfile), and then launch your container.  Include error handling and documentation as needed.

#### Assuming we dont have any configuration for this task i wrote an ansible playbook which installs all the dependencies for docker engine and deploys the website by pulling down the docker image from the docker hub. below are ansible playbook and inventory files.

1. Name of a inventory file is QN3.yml
2. Inventory file in inventory.
3. defaults are in default.yml

```yml
---
    - hosts: all
      become: true
      vars_files:
        - vars/default.yml
    
      tasks:
        - name: check user
          shell: whoami

        - name: Install aptitude using apt
          apt: name=aptitude state=latest update_cache=yes force_apt_get=yes
    
        - name: Install required system packages
          apt: name={{ item }} state=latest update_cache=yes
          loop: [ 'apt-transport-https', 'ca-certificates', 'curl', 'software-properties-common', 'python3-pip', 'virtualenv', 'python3-setuptools']
    
        - name: Add Docker GPG apt Key
          apt_key:
            url: https://download.docker.com/linux/ubuntu/gpg
            state: present
    
        - name: Add Docker Repository
          apt_repository:
            repo: deb https://download.docker.com/linux/ubuntu bionic stable
            state: present
    
        - name: Update apt and install docker-ce
          apt: update_cache=yes name=docker-ce state=latest
        
        - name: Install pip
          apt:
            name: python-pip
            update_cache: yes
            state: present
    
        - name: Install Docker Module for Python
          pip:
            name: docker
        
        - name: Docker pull 
          shell: docker pull avsek12/trc_assessment:1.0.0
        
        - name: Docker Run 
          shell: docker run --detach --publish 80:80 --name trc-webserver avsek12/trc_assessment:1.0.0
```
Inventory file
```
[webserver]
avsek121c.mylabserver.com

[local]
127.0.0.1

[local:vars]
127.0.0.1   ansible_connection=local

```
Defaults
```yml
---
    create_containers: 1
    default_container_name: trcweb
    default_container_image: avsek12/trcweb
    default_container_command: sleep 1d

```





