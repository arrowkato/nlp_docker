# このリポジトリの説明
- anaconda
- jupyter lab
- mecab

dockerを使える状態で、下記のコマンドを実行すると上記がインストールされたdocker containerが起動します。

```bash
git clone https://github.com/arrowkato/nlp_docker.git 
docker-compse up -d 
```
git clone は2回目以降不要です。


コンテナとホストのディレクトリの連携の詳細は、次節を参照してください。

## .ipnbファイルのホスト側とコンテナ側のディレクトリ側の対応

- host: ./workspace
- container: /opt/workspace

host側の ./workspace 配下にjupyterファイル(.ipnb)を配置して使ってください。  

ブラウザの http://localhost:8888/lab からアクセスするとjupyter labが起動していて、.ipnbを含む各種ファイルの変更ができます。


## mecabの辞書ファイルの永続化
コンテナ側の /opt/mecab_setting 配下のすべてのファイルを永続化することで、
.ipnbファイルとmecabの辞書への変更が保存されるように設定しています。

コンテナ側の /opt/mecab_setting 配下のファイルを再作成したい場合は、
下記のコマンドをホスト側のgit cloneしたディレクトリで実行してください

```bash
docker-compse down
docker volume rm nlp_docker_mecab_dictionary 
docker-compse up -d 
```


