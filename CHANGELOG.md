# Changelog

## By Windea

### 2023/1/29

* 整理 预设国家（补充：奥比斯科技协同社、伊菲雷西联合舰队、旋桌骑士高阶领主国，齐里克合作社改为齐里克公社）
* 调整 影子内阁不再要求非任何程度的自由主义
* 修改 直接民主的社会主义政体改为人民公社
* 调整 先进社会主义和革命先锋队的适用条件 - 非任何程度的威权和排外，非道德，先锋队可可以是直接民主/间接民主
* 重构 提取trigger并应用 是否是科学社会主义 `is_scientific_socialism` - 先进社会主义/革命先锋队

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
* 调整 内圣之道改为要求一定程度的种族主义+非任何程度的军国主义
* 修复&调整 战争理由和战争目标精修
* 调整 民族与阶级改为：拥有完整公民权的种族劳工阶级额外产出0.25凝聚力，并额外消耗0.10消费品
* 调整 内圣之道改为思潮要求种族主义即可
* 调整 和谐集体改为一定程度社会主义+一定程度教权主义/自由主义即可

待调整：

```
planet_modifier/planet_jobs_slave_produces_mult
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