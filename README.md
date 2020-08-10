# このリポジトリの説明
- anaconda
- jupyter lab
- mecab

dockerを使える状態で、下記のコマンドを実行すると上記がインストールされたdocker containerが起動します。

```bash
git clone https://github.com/arrowkato/nlp_docker.git 
docker-compse up -d 
```
→ git clone は2回目以降不要です。

 .ipnbファイルとmecabの辞書への変更は保存されるように設定しています。

詳細は、次節を参照してください。

## .ipnbファイルのホスト側とコンテナ側のディレクトリ側の対応

- host: ./workspace
- container: /opt/workspace

host側の ./workspace 配下にjupyternファイル(.ipnb)を配置して使ってください。  

ブラウザの http://localhost:8888/lab からアクセスするとjupyter labが起動していて、.ipnbを含む各種ファイルの変更ができます。





