# Scala Sbt Project Initialization - Automation 

**Why?**
To initialize the sbt scala project from command line with ease.

**Steps:**
1. Creates project directory.
1. Initializes git repository.
1. Creates sbt folder structure.
1. Creates .gitignore file for the project.
1. Creates build.sbt file.
1. Creates build.properties file.

**Project Structure - sbt**
- project_root_directory
    - configs
    - scripts
    - jenkins 
    - project
        - build.properties
    - build.sbt
    - src
        - main
            - resources
            - java
            - scala
        - test 
            - resources
            - java
            - scala


**Script Invocation**
```bash
$ git clone https://github.com/suriyakrishna/project_build_automation.git /home/hadoop/project_build_automation
$ cd /home/hadoop/project_build_automation/scripts
$ bash generate_sbt_project.sh -s 2.11.11 -o com.kishan -a pocsbt -v 0.1.1 -b 1.3.4 -p /home/hadoop/sparkScalaTest
```


