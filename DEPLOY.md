# 飞牛 Docker 部署指南

## 📋 部署信息
- **设备 IP**: 192.168.2.23
- **SSH 端口**: 22
- **应用端口**: 2019
- **访问地址**: http://192.168.2.23:2019
- **Docker 版本**: 28.5.2+（内置 Compose）

## 🚀 快速部署步骤

### 步骤 1: SSH 连接到飞牛设备
```bash
ssh root@192.168.2.23 -p 22
```

### 步骤 2: 一键部署
```bash
git clone https://github.com/wonderfulgkh/vue-idle-game.git
cd vue-idle-game
bash deploy.sh
```

或者使用 curl 一行命令：
```bash
curl -fsSL https://raw.githubusercontent.com/wonderfulgkh/vue-idle-game/master/deploy.sh | bash
```

### 步骤 3: 验证部署
```bash
# 查看容器状态
docker ps

# 查看日志
docker compose logs -f

# 测试应用
curl http://localhost:2019
```

## 📱 访问应用
部署完成后，在浏览器中打开：
```
http://192.168.2.23:2019
```

## 🛠️ 常用管理命令

### 查看日志
```bash
cd /root/vue-idle-game
docker compose logs -f
```

### 重启应用
```bash
cd /root/vue-idle-game
docker compose restart
```

### 停止应用
```bash
cd /root/vue-idle-game
docker compose down
```

### 更新应用（拉取最新代码）
```bash
cd /root/vue-idle-game
git pull origin master
docker compose up -d --build
```

### 查看容器资源占用
```bash
docker stats vue-idle-game
```

## 📊 容器信息
- **镜像名**: vue-idle-game
- **容器名**: vue-idle-game
- **基础镜像**: node:14-alpine
- **端口映射**: 2019:8080

## 🔧 故障排查

### 容器无法启动
```bash
# 查看错误日志
docker compose logs

# 删除旧容器重新构建
docker compose down
docker compose up -d --build
```

### 占用内存过多
```bash
# 清理未使用的 Docker 资源
docker system prune -a
```

### 重新部署
```bash
cd /root/vue-idle-game
git pull origin master
docker compose down
docker compose up -d --build
```

## 💾 备份和恢复

### 备份项目
```bash
tar -czf vue-idle-game-backup.tar.gz /root/vue-idle-game
```

### 恢复项目
```bash
tar -xzf vue-idle-game-backup.tar.gz -C /root
cd /root/vue-idle-game
docker compose up -d
```

## 📝 更新日志
- 2026-09-15: Docker 部署配置
  - 添加 Dockerfile（多阶段构建）
  - 添加 docker-compose.yml（端口: 2019）
  - 添加部署脚本
  - 优化为使用 Docker 28.5.2+ 内置的 `docker compose` 命令

---

有任何问题？检查日志或运行：
```bash
docker compose logs -f
```
