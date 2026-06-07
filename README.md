# Ansible
## 1. Re-running the same playbook again and again consumed lot of time. so i found below commands from the documentation.
```
#ansible-playbook --list-tasks -->This will list the tasks written in your plabook
#ansible-playbook <playbook name> --start-at-task "<task name from the playbook>" --> this will start the playbook from task you mention (Basically from the task that failed and got fixed by you)
```
Roles:
