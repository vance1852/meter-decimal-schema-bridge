# 服务计量库的双精度写入与在线收敛

本项目的本地资料保存各方使用的原始关系、接入操作及外部观察。记录里的人员、机构和凭据均为合成。各资料目录独立使用。

## 原始关系及接入约定

legacy_meter 中 units 是 15 分钟单位，modern_meter 的 seconds 是整数秒。展示给旧端时，非负秒数按最接近的单位取整，正好半单位时向上。两个表的 id 指同一服务事实，rev 记录各次客户基础版本。一条旧写的字典若没有某字段则没有改动该项，JSON null 表示显式撤回，只有 notes 允许为空，时长不能撤回。现行新写的 items 是服务类型及秒数，各项之和支持累加为实际总时长。
`legacy_read` 里的 display_rev 是应用看到的版本。`legacy_write` 包含请求号、事实 ID、读基准和所写字段，可选 duration_intent 为 replace，表示用户明确要求按新的整刻钟值替换。月度编号以事实初始归属为准。closed_totals 记录已经完成的月度发出值。

catalog.json 列出各数据库文件的角色、源表及运行限额。timeline.json 中的 at 是操作或观察到达的顺序，同一时刻按数组内的位置排列。args 是相应动作携带的字段，各记录里的其他位点使用该记录的业务含义。SQL 文件中只有开始联调前的行和表定义。

## 装载资料

Python 3.11.2 自带 SQLite 3.40.1。以下命令从合成资料生成独立数据库，目标文件须尚未存在。可用 sqlite3 打开生成的文件并读取源表。

~~~sh
python3 load_sample.py fixtures/legacy-roundtrip-on-precise-change main-local.db --role main
~~~

执行 python3 -m unittest -v 可核对各份资料的 SQL 是否可装载、基础表行数，以及普通 SQLite 读写连接能否并行打开。
