#!/bin/bash

# 飞牛 Docker 部署脚本（简化版）
# 使用方法: bash deploy-simple.sh

set -e

REPO_URL="https://github.com/wonderfulgkh/vue-idle-game"
PROJECT_DIR="/root/vue-idle-game"
PORT="2019"

echo "=========================================="
echo "Vue Idle Game Docker 部署脚本"
echo "=========================================="
echo ""

# 克隆或更新项目
if [ -d "$PROJECT_DIR" ]; then
    cd "$PROJECT_DIR"
    echo "📥 更新项目..."
    git pull origin master
else
    echo "📥 克隆项目..."
    git clone "$REPO_URL" "$PROJECT_DIR"
    cd "$PROJECT_DIR"
fi

# 停止旧容器
echo "🔨 停止旧容器..."
docker compose down || true

# 构建和启动
echo "🏗️  构建镜像..."
docker compose build --no-cache

echo "🚀 启动容器..."
docker compose up -d

echo ""
echo "✅ 完成！访问: http://192.168.2.23:$PORT"
