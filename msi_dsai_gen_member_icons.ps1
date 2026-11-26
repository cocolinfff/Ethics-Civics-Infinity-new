# ============================================================================
# 生成成员国徽记（60x60 DDS，A8R8G8B8 无压缩）
# 输出到 gfx/interface/icons/msi_dsai/ms_member_<i>.dds
# 同时输出预览 PNG 到 _icon_analysis/ms_member_<i>_preview.png
# ============================================================================
Add-Type -AssemblyName System.Drawing
$ErrorActionPreference = 'Stop'

$mod = "E:\Documents\Paradox Interactive\Stellaris\mod\Ethics and Civics Infinity"
$outDir = Join-Path $mod "gfx\interface\icons\msi_dsai"
$prevDir = Join-Path $mod "_icon_analysis"
New-Item -ItemType Directory -Force -Path $outDir | Out-Null
New-Item -ItemType Directory -Force -Path $prevDir | Out-Null

$N = 60

function Write-Dds([System.Drawing.Bitmap]$bmp, [string]$path) {
    $w = $bmp.Width
    $h = $bmp.Height
    $ms = New-Object System.IO.MemoryStream
    $bw = New-Object System.IO.BinaryWriter($ms)
    $bw.Write([char[]]@('D', 'D', 'S', ' '))
    $bw.Write([uint32]124)
    $bw.Write([uint32]0x81007)
    $bw.Write([uint32]$h)
    $bw.Write([uint32]$w)
    $bw.Write([uint32]($w * 4))
    $bw.Write([uint32]0)
    $bw.Write([uint32]0)
    for ($i = 0; $i -lt 11; $i++) { $bw.Write([uint32]0) }
    $bw.Write([uint32]32)
    $bw.Write([uint32]0x41)
    $bw.Write([uint32]0)
    $bw.Write([uint32]32)
    $bw.Write([uint32]0x00FF0000)
    $bw.Write([uint32]0x0000FF00)
    $bw.Write([uint32]0x000000FF)
    $bw.Write([uint32]4294967295)
    $bw.Write([uint32]0x1000)
    $bw.Write([uint32]0)
    $bw.Write([uint32]0)
    $bw.Write([uint32]0)
    $bw.Write([uint32]0)

    for ($y = 0; $y -lt $h; $y++) {
        for ($x = 0; $x -lt $w; $x++) {
            $c = $bmp.GetPixel($x, $y)
            $bw.Write([byte]$c.B)
            $bw.Write([byte]$c.G)
            $bw.Write([byte]$c.R)
            $bw.Write([byte]$c.A)
        }
    }
    $bw.Flush()
    [System.IO.File]::WriteAllBytes($path, $ms.ToArray())
    $bw.Dispose()
    $ms.Dispose()
}

function New-Icon([int]$id) {
    $bmp = New-Object System.Drawing.Bitmap($N, $N)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.Clear([System.Drawing.Color]::Transparent)

    if ($id -eq 1) {
        $bg = [System.Drawing.Color]::FromArgb(255, 22, 42, 96)
        $fg = [System.Drawing.Color]::FromArgb(255, 150, 200, 255)
    }
    elseif ($id -eq 2) {
        $bg = [System.Drawing.Color]::FromArgb(255, 96, 18, 18)
        $fg = [System.Drawing.Color]::FromArgb(255, 255, 130, 96)
    }
    elseif ($id -eq 3) {
        $bg = [System.Drawing.Color]::FromArgb(255, 48, 54, 64)
        $fg = [System.Drawing.Color]::FromArgb(255, 205, 215, 230)
    }
    elseif ($id -eq 4) {
        $bg = [System.Drawing.Color]::FromArgb(255, 58, 24, 88)
        $fg = [System.Drawing.Color]::FromArgb(255, 240, 200, 90)
    }
    else {
        $bg = [System.Drawing.Color]::FromArgb(255, 16, 78, 58)
        $fg = [System.Drawing.Color]::FromArgb(255, 150, 240, 180)
    }

    $rect = [System.Drawing.Rectangle]::new(3, 3, ($N - 6), ($N - 6))
    $bBg = New-Object System.Drawing.SolidBrush($bg)
    $bFg = New-Object System.Drawing.SolidBrush($fg)
    $g.FillEllipse($bBg, $rect)
    $g.DrawEllipse((New-Object System.Drawing.Pen($fg, [single]2.2)), $rect)

    if ($id -eq 1) {
        $g.FillEllipse($bFg, [System.Drawing.Rectangle]::new(27, 27, 6, 6))
        for ($k = 0; $k -lt 5; $k++) {
            $ang = (-90 + $k * 72) * [math]::PI / 180
            $cx = 30 + 15 * [math]::Cos($ang)
            $cy = 30 + 15 * [math]::Sin($ang)
            $g.FillEllipse($bFg, [System.Drawing.Rectangle]::new([int]($cx - 3), [int]($cy - 3), 6, 6))
        }
    }
    elseif ($id -eq 2) {
        foreach ($ox in @(16, 27, 38)) {
            $g.FillRectangle($bFg, [System.Drawing.Rectangle]::new(($ox - 1), 30, 3, 14))
            $pts = New-Object 'System.Drawing.PointF[]' 3
            $pts[0] = [System.Drawing.PointF]::new(($ox - 6), 31)
            $pts[1] = [System.Drawing.PointF]::new(($ox + 6), 31)
            $pts[2] = [System.Drawing.PointF]::new($ox, 18)
            $g.FillPolygon($bFg, $pts)
        }
    }
    elseif ($id -eq 3) {
        for ($k = 0; $k -lt 8; $k++) {
            $ang = $k * 45 * [math]::PI / 180
            $cx = 30 + 20 * [math]::Cos($ang)
            $cy = 30 + 20 * [math]::Sin($ang)
            $g.FillRectangle($bFg, [System.Drawing.Rectangle]::new([int]($cx - 3), [int]($cy - 3), 6, 6))
        }
        $bBg2 = New-Object System.Drawing.SolidBrush($bg)
        $g.FillEllipse($bBg2, [System.Drawing.Rectangle]::new(16, 16, 28, 28))
        $g.DrawEllipse((New-Object System.Drawing.Pen($fg, [single]2.0)), [System.Drawing.Rectangle]::new(16, 16, 28, 28))
        $g.FillRectangle($bFg, [System.Drawing.Rectangle]::new(28, 14, 4, 26))
        $g.FillRectangle($bFg, [System.Drawing.Rectangle]::new(22, 34, 16, 3))
        $bBg2.Dispose()
    }
    elseif ($id -eq 4) {
        $pts = New-Object 'System.Drawing.PointF[]' 7
        $pts[0] = [System.Drawing.PointF]::new(14, 42)
        $pts[1] = [System.Drawing.PointF]::new(14, 24)
        $pts[2] = [System.Drawing.PointF]::new(22, 32)
        $pts[3] = [System.Drawing.PointF]::new(30, 16)
        $pts[4] = [System.Drawing.PointF]::new(38, 32)
        $pts[5] = [System.Drawing.PointF]::new(46, 24)
        $pts[6] = [System.Drawing.PointF]::new(46, 42)
        $g.FillPolygon($bFg, $pts)
        $g.FillRectangle($bFg, [System.Drawing.Rectangle]::new(13, 43, 34, 4))
    }
    else {
        $g.FillRectangle($bFg, [System.Drawing.Rectangle]::new(28, 18, 4, 24))
        $g.FillRectangle($bFg, [System.Drawing.Rectangle]::new(15, 20, 30, 3))
        $g.FillRectangle($bFg, [System.Drawing.Rectangle]::new(18, 23, 2, 9))
        $g.FillRectangle($bFg, [System.Drawing.Rectangle]::new(40, 23, 2, 9))
        $ptsL = New-Object 'System.Drawing.PointF[]' 3
        $ptsL[0] = [System.Drawing.PointF]::new(12, 32)
        $ptsL[1] = [System.Drawing.PointF]::new(26, 32)
        $ptsL[2] = [System.Drawing.PointF]::new(19, 39)
        $g.FillPolygon($bFg, $ptsL)
        $ptsR = New-Object 'System.Drawing.PointF[]' 3
        $ptsR[0] = [System.Drawing.PointF]::new(34, 32)
        $ptsR[1] = [System.Drawing.PointF]::new(48, 32)
        $ptsR[2] = [System.Drawing.PointF]::new(41, 39)
        $g.FillPolygon($bFg, $ptsR)
        $g.FillRectangle($bFg, [System.Drawing.Rectangle]::new(22, 41, 16, 3))
    }

    $bBg.Dispose()
    $bFg.Dispose()
    $g.Dispose()
    return $bmp
}

for ($i = 1; $i -le 5; $i++) {
    $bmp = New-Icon $i
    $dds = Join-Path $outDir "ms_member_$i.dds"
    Write-Dds $bmp $dds

    $s = 8
    $prev = New-Object System.Drawing.Bitmap(($N * $s), ($N * $s))
    $pg = [System.Drawing.Graphics]::FromImage($prev)
    $pg.Clear([System.Drawing.Color]::FromArgb(255, 26, 28, 34))
    $pg.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::NearestNeighbor
    $pg.DrawImage($bmp, 0, 0, ($N * $s), ($N * $s))
    $pg.Dispose()
    $prev.Save((Join-Path $prevDir "ms_member_${i}_preview.png"), [System.Drawing.Imaging.ImageFormat]::Png)
    $prev.Dispose()
    $bmp.Dispose()

    "icon $i -> $dds ($((Get-Item $dds).Length) bytes)"
}
