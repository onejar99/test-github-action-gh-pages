# test-github-action-gh-pages

可以支援只 trigger 其中一本書
但副作用是不能同時 commit 多本書去，造成要 commit 到 gh-pages 時 history 已經不對
(screwdriver其實也有這種狀況，要手動從最新的 build 去點)

理論上是也可以寫 script 如果失敗就 retry
