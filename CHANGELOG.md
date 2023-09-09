# Changelog

## By Windea

## [1.0.1](https://github.com/cocolinfff/Ethics-Civics-Infinity-new/compare/v1.0.0...v1.0.1) (2023-04-30)


### Bug Fixes

* test for release ([559a08e](https://github.com/cocolinfff/Ethics-Civics-Infinity-new/commit/559a08e6a507ee08880ad3154253bd1dcd96f11f))
* 修复了数个语法错误[merge from newbie-forever/master] ([f754556](https://github.com/cocolinfff/Ethics-Civics-Infinity-new/commit/f7545563ca77a746d0677dc7d7cb2dc68d65e4d6))

## 1.0.0 (2023-04-29)


### Bug Fixes

* test PR and change for Readme.md ([35436ec](https://github.com/cocolinfff/Ethics-Civics-Infinity-new/commit/35436ec90be01428faeac083a7b5bd9a10cabbbb))

### 2023/1/29

* 整理 预设国家（补充：奥比斯科技协同社、伊菲雷西联合舰队、旋桌骑士高阶领主国，齐里克合作社改为齐里克公社）
* 调整 影子内阁不再要求非任何程度的自由主义
* 修改 直接民主的社会主义政体改为人民公社
* 调整 先进社会主义和革命先锋队的适用条件 - 非任何程度的威权和排外，非道德，先锋队可可以是直接民主/间接民主
* 重构 提取trigger并应用 是否是科学社会主义 `is_scientific_socialism` - 先进社会主义/革命先锋队
* 修复 职业适用条件修复 - 注意士官的职业适用条件参照骑士
* 修复 职业脚本和政策脚本中的语法错误

备注：

* 舍弃对职业的数值修改（否则合并起来太麻烦，以后再看）

### 2023/1/2

* 调整 所有职业的非全国的贸易额产出改为加算
* 调整 职员基础舒适度产出改为1
* 调整 自由主义国家也能使用上山下乡法令
* 调整 统治者职业：数值调整，参照原版文件的调整
* 调整 专家职业：数值调整，执法者生成2防御部队，参照原版文件的调整
* 调整 工人职业：数值调整，参照原版文件进行调整
* 调整 其他职业：数值调整，参照原版文件进行调整
* 调整 特殊职业：数值调整
* 调整 格式塔职业职业：数值调整
* 调整 正在净化的人口产出的研究点数改为1
* 调整 非罪企时罪犯-5贸易额产出，罪犯相关BUG修复
* 重命名 封装变量
* 调整 指令式/分布式计划经济 效果互换
* 修复 职业脚本中判断是否拥有国策时，该国策必须合法
* 修复&调整 革命传统以及游击队职业修改
* 调整 内圣之道改为要求一定程度的排外主义+非任何程度的军国主义
* 修复&调整 战争理由和战争目标精修
* 调整 民族与阶级改为：拥有完整公民权的种族劳工阶级额外产出0.25凝聚力，并额外消耗0.10消费品
* 调整 内圣之道改为思潮要求排外主义即可
* 调整 和谐集体改为一定程度社会主义+一定程度教权主义/自由主义即可

### TODO

待调整：

```
planet_jobs_slave_produces_mult
pop_slave_resource_output
```

脚本缺失：

```
civic_anglers_lithoid
building_guerrilla_stronghold_large
building_rebel_mine
building_rebel_mine_large
building_rebel_food
building_rebel_food_large
building_rebel_arms
building_rebel_arms_large
building_rebel_goods
building_rebel_goods_large
building_rebel_communication_centre
```
