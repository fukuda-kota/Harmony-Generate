# ベースイメージとしてPython 3.10.7を使用
FROM python:3.10.7-slim

# 作業ディレクトリを作成
WORKDIR /app

# 必要なシステム依存パッケージをインストール
RUN apt-get update && apt-get install -y \
    ffmpeg \
    libsndfile1-dev \
    git \
    g++ \  
    && rm -rf /var/lib/apt/lists/*

# Pythonの依存パッケージをインストール
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# アプリのソースコードをコンテナにコピー
COPY . .

# Streamlitのポートを設定
EXPOSE 8080

# 環境変数としてFFmpegのパスを設定
ENV FFMPEG_PATH=/usr/bin/ffmpeg

# Streamlitアプリを実行するためのコマンド
CMD ["streamlit", "run", "app.py", "--server.port=8080", "$PORT"]

