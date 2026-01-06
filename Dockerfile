# マルチステージビルド: ビルドステージ
FROM node:20-alpine AS builder

WORKDIR /app

# 依存関係ファイルをコピー
COPY package*.json ./
COPY tsconfig.json ./

# 依存関係をインストール
RUN npm ci

# ソースコードをコピー
COPY src ./src

# TypeScriptをビルド
RUN npm run build

# 本番ステージ
FROM node:20-alpine

WORKDIR /app

# 本番用の依存関係のみインストール（devDependenciesを除外）
COPY package*.json ./
RUN npm ci --only=production && npm cache clean --force

# ビルド済みファイルをコピー
COPY --from=builder /app/dist ./dist

# 非rootユーザーで実行
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001 && \
    chown -R nodejs:nodejs /app
USER nodejs

# ポート3000を公開
EXPOSE 3000

# ヘルスチェック
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD node -e "require('http').get('http://localhost:3000/health', (r) => {process.exit(r.statusCode === 200 ? 0 : 1)})"

# アプリケーション起動
CMD ["node", "dist/index.js"]
