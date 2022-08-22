# jenkins-automated-demo

This is a small project to have a quick-and-dirty jenkins instance able to run the [ansible-demo](https://github.com/otaviokr/ansible-demo) project.

## How to run it

*This project can be adapted for other projects, but the documentation here is considering only job for the `ansible-demo` project.*

You have everything you need to run, because **THIS IS A DEMO**. Please, don't take any decision in project as a recommendation for a "real-life" project. There are a lot of steps and things to consider that are ignored here, just so anyone can just run the command below and have everything ready to play:

```shell
./run_jenkins.sh <MY_USER> <MY_PASS>
```

where
- **<MY_USER>** needs to be replaced by an username that has access to you computer, and
- **<MY_PASS>** is that username's password

This is required because `ansible-demo` will connect to the host machine to gather facts (and also to demonstrate how to create user/password credentials in Jenkins).

Notice that there is no volume mapping defined. That's because the idea is to be a simple demonstation. If you need a more permanent solution, feel free to map the volumes, but I would suggest to use this repository just as a starting point.

## How to stop it

Once you are finished with Jenkins, you can kill it with the usual `docker-compose down` command.

Keep in mind that the container image is still in the repository. If you want to clear that one out too, `docker rmi jenkins-demo-jenkins` is your friend.

## What you will have

- Custom Jenkis container image with plugins pre-installed
- Jenkins instance at http://localhost:8080
- SMTP dummy server for testing (it will capture outgoing emails from Jenkins)
- MailHog WebGUI at http://localhost:8025
- Ansible installed in the Jenkins container (i.e., Jenkins can run ansible-playbooks)
- User/password credential created automatically
- File secret credential created automatically
- A job that will run the playbook defined at ansible-demo

## Synergy with ansible-demo project

This project goal is to setup and get Jenkins up and running, but the steps in the job is defined in the Jenkinsfile in ansible-demo repository (as would any real project).

That being said, one can adapt this project to run any other project, but you will most likely need to change basically all files in this repository... :-)

## More information

- Official jenkins docker repository: https://github.com/jenkinsci/docker
- Official MailHog (SMTP test server) repository: https://github.com/mailhog/MailHog
- Digital Ocean's Tutorial: https://www.digitalocean.com/community/tutorials/how-to-automate-jenkins-setup-with-docker-and-jenkins-configuration-as-code
