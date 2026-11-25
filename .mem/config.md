---
# ── 档位区（agent 不可经文件工具改写；档位只经 whale_set_profile 或快捷条） ──
style_tier: t1
rigor_tier: l1
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

## 上下文资产（自动维护）

- 版本基线：Corona Borealis v4.6.0 (3d1a)，游戏目录 `E:\GAME\steamapps\common\Stellaris`。
- 学习文档：`E:\华章\QQ数据\310501564\FileRecv\群星4.6 Modding改动大全.md`、`群星 4.6 Modding 改动小结.md`（修订版，证据分级更细）、`4.6适配报告.md`（方法可迁移）。
- 4.6 修复前整份备份：`E:\Documents\Paradox Interactive\Stellaris\mod_backup_eci_46_20261125`（在 mod 目录之外，不会被启动器加载）。
- 审计中间产物：`C:\Users\31050\AppData\Local\Temp\eci_audit\`（overrides.json / redefinitions.json / field_gaps.json / final_verify.py）。
- 2026-11-25 完成一轮 4.6 适配：48 个文件改动，语法审计 0 error。
