# real-games-openapi
## Как запушить новую версию API

* Получить локально последнюю версию репозитория real-games-openapi
* Запустить ```./deploy.sh```, дождаться окончания:
```
% ./deploy.sh 
Version: 0-0-11
Waiting for API Config [public-api-config-v0-0-11] to be created for API [public-api]...done.      
```
* При ошибках:
  * Если при попытке выполнении ```./deploy.sh``` возникает ```permission denied: ./deploy.sh``` - выдать права ```chmod +x deploy.sh```
  * Внутри deploy.sh убедиться, что директория верная. Если найти директорию не может - заменить внутри директорию на DIR="."
  * Проверить что grep находит нужную версию (в параметрах стоит -oE, а не -oP - если в скрипте иное - исправить)
  ```
  % grep "version:" ../public-api.yaml | grep -oE "[0-9.]+" | sed "s|\.|-|g"
  0-0-11
  ```
