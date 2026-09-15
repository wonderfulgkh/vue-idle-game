#!/bin/bash

# 飞牛 Docker 部署脚本
# 使用方法: bash deploy.sh

set -e

echo "========================================="
echo "Vue Idle Game Docker 部署脚本"
echo "========================================="

# 配置变量
REPO_URL="https://github.com/wonderfulgkh/vue-idle-game"
PROJECT_DIR="/root/vue-idle-game"
CONTAINER_NAME="vue-idle-game"
PORT="8080"

echo ""
echo "📦 步骤 1: 检查 Docker 和 Docker Compose..."
docker --version
docker-compose --version

echo ""
echo "📥 步骤 2: 克隆或更新项目..."
if [ -d "$PROJECT_DIR" ]; then
    echo "项目目录已存在，更新中..."
    cd "$PROJECT_DIR"
    git pull origin master
else
    echo "克隆项目..."
    git clone "$REPO_URL" "$PROJECT_DIR"
    cd "$PROJECT_DIR"
fi

echo ""
echo "🔨 步骤 3: 停止旧容器（如果存在）..."
docker-compose down || true

echo ""
echo "🏗️  步骤 4: 构建 Docker 镜像..."
docker-compose build --no-cache

echo ""
echo "🚀 步骤 5: 启动容器..."
docker-compose up -d

echo ""
echo "✅ 部署完成！"
echo "========================================="
echo "访问地址: http://192.168.2.23:$PORT"
echo "容器名称: $CONTAINER_NAME"
echo "========================================="
echo ""
echo "常用命令:"
echo "  查看日志:     docker-compose logs -f"
echo "  停止服务:     docker-compose down"
echo "  重启服务:     docker-compose restart"
echo "  查看容器:     docker ps"
echo ""
