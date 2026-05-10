# resources/

ローカル専用の素材置き場。**git にはコミットされない**（`.gitignore` 済み）。

## 構成

```
resources/
├── background/    # 背景画像（boxing_ring_battle_bg.png 等）
├── chara/         # 10名のキャラ立ち絵 + 設定JSON
│   └── standing/  # ポーズ別（guard/hit/down）の追加分の置き場
└── samples/       # 参考スクリーンショット（権利物 + 自作UI参考）
```

## 注意

- ここの中身は **公開リポには含めない**
- 同期したい場合は別途 OneDrive / Google Drive などで管理
- ゲーム本体（Unity/Godot）からは相対パスで参照する想定（後で要相談）

## 命名規則

`docs/design/06_アセット方針.md` を参照。
