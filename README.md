# CircleCIデモ用Node.jsサンプルアプリケーション

HonoベースのシンプルなREST APIアプリケーション。AWS ECR → EKS デプロイのデモに使用することを想定しています。

## 機能

- `GET /` - ルートエンドポイント
- `GET /health` - ヘルスチェックエンドポイント
- `GET /version` - バージョン情報エンドポイント

## ローカル開発

### 前提条件

- Node.js 20以上
- npm

### セットアップ

```bash
npm install
```

### 開発サーバーの起動

```bash
npm run dev
```

開発サーバーは `http://localhost:3000` で起動します。

### ビルド

```bash
npm run build
```

ビルドされたファイルは `dist/` ディレクトリに出力されます。

### 本番モードでの起動

```bash
npm run build
npm start
```

## Docker

### イメージのビルド

```bash
docker build -t cci-nodejs-container-app .
```

### コンテナの実行

```bash
docker run -p 3000:3000 cci-nodejs-container-app
```

### ヘルスチェック

```bash
curl http://localhost:3000/health
```

### バージョン確認

```bash
curl http://localhost:3000/version
```

## エンドポイント

### GET /

ルートエンドポイント。シンプルなテキストレスポンスを返します。

**レスポンス例:**
```
Hello Hono!
```

### GET /health

アプリケーションの稼働状態を返します。

**レスポンス例:**
```json
{
  "status": "ok",
  "timestamp": "2024-01-01T00:00:00.000Z"
}
```

### GET /version

アプリケーションのバージョン情報を返します。

**レスポンス例:**
```json
{
  "version": "1.0.0",
  "name": "cci-nodejs-container-app"
}
```

## 技術スタック

- [Hono](https://hono.dev/) - 軽量で高速なWebフレームワーク
- [@hono/node-server](https://github.com/honojs/node-server) - Node.js用アダプター
- TypeScript - 型安全性
- Node.js 20 - ランタイム

## 制約

- ビルド時間: 2分以内
- イメージサイズ: 200MB以下
- 外部DBやAPI依存なし（スタンドアロン動作）
