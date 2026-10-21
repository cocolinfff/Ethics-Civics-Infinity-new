$ErrorActionPreference = 'Stop'
$mod    = "E:\Documents\Paradox Interactive\Stellaris\mod\Ethics and Civics Infinity"
$MAX    = 20
$roman  = @('I','II','III','IV','V','VI','VII','VIII','IX','X','XI','XII','XIII','XIV','XV','XVI','XVII','XVIII','XIX','XX')

function Get-DescZh([int]$lv, [string]$which) {
    if ($which -eq 'dem') {
        switch ($lv) {
            1  { return '两座太空电梯之一。前太空时代那两个国家谁也不肯认输，这段执念成了它最初的地基。' }
            2  { return '民主思想塔又高了一层。更多舱段被接上塔身，通勤者与货物沿着它昼夜穿行。' }
            3  { return '塔身已经越过了城市的天际线，从远处望去像一根插进云里的针。' }
            4  { return '暮色里，塔顶的灯是整片大陆最先亮起的光。' }
            5  { return '塔身开始穿过云层，天气在它脚下载沉载浮。' }
            6  { return '塔身已经穿透了大部分大气层，站在顶端能望见星球的弧度。' }
            7  { return '风在高处变得稀薄，维护队伍需要穿加压服才能作业。' }
            8  { return '越往上，天空从蓝变深，最后变成一片没有星星的黑。' }
            9  { return '第一段近地轨道接驳舱投入使用，运输不再需要火箭。' }
            10 { return '它在轨道与地面之间拉出一条稳定的线，运费跌到了历史低点。' }
            11 { return '近地轨道上已经能清晰望见它的塔尖。它不再只是一座建筑，而是一种宣告。' }
            12 { return '塔身外壁挂着成排的舱段，像一棵长到天上的树。' }
            13 { return '地面的钟楼已经看不到它的顶端，只能靠信号灯确认它还在。' }
            14 { return '它比星球上任何一座山峰都高，而且还在继续长。' }
            15 { return '从这个高度俯瞰，整片大陆都缩成了地图上的一个色块。' }
            16 { return '它的塔尖已经触到了同步轨道的锚点。' }
            17 { return '轨道站开始以它为轴心布置，整条轨道都被它带得动起来了。' }
            18 { return '人们开始在塔身中段定居，那里成了一个没有地平线的城市。' }
            19 { return '它快要够到理论极限了，工程师们开始担心下一层到底还撑不撑得住。' }
            20 { return '它抵达了太空电梯的理论极限高度。从地面到轨道，这条通道彻底改变了这颗星球的命运。' }
        }
    } else {
        switch ($lv) {
            1  { return '与民主思想塔遥遥相对的另一座太空电梯。两国当年谁也不肯让步，于是各自盖了一座。' }
            2  { return '自由火炬塔加高了。它的外壁挂满了灯火，夜里从半个星球上都能看见。' }
            3  { return '塔身越往上越细，像一支举向天空的火把。' }
            4  { return '塔上的货舱开始昼夜不停地运转，港口在它脚下长了出来。' }
            5  { return '第一批轨道货物从这里上去，又从这里下来，全程没有点火。' }
            6  { return '塔身穿过云层之上，天气在它脚下翻滚。' }
            7  { return '商队开始在塔基排队，等待档期上塔。' }
            8  { return '它运出去的东西比运进来的多，账面上第一次出现了顺差。' }
            9  { return '高处的风声消失了，只剩下结构在缓慢地嗡鸣。' }
            10 { return '它成了这颗星球上最忙的一条路。' }
            11 { return '从轨道上看，它与民主思想塔像两根并立的针，扎在同一片大陆上。' }
            12 { return '塔身的灯火连成一条线，夜里像一道竖起来的地平线。' }
            13 { return '货物吞吐量已经压过了地面所有的港口加起来。' }
            14 { return '它在塔顶开了第二个接驳口，为了不排队，也为了不被比下去。' }
            15 { return '站在轨道站往下看，那两座塔之间只隔着一小段黑暗。' }
            16 { return '它开始把轨道上的东西运下来，规模比运上去时还要大。' }
            17 { return '塔身的货运轨道换成了第二套，旧的那套已经磨得发亮。' }
            18 { return '它不再只是交通设施，而是整颗星球经济的一条主动脉。' }
            19 { return '它快要够到理论极限了，塔基的维护队伍开始三班倒地轮值。' }
            20 { return '它终于也抵达了极限高度。两座塔在穹顶之上相对而立，谁也没有真正赢过谁。' }
        }
    }
    return ''
}

function Get-DescEn([int]$lv, [string]$which) {
    if ($which -eq 'dem') {
        switch ($lv) {
            1  { return 'One of the two space elevators. Neither pre-FTL nation would yield, and that stubbornness became its first foundation.' }
            2  { return 'The Tower of Democratic Thought has risen another level. More segments are grafted onto its spine, carrying commuters and cargo around the clock.' }
            3  { return 'The structure has cleared the city skyline; from a distance it is a needle driven into the clouds.' }
            4  { return 'At dusk, the lamp at its crown is the first light to come on across the continent.' }
            5  { return 'The tower now pushes through the cloud deck, with weather churning below it.' }
            6  { return 'It has punched through most of the atmosphere; from its summit the curvature of the planet is visible.' }
            7  { return 'The air up here is thin enough that maintenance crews work in pressure suits.' }
            8  { return 'The higher you climb, the deeper the sky turns, until it is a starless black.' }
            9  { return 'The first low-orbit transfer dock opens; cargo no longer needs a rocket.' }
            10 { return 'It has stretched a stable line between orbit and ground, and freight costs have collapsed.' }
            11 { return 'Its tip is plainly visible from low orbit. It is no longer merely a building, but a declaration.' }
            12 { return 'Rows of modules hang along its flanks, like a tree grown into the sky.' }
            13 { return 'From the ground the top is invisible; only the signal beacons confirm it is still there.' }
            14 { return 'It stands taller than any mountain on the planet, and it is still growing.' }
            15 { return 'From this height the entire landmass shrinks to a patch of colour on a map.' }
            16 { return 'Its crown has finally reached the anchor at synchronous orbit.' }
            17 { return 'Orbital stations begin to arrange themselves around it; the whole ring is being pulled into motion.' }
            18 { return 'People start settling in its middle sections, in a city with no horizon.' }
            19 { return 'It is nearly at the theoretical limit, and engineers worry whether the next level will hold.' }
            20 { return 'It has reached the theoretical limit for a space elevator. From ground to orbit, this corridor has transformed the fate of the planet.' }
        }
    } else {
        switch ($lv) {
            1  { return 'The other space elevator, facing the Tower of Democratic Thought across the continent. Neither nation would yield, so each built one of its own.' }
            2  { return 'The Tower of the Liberty Torch has grown taller. Its flanks are strung with lamps, visible from half the planet at night.' }
            3  { return 'The shaft narrows as it climbs, like a torch held up to the sky.' }
            4  { return 'Cargo pods begin running day and night, and a port grows up at its base.' }
            5  { return 'The first orbital freight goes up this way, and comes back down the same way, without a single ignition.' }
            6  { return 'The tower now pierces the cloud deck, weather churning far below it.' }
            7  { return 'Caravans begin queuing at the base, waiting for a slot on the lift.' }
            8  { return 'It ships out more than it takes in; the books show a surplus for the first time.' }
            9  { return 'The wind up here is gone, leaving only the slow hum of the structure.' }
            10 { return 'It has become the busiest road on the planet.' }
            11 { return 'Seen from orbit, it and the Tower of Democratic Thought stand like two needles driven into the same landmass.' }
            12 { return 'Its lamps join into a single line, a horizon stood on end at night.' }
            13 { return 'Its throughput now exceeds every ground port on the planet combined.' }
            14 { return 'A second transfer port opens at its crown, to end the queue and to not be outdone.' }
            15 { return 'Looking down from the orbital ring, only a sliver of dark separates the two towers.' }
            16 { return 'It begins bringing orbital goods down, at a scale larger than what goes up.' }
            17 { return 'A second cargo track is fitted, because the first is worn bright by use.' }
            18 { return 'It is no longer a transport facility but an artery of the planet economy.' }
            19 { return 'It is nearly at the theoretical limit, and the base crews now work in three shifts.' }
            20 { return 'It too has reached the limit. The two towers now face each other above the skyline, and neither has truly won.' }
        }
    }
    return ''
}

# ---------- 中文 ----------
$zh = New-Object System.Text.StringBuilder
[void]$zh.AppendLine('l_simp_chinese:')
[void]$zh.AppendLine(' origin_high_above:0 "高天之上"')
[void]$zh.AppendLine(' origin_high_above_desc:0 "这个文明向星空攀登的动力，源自前太空时代两个国家之间一场旷日持久的攀比：为了证明自己才是最优秀的国家，两国不断把行政大楼盖得比对方更高。这场竞赛从未真正结束——直到今天，这两座伟大的太空电梯仍在不断向上攀升。"')
[void]$zh.AppendLine(' origin_high_above_effects:0 "—母星上矗立着§Y民主思想塔§!与§Y自由火炬塔§!两座太空电梯，各可攀升至 20 层\n—§Y民主思想塔§!提供$mod_planet_amenities_add$、$mod_planet_stability_add$与$mod_pop_happiness$，层数越高越强\n—§Y自由火炬塔§!提供$MOD_POP_BONUS_WORKFORCE_MULT$与$mod_planet_jobs_trade_produces_mult$，层数越高越强\n—可以通过星球决议投入$r_energy$与$r_minerals$，加高任意一座塔\n—两塔高度不等时会产生§Y攀比效应§!：高差越大，$MOD_POP_BONUS_WORKFORCE_MULT$越高，但$mod_planet_stability_add$下降也越严重"')
[void]$zh.AppendLine(' origin_high_above_requires_conciliation:0 "必须是§Y调和主义§!思潮"')
[void]$zh.AppendLine('')
for ($i = 1; $i -le $MAX; $i++) {
    [void]$zh.AppendLine(" d_msi_democracy_tower_${i}:0 `"民主思想塔 $($roman[$i-1])`"")
}
for ($i = 1; $i -le $MAX; $i++) {
    [void]$zh.AppendLine(" d_msi_democracy_tower_${i}_desc:0 `"$(Get-DescZh $i 'dem')`"")
}
[void]$zh.AppendLine('')
for ($i = 1; $i -le $MAX; $i++) {
    [void]$zh.AppendLine(" d_msi_liberty_tower_${i}:0 `"自由火炬塔 $($roman[$i-1])`"")
}
for ($i = 1; $i -le $MAX; $i++) {
    [void]$zh.AppendLine(" d_msi_liberty_tower_${i}_desc:0 `"$(Get-DescZh $i 'lib')`"")
}
[void]$zh.AppendLine('')
[void]$zh.AppendLine(' decision_msi_democracy_tower_up:0 "加高民主思想塔"')
[void]$zh.AppendLine(' decision_msi_democracy_tower_up_desc:0 "把民主思想塔再往上接一层（最高 20 层）。投入$r_energy$与$r_minerals$，让它在与自由火炬塔的较量中取得领先。"')
[void]$zh.AppendLine(' decision_msi_liberty_tower_up:0 "加高自由火炬塔"')
[void]$zh.AppendLine(' decision_msi_liberty_tower_up_desc:0 "把自由火炬塔再往上接一层（最高 20 层）。投入$r_energy$与$r_minerals$，让它不至于被民主思想塔比下去。"')
[void]$zh.AppendLine('')
for ($g = 1; $g -le 4; $g++) { [void]$zh.AppendLine(" msi_tower_gap_${g}:0 `"攀比效应`"") }

# ---------- 英文 ----------
$en = New-Object System.Text.StringBuilder
[void]$en.AppendLine('l_english:')
[void]$en.AppendLine(' origin_high_above:0 "High Above"')
[void]$en.AppendLine(' origin_high_above_desc:0 "This civilization''s drive to reach the stars began with a contest between two pre-FTL nations: each one kept building its administrative towers higher than the other, simply to prove which of them was the superior nation. That race never truly ended - the two great space elevators still climb to this day."')
[void]$en.AppendLine(' origin_high_above_effects:0 "—Two space elevators, the §YTower of Democratic Thought§! and the §YTower of the Liberty Torch§!, stand upon the homeworld; each can climb to 20 levels\n—The §YTower of Democratic Thought§! provides $mod_planet_amenities_add$, $mod_planet_stability_add$ and $mod_pop_happiness$, growing stronger with each level\n—The §YTower of the Liberty Torch§! provides $MOD_POP_BONUS_WORKFORCE_MULT$ and $mod_planet_jobs_trade_produces_mult$, growing stronger with each level\n—Planetary decisions let you spend $r_energy$ and $r_minerals$ to raise either tower\n—When the two towers stand at different heights a §YRivalry Effect§! arises: the greater the gap, the higher the $MOD_POP_BONUS_WORKFORCE_MULT$, but the worse the $mod_planet_stability_add$ penalty"')
[void]$en.AppendLine(' origin_high_above_requires_conciliation:0 "Must have the §YConciliatory§! ethic"')
[void]$en.AppendLine('')
for ($i = 1; $i -le $MAX; $i++) {
    [void]$en.AppendLine(" d_msi_democracy_tower_${i}:0 `"Tower of Democratic Thought $($roman[$i-1])`"")
}
for ($i = 1; $i -le $MAX; $i++) {
    [void]$en.AppendLine(" d_msi_democracy_tower_${i}_desc:0 `"$(Get-DescEn $i 'dem')`"")
}
[void]$en.AppendLine('')
for ($i = 1; $i -le $MAX; $i++) {
    [void]$en.AppendLine(" d_msi_liberty_tower_${i}:0 `"Tower of the Liberty Torch $($roman[$i-1])`"")
}
for ($i = 1; $i -le $MAX; $i++) {
    [void]$en.AppendLine(" d_msi_liberty_tower_${i}_desc:0 `"$(Get-DescEn $i 'lib')`"")
}
[void]$en.AppendLine('')
[void]$en.AppendLine(' decision_msi_democracy_tower_up:0 "Raise the Tower of Democratic Thought"')
[void]$en.AppendLine(' decision_msi_democracy_tower_up_desc:0 "Add another level to the Tower of Democratic Thought (up to 20). Spend $r_energy$ and $r_minerals$ to pull ahead of the Liberty Torch."')
[void]$en.AppendLine(' decision_msi_liberty_tower_up:0 "Raise the Tower of the Liberty Torch"')
[void]$en.AppendLine(' decision_msi_liberty_tower_up_desc:0 "Add another level to the Tower of the Liberty Torch (up to 20). Spend $r_energy$ and $r_minerals$ so it is not outdone by the Tower of Democratic Thought."')
[void]$en.AppendLine('')
for ($g = 1; $g -le 4; $g++) { [void]$en.AppendLine(" msi_tower_gap_${g}:0 `"Rivalry Effect`"") }

$enc = New-Object System.Text.UTF8Encoding($true)
[System.IO.File]::WriteAllText("$mod\localisation\simp_chinese\msi_dsai_origin_high_above_l_simp_chinese.yml", $zh.ToString(), $enc)
[System.IO.File]::WriteAllText("$mod\localisation\english\msi_dsai_origin_high_above_l_english.yml", $en.ToString(), $enc)

foreach ($f in @('simp_chinese\msi_dsai_origin_high_above_l_simp_chinese.yml','english\msi_dsai_origin_high_above_l_english.yml')) {
    $p = Join-Path "$mod\localisation" $f
    $b = [System.IO.File]::ReadAllBytes($p)
    $t = [System.IO.File]::ReadAllText($p, [System.Text.Encoding]::UTF8)
    $keys = [regex]::Matches($t, '(?m)^\s*([A-Za-z0-9_\.]+)\s*:\d*\s*"') | ForEach-Object { $_.Groups[1].Value }
    $bom = ($b[0] -eq 0xEF -and $b[1] -eq 0xBB -and $b[2] -eq 0xBF)
    '  {0,-56} BOM={1} keys={2} lines={3}' -f (Split-Path $p -Leaf), $bom, $keys.Count, ($t -split "`r?`n").Count
}
