Docker Registry

для первоначального запуска виртуалки с реестром

после настройки виртуалки, установки докера и т.п. 

- для продакшн:

запускаем HOST=username@host_ip PORT=ssh_port_number HTPASSWD_FILE=htpasswd make deploy

- для локальной разработки:

1) запускаем с помомщью команды make init
2) логин: registry, пароль: password
