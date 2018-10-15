---
title: Command Line
---

## Console Access

You can easily open an interactive Bash console on ECS for the using the provided script. This works
by opening an SSH tunnel through the Bastion host, launching a long running ECS task and executing a shell
on the associated Docker container. After you end your session the script automatically stops the task.

To open an interactive Bash console, simply run:

    $ ./bin/ecs-bash-console.sh production-app

To end the session, simply use the `CTRL+D` keyboard combination. The script will automatically stop the
container using the ECS `stop-task` command. You can use the shell to execute Magento or Wordpress CLI
commands on the remote environment.

**Note:** If an error occurs it is important to keep an eye on running tasks as ECS does not automatically
cleanup and terminate tasks. In this case you should manually stop a task. You can get an overview of
currently running tasks on the AWS ECS console or by using the Admiral tool. If you fail to do this the
ECS cluster may run out of available resources.
