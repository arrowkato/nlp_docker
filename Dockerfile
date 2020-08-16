# AnacondaのDocker image
# https://github.com/ContinuumIO/docker-images/tree/master/anaconda3 
# https://hub.docker.com/r/continuumio/anaconda3/tags
FROM continuumio/anaconda3:2020.07

# パッケージの更新と必要コマンドのインストール
RUN apt-get -y update && \ 
    apt-get -y  install wget nkf build-essential  

# mecabがlibmecab.so.2 を使うのでパスを通す
RUN export PATH=$PATH:/usr/local/lib

# mecabのインストール用directoryに移動
# mecabをダウンロード 2020/08/11時点の最新版 https://taku910.github.io/mecab/#download
RUN mkdir /opt/mecab_setting && \
    cd /opt/mecab_setting && \
    wget "https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7cENtOXlicTFaRUE" -O mecab-0.996.tar.gz  
# インストール
RUN cd /opt/mecab_setting  && \
    tar zxvf mecab-0.996.tar.gz  && \
    cd mecab-0.996  && \
    ./configure  && \
    make && \
    make check && \
    make install

# 共有ライブラリをシステムに認識させる
RUN ldconfig

# ipa辞書のインストール用directoryに移動
# IPA辞書をダウンロード
RUN cd /opt/mecab_setting && \
    wget "https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7MWVlSDBCSXZMTXM" -O /opt/mecab_setting/mecab-ipadic-2.7.0-20070801.tar.gz 

# 辞書インストール前の文字コード書き換え
RUN cd /opt/mecab_setting && \
    tar zxvf mecab-ipadic-2.7.0-20070801.tar.gz && \
    # 文字コードを UTF8に変更
    nkf --overwrite -w mecab-ipadic-2.7.0-20070801/* && \
    # dicrcファイルでの文字コード指定の変更
    sed -i  -e "s/EUC-JP/UTF-8/" mecab-ipadic-2.7.0-20070801/dicrc 

RUN cd /opt/mecab_setting/mecab-ipadic-2.7.0-20070801 && \
    ./configure && \
    # 文字コードの書き換え
    # before: $(mecab_dict_index) -d . -o . -f EUC-JP -t euc-jp
    # after : $(mecab_dict_index) -d . -o . -f utf8 -t utf8 
    sed -i -e "s/EUC-JP/utf8/" Makefile  && \
    sed -i -e "s/euc-jp/utf8/" Makefile  && \
    make && \
    make check && \
    make install


# インストールに使用したファイルの削除
RUN rm /opt/mecab_setting/mecab-0.996.tar.gz && \
    rm /opt/mecab_setting/mecab-ipadic-2.7.0-20070801.tar.gz

# working directoryの作成
WORKDIR /opt/workspace
# jupyter labのポートを公開
EXPOSE 8888

# jupyter lab起動
ENTRYPOINT ["jupyter-lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
CMD ["--notebook-dir=/opt/workspace"]


