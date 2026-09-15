#!/bin/bash

# 飞牛 Docker 部署脚本
# 使用方法: bash deploy.sh

echo "========================================="
echo "Vue Idle Game Docker 部署脚本"
echo "========================================="

# 配置变量
REPO_URL="https://github.com/wonderfulgkh/vue-idle-game"
PROJECT_DIR="/root/vue-idle-game"
CONTAINER_NAME="vue-idle-game"
PORT="2019"

echo ""
echo "📦 步骤 1: 检查 Docker..."
docker --version
if [ $? -ne 0 ]; then
    echo "❌ Docker 未安装，请先安装 Docker"
    exit 1
fi

echo ""
echo "📥 步骤 1.5: 检查并安装 Docker Compose..."
DOCKER_COMPOSE_PATH="/usr/local/bin/docker-compose"

if [ ! -f "$DOCKER_COMPOSE_PATH" ]; then
    echo "Docker Compose 未安装，正在下载最新版本..."
    COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep -oP '"tag_name": "\K[^"]*' | head -1)
    if [ -z "$COMPOSE_VERSION" ]; then
        COMPOSE_VERSION="v2.24.0"
    fi
    echo "下载版本: $COMPOSE_VERSION"
    
    SYSTEM=$(uname -s)
    MACHINE=$(uname -m)
    DOWNLOAD_URL="https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-${SYSTEM}-${MACHINE}"
    
    echo "下载地址: $DOWNLOAD_URL"
    curl -L "$DOWNLOAD_URL" -o "$DOCKER_COMPOSE_PATH" 2>&1
    
    if [ -f "$DOCKER_COMPOSE_PATH" ]; then
        chmod +x "$DOCKER_COMPOSE_PATH"
        echo "✅ Docker Compose 安装完成"
    else
        echo "❌ Docker Compose 下载失败"
        exit 1
    fi
else
    echo "✅ Docker Compose 已安装"
fi

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
docker-compose down 2>&1 || echo "没有旧容器"

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
