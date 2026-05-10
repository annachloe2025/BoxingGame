# CLAUDE.md — BoxingGame プロジェクト用メモ

これは **Claude が次回以降このプロジェクトを開いたときに最初に読む** ためのメモ。
このファイルだけで、プロジェクトの目的・構成・運用ルールが把握できることを目指す。

> **2026-05-10 現在のステータス**：Phase 0（設計書ひな型のみ。中身はユーザーと議論しながら埋める）。
> `docs/design/00_設計サマリー.md` から読み始めること。

---

## 1. プロジェクトの目的（一行）

**「Boxing Arena Nebura」風の見た目に、テキストアドベンチャーの実況・シチュエーション描写を融合した、
1対1のターン制ボクシングゲームを作る。**

最終形のターゲット：
- 大きな立ち絵2人 ＋ 上部 HEAD/BODY HPバー ＋ 中央パネルの「コマンド選択」⇄「アクション再生」切替
- 自動再生中はテキストでシチュエーションが進む（実況・台詞・距離感）
- 距離感はテキスト表現中心（「クリンチ」「中距離」「ロープ際」など）

詳細：`docs/design/00_設計サマリー.md`

---

## 2. 基本情報

- フォルダ名 / リポ名: `BoxingGame`（仮）
- サイト表示名: BoxingGame
- 公開URL（あとで有効化）: <https://annachloe2025.github.io/BoxingGame/>
- リポURL（あとで作成）: <https://github.com/annachloe2025/BoxingGame>
- 著者: hoehoe
- 想定エンジン: Unity または Godot（Phase 1 開始時に確定）
- 参考タイトル: Boxing Arena Nebura（あくまで画面構成・操作感の参考）

---

## 3. ディレクトリ構成

```
BoxingGame/
├── CLAUDE.md                     ← このファイル
├── README.md                     ← 人間向け
├── TASKS.md                      ← やることリスト
├── LOG.md                        ← 作業ログ（時系列）
├── mkdocs.yml                    ← MkDocs 設定
├── requirements.txt
├── .gitignore
├── init.bat                      ← 初回 git init + push
├── update.bat                    ← ダブルクリックで commit & push
├── .github/workflows/deploy.yml  ← GitHub Pages 自動デプロイ
├── raw/                          ← 参考画像・素材（gitignore）
├── work/                         ← 中間生成物（gitignore）
└── docs/                         ← MkDocs の docs_dir（公開対象）
    ├── index.md                  ← サイトトップ
    └── design/                   ← ★ 設計書（Phase 0 はここだけ）
        ├── index.md
        ├── 00_設計サマリー.md          ← 最初に読む
        ├── 01_目的とコンセプト.md
        ├── 02_画面とゲームフロー.md
        ├── 03_戦闘システム.md
        ├── 04_キャラクター.md
        ├── 05_テキスト・実況.md
        ├── 06_アセット方針.md
        └── 07_実装ロードマップ.md
```

将来追加されるフォルダ（Phase 1 以降）：

```
BoxingGame/
├── prototype/  ← HTMLでの仕様確認用プロト（lightweight）
├── unity/  または  godot/ ← 本実装
└── art/      ← 画像素材（差し替え運用）
```

---

## 4. 運用ルール

### 4.1. コマンド表記
- Python は **必ず `python -m ...`** 形式で書く
    - `python -m pip install -r requirements.txt`
    - `python -m mkdocs serve -a 127.0.0.1:8765`
    - `python -m mkdocs build --strict`
- ローカルサーバのポートは **8765**

### 4.2. コミュニケーション
- 言語: **日本語**
- 何かを始めるときは AskUserQuestion で方向性を確認
- 過剰な前置きや説明は避ける、要点先行で
- **設計が固まる前に実装を走らせない**（前回の反省）

### 4.3. ファイル書き込み（重要・2026-05-10 更新）

**Edit/Write は実際は壊れていない。bash 側の 9P キャッシュが stale なだけ**。
[anthropic/claude-code #28015](https://github.com/anthropics/claude-code/issues/28015) の症状で、
WSL2 の 9P/drvfs マウント越しに `/mnt/c/...` を読むと、Windows ホスト側で書かれた変更が反映されない。

#### やること
- **Edit/Write が成功を返したら、内容は正しい**。bashで `cat`/`tail`/`wc` を使った末尾チェックはしない（古いキャッシュが見えるだけ）。
- 確認が必要なら **Read ツールを使う**（Edit と同じホスト側の経路）。
- node --check したい場合: Read で取得 → outputs/ 配下に書き出し → そこで `node --check`。

#### やらないこと（今までやってしまっていた地雷）
- ❌ Edit直後に bash で `tail` してファイル末尾切れを疑う（→ 偽警報）
- ❌ heredoc で全文書き直し（→ 不要な巨大書き換えで他のミス誘発）
- ❌ NUL 除去スクリプト（→ そもそも問題が違う）

#### どうしても bash で確認したい場合
- `ls -la <file>` の方が `stat` 系よりキャッシュ更新されやすい
- `touch -a <file>` でアクセス時刻だけ叩くとキャッシュが refreshされる事がある
- 最終手段: WSL 再起動 or `wsl --shutdown`（ユーザー側操作）

### 4.4. 日付フォーマット
- `YYYY-MM-DD`（例: `2026-05-10`）
- frontmatter の `date:` は **必ずダブルクォートで文字列化**（`date: "2026-05-10"`）

---

## 5. よく頼まれる作業のテンプレ（Phase 0 想定）

### 「設計書を読み合わせて〜について議論したい」
1. `docs/design/00_設計サマリー.md` を読む
2. 該当する詳細設計書（01〜07）を読む
3. 議論内容を `LOG.md` に追記
4. 設計の更新が決まったら、対応する設計書を編集 → 設計書末尾の「改訂履歴」を更新

### 「画面のモックを見せて」
1. ひとまず `docs/design/02_画面とゲームフロー.md` を更新（テキストでレイアウト記述）
2. ビジュアルが必要なら HTML モックを `prototype/` に置く（Phase 1 入り口）

### 「実装に入ろう」
1. `docs/design/07_実装ロードマップ.md` の Phase 1 を確認
2. エンジン選定（Unity / Godot）を確定 → CLAUDE.md §2 を更新
3. プロジェクトひな型を `unity/` か `godot/` に作る

---

## 6. ビルド検証

- ローカル: `python -m mkdocs serve -a 127.0.0.1:8765`
- ビルド確認: `python -m mkdocs build --strict`
- nav に追加したのに strict ビルドが落ちる場合はファイルパスの大文字小文字をチェック

## 7. 更新フロー（ユーザー側）

- ルート直下の **`update.bat`** をダブルクリックすると、依存更新 → strict ビルドチェック → commit → push まで自動
- push されると `.github/workflows/deploy.yml` が走り、GitHub Pages に自動反映（1〜2分）
- このプロジェクトでは **`mkdocs gh-deploy` は使わない**（Pages の Source が "GitHub Actions" のため衝突する）

## 8. 既知のハマりどころ

- Material の `tags` プラグインは frontmatter の date 型と相性が悪い。`date:` は必ず文字列で
- Windows の Cowork 経由でファイルを書くと末尾切れすることがある（4.3 参照）
- 参考タイトル（Nebura）のスクショ等は権利の関係で **コミットしない**（`raw/` は gitignore）

---

## 9. 関連プロジェクト

| プロジェクト | 役割 | 関係 |
| --- | --- | --- |
| `VRBoxing` | VR向けボクシングプロジェクト | 体感・モーション設計の参考になり得る |
| `ThinkingLab` | 思考分析ラボ | プロジェクト構造（mkdocs+Pages）の雛型として参照 |

---

## 10. 直近の議論メモ（v0 設計の入口）

ユーザーとの会話で既に決まっていること：

- ジャンル: **アドベンチャー型ボクシングゲーム**（Nebura 参考、テキスト寄り）
- v0 戦闘: **オフェンス1 + ディフェンス1** の同時決定 → **自動再生**
- 表示: 大きな立ち絵2人、上部 HEAD/BODY HPバー、中央パネルがモード切替
- 距離感は **テキスト表現** メインで良い（チビキャラ廃止寄り）
- 画風は未確定（Nebura風の美少女路線 / 少年漫画路線 / 後で決める のいずれか）

これらは `docs/design/00_設計サマリー.md` § 0 と § 6 を参照。
