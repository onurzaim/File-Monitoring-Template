# File-Monitoring-Template
You can monitor any file change in any directory

Type these commands in the host that has zabbix agent on it. Please note if you have zabbix-agent or zabbix-agent2 you need to change procedure slightly.

mkdir -p /etc/zabbix/scripts
put fileChangeCheck.sh file in /etc/zabbix/scripts

create /etc/zabbix/zabbix_agentd.d/md5Check.conf file append these UserParameters to file.

UserParameter=md5.check[*],/etc/zabbix/scripts/fileChangeCheck.sh $1 $2
UserParameter=md5.check.value[*],/etc/zabbix/scripts/fileChangeCheck.sh $1 $2 | grep $3 | awk -F '"' '{ print $$8 }'

Then restart agent.
