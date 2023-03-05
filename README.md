# Домашнее задание к занятию 5. «Elasticsearch»

## Задача 1

В этом задании вы потренируетесь в:

- установке Elasticsearch,
- первоначальном конфигурировании Elasticsearch,
- запуске Elasticsearch в Docker.

Используя Docker-образ [centos:7](https://hub.docker.com/_/centos) как базовый и 
[документацию по установке и запуску Elastcisearch](https://www.elastic.co/guide/en/elasticsearch/reference/current/targz.html):

- составьте Dockerfile-манифест для Elasticsearch,
- соберите Docker-образ и сделайте `push` в ваш docker.io-репозиторий,
- запустите контейнер из получившегося образа и выполните запрос пути `/` c хост-машины.

Требования к `elasticsearch.yml`:

- данные `path` должны сохраняться в `/var/lib`,
- имя ноды должно быть `netology_test`.

В ответе приведите:

- текст Dockerfile-манифеста,
- ссылку на образ в репозитории dockerhub,
- ответ `Elasticsearch` на запрос пути `/` в json-виде.

Подсказки:

- возможно, вам понадобится установка пакета perl-Digest-SHA для корректной работы пакета shasum,
- при сетевых проблемах внимательно изучите кластерные и сетевые настройки в elasticsearch.yml,
- при некоторых проблемах вам поможет Docker-директива ulimit,
- Elasticsearch в логах обычно описывает проблему и пути её решения.

Далее мы будем работать с этим экземпляром Elasticsearch.

### Ответ: 

FROM centos:centos7  

RUN yum -y install sudo wget perl-Digest-SHA && \  
    groupadd --gid 1000 elasticsearch && \  
    adduser --uid 1000 --gid 1000 --home /usr/share/elasticsearch elasticsearch && \  
    mkdir /var/lib/elasticsearch/ && \  
    chown -R  1000:1000 /var/lib/elasticsearch/  
  
USER 1000:1000  

WORKDIR /usr/share/elasticsearch  
  
RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.6.2-linux-x86_64.tar.gz && \  
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.6.2-linux-x86_64.tar.gz.sha512 && \  
        shasum -a 512 -c elasticsearch-8.6.2-linux-x86_64.tar.gz.sha512 && \  
        tar -xzf elasticsearch-8.6.2-linux-x86_64.tar.gz && \  
        cd elasticsearch-8.6.2/   
  
RUN echo 'cluster.name: korobkov' >> elasticsearch-8.6.2/config/elasticsearch.yml && \  
    echo "node.name: netology_test" >> elasticsearch-8.6.2/config/elasticsearch.yml && \  
    echo "network.host: 0.0.0.0" >> elasticsearch-8.6.2/config/elasticsearch.yml && \  
    echo "discovery.type: single-node" >> elasticsearch-8.6.2/config/elasticsearch.yml  
  
EXPOSE 9200  
  
CMD ["elasticsearch-8.6.2/bin/elasticsearch"]  

https://hub.docker.com/repository/docker/ivanskorobkov/korobkov/general  

ivan@ubuntu:~/elastic$ sudo curl -u elastic https://localhost:9200 -k  
[sudo] пароль для ivan:   
Enter host password for user 'elastic':  
{  
  "name" : "netology_test",  
  "cluster_name" : "korobkov",  
  "cluster_uuid" : "BkOFC3WhTyiXPf14qiGD7g",  
  "version" : {  
    "number" : "8.6.2",  
    "build_flavor" : "default",  
    "build_type" : "tar",  
    "build_hash" : "2d58d0f136141f03239816a4e360a8d17b6d8f29",  
    "build_date" : "2023-02-13T09:35:20.314882762Z",  
    "build_snapshot" : false,  
    "lucene_version" : "9.4.2",  
    "minimum_wire_compatibility_version" : "7.17.0",  
    "minimum_index_compatibility_version" : "7.0.0"  
  },  
  "tagline" : "You Know, for Search"  
}  

## Задача 2

В этом задании вы научитесь:

- создавать и удалять индексы,
- изучать состояние кластера,
- обосновывать причину деградации доступности данных.

Ознакомьтесь с [документацией](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-create-index.html) 
и добавьте в `Elasticsearch` 3 индекса в соответствии с таблицей:

| Имя | Количество реплик | Количество шард |
|-----|-------------------|-----------------|
| ind-1| 0 | 1 |
| ind-2 | 1 | 2 |
| ind-3 | 2 | 4 |

Получите список индексов и их статусов, используя API, и **приведите в ответе** на задание.

Получите состояние кластера `Elasticsearch`, используя API.

Как вы думаете, почему часть индексов и кластер находятся в состоянии yellow?

Удалите все индексы.

**Важно**

При проектировании кластера Elasticsearch нужно корректно рассчитывать количество реплик и шард,
иначе возможна потеря данных индексов, вплоть до полной, при деградации системы.

### Ответ:

![Image alt](https://github.com/IvanSKorobkov/homework/blob/main/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%20%D0%BE%D1%82%202023-03-05%2004-33-11.png)

![Image alt](https://github.com/IvanSKorobkov/homework/blob/main/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%20%D0%BE%D1%82%202023-03-05%2004-39-07.png)

Статус 'yellow' связан с тем, что мы указали некоторое количество реплик (1,2), но по факту реплик нету, из-за этого мы видим unassigned_shards. В таких случаях существует вероятность  
потерять данные, о чем нас и предупреждает ES статусом 'yellow'.  

![Image alt](https://github.com/IvanSKorobkov/homework/blob/main/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%20%D0%BE%D1%82%202023-03-05%2004-42-14.png)

## Задача 3

В этом задании вы научитесь:

- создавать бэкапы данных,
- восстанавливать индексы из бэкапов.

Создайте директорию `{путь до корневой директории с Elasticsearch в образе}/snapshots`.

Используя API, [зарегистрируйте](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-register-repository.html#snapshots-register-repository) 
эту директорию как `snapshot repository` c именем `netology_backup`.

**Приведите в ответе** запрос API и результат вызова API для создания репозитория.

Создайте индекс `test` с 0 реплик и 1 шардом и **приведите в ответе** список индексов.

[Создайте `snapshot`](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html) 
состояния кластера `Elasticsearch`.

**Приведите в ответе** список файлов в директории со `snapshot`.

Удалите индекс `test` и создайте индекс `test-2`. **Приведите в ответе** список индексов.

[Восстановите](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html) состояние
кластера `Elasticsearch` из `snapshot`, созданного ранее. 

**Приведите в ответе** запрос к API восстановления и итоговый список индексов.

Подсказки:

- возможно, вам понадобится доработать `elasticsearch.yml` в части директивы `path.repo` и перезапустить `Elasticsearch`.

### Ответ:
