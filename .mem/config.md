---
# ── 档位区（agent 不可经文件工具改写；档位只经 whale_set_profile 或快捷条） ──
style_tier: t3
rigor_tier: l3
auto_adjust: true
mem_enabled: true
polish_enabled: true
plugin_enabled: true
schema: 1
# ── 拆分文件索引（自动维护） ──
indexes: {}
---

## 人工锁定区（agent 只读；守卫硬保护）

## 术语表（自动维护，超过 30 条拆出至 glossary.md）

| 术语 | 统一写法 | 禁用写法 | 来源 | 置信度 |
|---|---|---|---|---|
| 整文件覆盖 | 同名同路径文件整文件替换本体 | 把覆盖当成合并 | 4.6 适配报告 §四；本次实测 38 处 | 高 |
| 同 ID 重定义 | 后加载的同名对象块覆盖本体定义 | 把新文件里的重定义当成新增 | 4.6 适配报告 §三；本次实测 2892 处 | 高 |
| 绝对伦理 | `ethic_absolute_*`，8 档，category_value 0/1/2 与 4/5/6 | `ethic_extreme_*`、任意自造档名 | 本体 `common/ethics/00_ethics.txt`；本次实测 | 高 |
| 迭代效果旧名 | `every_owned_species`、`every_system_within_border` | `every_owned_pop_species`、`every_owned_sector`、`every_system_colony` | 4.6 崩溃排查指南；本体 4.6 零命中 | 高 |
| 总督技能静态修正 | `skill_<class>_colony_governor` | `skill_<class>_planet_governor` | 改动大全 §10；本体 `00_static_modifiers.txt` | 高 |
| 巨企 DLC 判定 | `has_megacorp_dlc` / `has_not_megacorp_dlc` | `has_megacorp` / `has_not_megacorp` | 改动大全 §10；本体 4.6 旧键零命中 | 高 |
| 派系内联路径 | `pop_faction_types/demands/outraged` 等 | `pop_faction_types/demand_faction_outraged`、`paragon/global_faction_demands` | 改动大全 §10；本体 4.6 目录结构 | 高 |
| 战争进入钩子 | `on_war_entered`（THIS 国家 / FROM 对方战争领袖） | `on_entering_war` | 改动小结 §9.3；本体 4.6 `00_on_actions.txt` 无旧键 | 高 |
| 目标化变量名 | `变量名@目标`（4.6 新语法） | 当作未定义的 `@脚本变量` 报错 | 改动小结 §7.1；本 mod 实测在用 | 中 |
| 需求列表语义 | 块内裸 `value` 并列即 AND | 把裸 `value` 与 `OR` 当「或」 | 适配报告 §三.7 | 高 |
| 绝对伦理档写法 | civic `possible.ethics` 的 `OR`/`NOR` 组里，`value` 一并列入对应轴的 `ethic_absolute_*` | 只列 regular/fanatic 两档、给绝对档另造 tooltip 键 | 用户设定 2026-11-25；`~/.dsh/AGENTS.md`「4.6 绝对伦理档」一节 | 高 |
| 英文本地化值内引号 | `\"`（ASCII 正反双引号与弯引号 `“”` 统一转义） | 值内裸 `"`、`“`、`”` | 用户设定 2026-11-28；原版 `extreme_frontiers_l_english.yml` 同写法；本地 `传奇领袖文本覆盖_l_english.yml` 改造 10 行 | 高 |
| 本地化引号规范（全量） | 英文文件值内 `"`/`“`/`”`/`「」` 一律写 `\"`；中英文 `「」` 一律改常规双引号 `“”` | 英文值内裸引号；任意语言保留 `「」` | 用户设定 2026-11-28；`~/.dsh/AGENTS.md`「本地化文本的引号规范」；本次两个 `传奇领袖文本覆盖_l_*.yml` 各改 12 行 | 高 |
| 本地化换行写法 | `\n`（单反斜杠 + n） | `\\n`（双反斜杠 + n） | 用户设定 2026-11-28；全 `localisation/` 目录原本仅两个 `传奇领袖文本覆盖_l_*.yml` 含 106 处 `\\n`，本次各清零 | 高 |

## 上下文资产（自动维护）

- 版本基线：Corona Borealis v4.6.0 (3d1a)，游戏目录 `E:\GAME\steamapps\common\Stellaris`。
- 学习文档：`E:\华章\QQ数据\310501564\FileRecv\群星4.6 Modding改动大全.md`、`群星 4.6 Modding 改动小结.md`（修订版，证据分级更细）、`4.6适配报告.md`（方法可迁移）。
- 4.6 修复前整份备份：`E:\Documents\Paradox Interactive\Stellaris\mod_backup_eci_46_20261125`（在 mod 目录之外，不会被启动器加载）。
- 审计中间产物：`C:\Users\31050\AppData\Local\Temp\eci_audit\`（overrides.json / redefinitions.json / field_gaps.json / final_verify.py）。
- 2026-11-25 完成一轮 4.6 适配：48 个文件改动，语法审计 0 error。
- 游戏运行日志目录：`E:\Documents\Paradox Interactive\Stellaris\logs`（用户 2026-11-27 授权：需要时可直接读取，用于查 error.log 等运行期报错）。
- 2026-11-28 新增两个群友定制典范领袖（AM-001 / 苏）及其获取链：`events/msi_dsai_am001_events.txt`、`events/msi_dsai_su_events.txt`、`common/anomalies/msi_dsai_paragon_anomalies.txt`、`common/archaeological_site_types/msi_dsai_paragon_sites.txt`、`common/scripted_effects/msi_dsai_paragon_effects.txt`、`common/scripted_triggers/msi_dsai_paragon_triggers.txt`、`common/traits/msi_dsai_paragon_traits.txt`、`common/on_actions/msi_dsai_paragon_on_actions.txt`、`localisation/simp_chinese|english/msi_dsai_paragon_l_*.yml`。两处入口与最终获取点均检查 `has_global_flag = eci_special_leader_yes`；立绘走 `portrait = random`（ROBOT / HUM 池），不新建肖像资源。
- 2026-11-28 上述领袖文本按用户要求并入 `localisation/simp_chinese/replace/传奇领袖文本覆盖_l_simp_chinese.yml`（402 行）与 `localisation/english/replace/传奇领袖文本覆盖_l_english.yml`（403 行）：末尾追加 66 个 key + 分节注释，原有内容未改，仅将原末行补了一个换行符（原文件末尾无换行）；独立文件 `localisation/simp_chinese|english/msi_dsai_paragon_l_*.yml` 已删除。
- 2026-11-28 对两个领袖文本做去 AI 味重写（各 31 个 key）：AM-001 台词改为碎句 + 口头毛刺（压了两天、交班时提、第四次没再拔电源），科普段缩短加跑题；苏的事件叙述删掉总结式从句（"也就是说"），改用具体动作与沉默；选项文案口语化（"让它查下去""往前走""还有别的事吗"）。校验：0 格式错误、`\\n` 0 处、`\"` 79 处、行数 402/403 不变。
- 2026-11-28 调整两个获取链的时机与落点：AM-001 改为开局 10~30 年随机（`days = 3600 random = 7200`）出现，入口 `msi_dsai_am001.1` 只做调度，新增 `msi_dsai_am001.4` 执行放置；苏的遗址改为开局 20 年（`days = 7200`）后在玩家境内随机一颗荒芜行星（`pc_barren` / `pc_barren_cold`）创建，`msi_dsai_su_spawn_digsite_effect` 改用 `random_planet_within_border`，境内暂无荒芜行星时每 5 年重试；`msi_dsai_su.2.desc` 中英文本同步改为"境内"。
