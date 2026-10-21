Add-Type -AssemblyName System.Drawing
$ErrorActionPreference = 'Stop'

$mod     = "E:\Documents\Paradox Interactive\Stellaris\mod\Ethics and Civics Infinity"
$iconDir = Join-Path $mod "gfx\interface\icons\governments\civics"
$tmp     = Join-Path $mod "_icon_analysis"
$N       = 29
$NP      = 841

function Get-RefAlpha([string]$fileName) {
    $b = [System.IO.File]::ReadAllBytes((Join-Path $iconDir $fileName))
    $a = New-Object 'int[]' $NP
    for ($i = 0; $i -lt $NP; $i++) { $a[$i] = $b[128 + $i * 4 + 3] }
    return ,$a
}

# blue no-border template (national culture) and green no-border template (nationality)
$refBlueFile  = "civic_art_country.dds"
$refGreenFile = "civic_adventurers_guild.dds"
$shapeBlue  = Get-RefAlpha $refBlueFile
$shapeGreen = Get-RefAlpha $refGreenFile

$diff = 0
for ($i = 0; $i -lt $NP; $i++) { if ($shapeBlue[$i] -ne $shapeGreen[$i]) { $diff++ } }
Write-Output ("blue vs green silhouette diff: $diff / $NP")

$hdrBlue  = New-Object byte[] 128
$hdrGreen = New-Object byte[] 128
[Array]::Copy([System.IO.File]::ReadAllBytes((Join-Path $iconDir $refBlueFile)),  0, $hdrBlue,  0, 128)
[Array]::Copy([System.IO.File]::ReadAllBytes((Join-Path $iconDir $refGreenFile)), 0, $hdrGreen, 0, 128)
$hdiff = 0
for ($i = 0; $i -lt 128; $i++) { if ($hdrBlue[$i] -ne $hdrGreen[$i]) { $hdiff++ } }
Write-Output ("blue vs green header diff: $hdiff / 128")

function New-Glyph {
    param([string]$DrawFn)
    $bmp = [System.Drawing.Bitmap]::new($N, $N)
    $g   = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $g.Clear([System.Drawing.Color]::Transparent)
    & $DrawFn $g
    $m = New-Object 'double[]' $NP
    for ($y = 0; $y -lt $N; $y++) {
        for ($x = 0; $x -lt $N; $x++) {
            $m[$y * $N + $x] = [double]$bmp.GetPixel($x, $y).A / 255.0
        }
    }
    $g.Dispose(); $bmp.Dispose()
    return ,$m
}

function Compose {
    param([double[]]$Glyph, [int]$BR, [int]$BG, [int]$BB, [int]$PR, [int]$PG, [int]$PB, [int[]]$Shape)
    $bmp = [System.Drawing.Bitmap]::new($N, $N)
    for ($i = 0; $i -lt $NP; $i++) {
        $x = $i % $N
        $y = [int][math]::Floor($i / $N)
        $a = $Shape[$i]
        if ($a -le 0) {
            $bmp.SetPixel($x, $y, [System.Drawing.Color]::FromArgb(0, 0, 0, 0))
            continue
        }
        $t = $Glyph[$i]
        $r = [math]::Max(0, [math]::Min(255, [int][math]::Round($BR * (1 - $t) + $PR * $t)))
        $g = [math]::Max(0, [math]::Min(255, [int][math]::Round($BG * (1 - $t) + $PG * $t)))
        $b = [math]::Max(0, [math]::Min(255, [int][math]::Round($BB * (1 - $t) + $PB * $t)))
        $bmp.SetPixel($x, $y, [System.Drawing.Color]::FromArgb($a, $r, $g, $b))
    }
    return $bmp
}

function Draw-Balance($g) {
    $blk = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::Black)
    $p2  = [System.Drawing.Pen]::new([System.Drawing.Color]::Black, [single]2.0)
    $p2.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
    $p2.EndCap   = [System.Drawing.Drawing2D.LineCap]::Round
    $g.FillEllipse($blk, [System.Drawing.Rectangle]::new(12, 3, 5, 5))
    $g.DrawLine($p2, [System.Drawing.Point]::new(14, 6), [System.Drawing.Point]::new(14, 22))
    $g.DrawLine($p2, [System.Drawing.Point]::new(5, 9), [System.Drawing.Point]::new(24, 9))
    $a = New-Object 'System.Drawing.Point[]' 3
    $a[0] = [System.Drawing.Point]::new(4, 10)
    $a[1] = [System.Drawing.Point]::new(10, 10)
    $a[2] = [System.Drawing.Point]::new(7, 17)
    $g.FillPolygon($blk, $a)
    $b = New-Object 'System.Drawing.Point[]' 3
    $b[0] = [System.Drawing.Point]::new(19, 10)
    $b[1] = [System.Drawing.Point]::new(25, 10)
    $b[2] = [System.Drawing.Point]::new(22, 17)
    $g.FillPolygon($blk, $b)
    $c = New-Object 'System.Drawing.Point[]' 4
    $c[0] = [System.Drawing.Point]::new(9, 22)
    $c[1] = [System.Drawing.Point]::new(20, 22)
    $c[2] = [System.Drawing.Point]::new(18, 25)
    $c[3] = [System.Drawing.Point]::new(11, 25)
    $g.FillPolygon($blk, $c)
    $blk.Dispose(); $p2.Dispose()
}

function Draw-Worm($g) {
    $blk = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::Black)
    $p   = [System.Drawing.Pen]::new([System.Drawing.Color]::Black, [single]3.4)
    $p.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
    $p.EndCap   = [System.Drawing.Drawing2D.LineCap]::Round
    $g.DrawBezier($p, [System.Drawing.Point]::new(5, 24), [System.Drawing.Point]::new(9, 8), [System.Drawing.Point]::new(17, 27), [System.Drawing.Point]::new(21, 11))
    $g.FillEllipse($blk, [System.Drawing.Rectangle]::new(18, 6, 9, 9))
    $p2 = [System.Drawing.Pen]::new([System.Drawing.Color]::Black, [single]2.0)
    $p2.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
    $p2.EndCap   = [System.Drawing.Drawing2D.LineCap]::Round
    $g.DrawLine($p2, [System.Drawing.Point]::new(20, 7), [System.Drawing.Point]::new(16, 2))
    $g.DrawLine($p2, [System.Drawing.Point]::new(24, 7), [System.Drawing.Point]::new(27, 2))
    $p.Dispose(); $p2.Dispose(); $blk.Dispose()
}

function Save-Dds {
    param([string]$Path, [System.Drawing.Bitmap]$Bmp, [byte[]]$Header)
    $out = New-Object byte[] (128 + $NP * 4)
    [Array]::Copy($Header, 0, $out, 0, 128)
    for ($y = 0; $y -lt $N; $y++) {
        for ($x = 0; $x -lt $N; $x++) {
            $c = $Bmp.GetPixel($x, $y)
            $o = 128 + ($y * $N + $x) * 4
            $out[$o]     = [byte]$c.B
            $out[$o + 1] = [byte]$c.G
            $out[$o + 2] = [byte]$c.R
            $out[$o + 3] = [byte]$c.A
        }
    }
    [System.IO.File]::WriteAllBytes($Path, $out)
}

$glyphBalance = New-Glyph "Draw-Balance"
$glyphWorm    = New-Glyph "Draw-Worm"

# mius_wupingheng: nationality -> teal (0,179,138), black glyph, no border
$imgBalance = Compose -Glyph $glyphBalance -BR 0 -BG 179 -BB 138 -PR 0 -PG 0 -PB 0 -Shape $shapeGreen
# maoxingzhe: national culture -> blue (76,87,255), white glyph, no border
$imgWorm    = Compose -Glyph $glyphWorm    -BR 76 -BG 87 -BB 255 -PR 255 -PG 255 -PB 255 -Shape $shapeBlue

$ddsBalance = Join-Path $iconDir "civic_mius_wupingheng.dds"
$ddsWorm    = Join-Path $iconDir "civic_maoxingzhe.dds"

Save-Dds -Path $ddsBalance -Bmp $imgBalance -Header $hdrGreen
Save-Dds -Path $ddsWorm    -Bmp $imgWorm    -Header $hdrBlue

Write-Output "=== verification ==="
foreach ($pair in @(@($ddsBalance, $hdrGreen, $shapeGreen, "GREEN"), @($ddsWorm, $hdrBlue, $shapeBlue, "BLUE"))) {
    $f = $pair[0]; $hdr = $pair[1]; $shp = $pair[2]; $tag = $pair[3]
    $b = [System.IO.File]::ReadAllBytes($f)
    $hd = 0; for ($i = 0; $i -lt 128; $i++) { if ($b[$i] -ne $hdr[$i]) { $hd++ } }
    $ad = 0; for ($i = 0; $i -lt $NP; $i++) { if ($b[128 + $i * 4 + 3] -ne $shp[$i]) { $ad++ } }
    $op = 0; $se = 0
    for ($i = 0; $i -lt $NP; $i++) { $v = $b[128 + $i * 4 + 3]; if ($v -eq 255) { $op++ } elseif ($v -gt 0) { $se++ } }
    Write-Output ("  {0,-28} bytes={1} headerDiff={2} alphaDiff={3} opaque={4} semi={5} empty={6} [{7}]" -f `
        (Split-Path $f -Leaf), $b.Length, $hd, $ad, $op, $se, ($NP - $op - $se), $tag)
}

Write-Output "=== corner/edge emptiness (must be transparent) ==="
foreach ($f in @($ddsBalance, $ddsWorm)) {
    $b = [System.IO.File]::ReadAllBytes($f)
    $bad = 0
    for ($i = 0; $i -lt $NP; $i++) {
        $y = [int][math]::Floor($i / $N); $x = $i % $N
        if (($y -eq 0 -or $y -eq 28 -or $x -eq 0 -or $x -eq 28) -and $b[128 + $i * 4 + 3] -ne 0) { $bad++ }
    }
    Write-Output ("  {0}: non-transparent border pixels = {1}" -f (Split-Path $f -Leaf), $bad)
}

# final visual sheet
$scale = 10
$pad   = 12
$cell  = $N * $scale
$out   = [System.Drawing.Bitmap]::new($cell * 4 + $pad * 5, $cell + $pad * 2 + 22)
$og    = [System.Drawing.Graphics]::FromImage($out)
$og.Clear([System.Drawing.Color]::FromArgb(255, 26, 28, 34))
$og.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::NearestNeighbor

function Load-DdsBitmap([string]$fileName) {
    $b = [System.IO.File]::ReadAllBytes((Join-Path $iconDir $fileName))
    $bmp = [System.Drawing.Bitmap]::new($N, $N)
    for ($y = 0; $y -lt $N; $y++) {
        for ($x = 0; $x -lt $N; $x++) {
            $o = 128 + ($y * $N + $x) * 4
            $bmp.SetPixel($x, $y, [System.Drawing.Color]::FromArgb($b[$o + 3], $b[$o + 2], $b[$o + 1], $b[$o]))
        }
    }
    return $bmp
}

$rBlue  = Load-DdsBitmap $refBlueFile
$rGreen = Load-DdsBitmap $refGreenFile

$items = @(
    @{ Img = $rBlue;      Label = "ref art_country (blue)" },
    @{ Img = $rGreen;     Label = "ref adventurers (teal)" },
    @{ Img = $imgBalance; Label = "civic_mius_wupingheng" },
    @{ Img = $imgWorm;    Label = "civic_maoxingzhe" }
)
$i = 0
foreach ($it in $items) {
    $x = $pad + $i * ($cell + $pad)
    $og.DrawImage($it.Img, $x, $pad, $cell, $cell)
    $og.DrawString($it.Label, [System.Drawing.Font]::new("Consolas", 9), [System.Drawing.Brushes]::White, [single]$x, [single]($pad + $cell + 3))
    $i++
}
$og.Dispose()
$out.Save((Join-Path $tmp "final2.png"), [System.Drawing.Imaging.ImageFormat]::Png)
$out.Dispose(); $rBlue.Dispose(); $rGreen.Dispose(); $imgBalance.Dispose(); $imgWorm.Dispose()
Write-Output ("final sheet -> " + (Join-Path $tmp "final2.png"))
