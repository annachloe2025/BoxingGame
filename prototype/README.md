# prototype/ — 戦闘プロトタイプ

設計書（`docs/design/`）の戦闘ロジックを **ブラウザで動かして確認する** ための仮実装。

## 起動方法

`battle.html` を **ダブルクリック** するだけ。`resources/chara/` と `resources/background/` を相対パスで参照しているので、フォルダ構造を変えなければそのまま動く。

```
BoxingGame/
├── prototype/
│   └── battle.html       ← これを開く
└── resources/
    ├── chara/            ← 立ち絵10名
    └── background/       ← リング背景
```

## できること

- 10キャラから2人選んで EXHIBITION バトル
- HEAD/BODY HP、スタミナ、KDカウント、距離、リングポジションを可視化
- オフェンス8種（ジャブ・ストレート・フック・アッパー × HEAD/BODY）
- ディフェンス5種（ガード上/下、ダッキング、スウェー、カウンター）
- 1ターン = 互いに攻撃、相手のディフェンスで受ける
- ダウン演出 + 10カウント + 立ち上がり判定
- 3ノックダウンTKO / カウントアウトKO
- 3ラウンド制 → 最終判定（HP残量勝ち）

## 数値は仮

`battle.html` 内の `CHARACTERS / TECHS / DEFS / DIST_MOD / EVADE_RATE / COUNTER_RATE` を直接編集してバランス調整できる。設計書に記載した範囲で自由に試してOK。

## やってないこと

- スキル（パッシブ）の効果実装
- 必殺フロー
- 立ち絵のポーズ差分（neutral 1枚だけ）
- カットイン演出（中央パネルはテキストのみ）
- 効果音 / BGM
- セーブ / 戦績
