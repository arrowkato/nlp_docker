# AnacondaのDocker image
# https://github.com/ContinuumIO/docker-images/tree/master/anaconda3 
# https://hub.docker.com/r/continuumio/anaconda3/tags
FROM continuumio/anaconda3:2020.07

# パッケージの更新と必要コマンドのインストール
RUN apt-get -y update && apt-get -y  install wget nkf

#TODO: mecabを入れる

# working directoryの作成
WORKDIR /opt/workspace
# jupyter labのポートを公開
EXPOSE 8888

# jupyter lab起動
ENTRYPOINT ["jupyter-lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
CMD ["--notebook-dir=/opt/workspace"]


