# BoxingGame — アドベンチャー型ボクシング

「Boxing Arena Nebura」風の見た目に、テキストアドベンチャーの実況・シチュエーション描写を融合した、
1対1のターン制ボクシングゲーム企画。

> 目的を一行で言えば、**「ビジュアルは派手に、戦闘の中身はテキストで深く」** をコンセプトにした
> 自分用のボクシングADVを設計・実装する。

## このリポジトリの現在の状態

**Phase 0: 設計書ひな型のみ**
まだ実装はしません。`docs/design/` に設計書のひな型が並んでいます。
最初に読むのは `docs/design/00_設計サマリー.md`。中身はユーザーと議論しながら埋めていきます。

## ローカルで読む

```
python -m pip install -r requirements.txt
python -m mkdocs serve -a 127.0.0.1:8765
```

## 公開（あとで設定）

GitHub Pages で公開する想定。
リポを作って push すれば `.github/workflows/deploy.yml` が走り、
`https://annachloe2025.github.io/BoxingGame/` に出る。

詳細は `CLAUDE.md` と `docs/design/` 配下を参照。
