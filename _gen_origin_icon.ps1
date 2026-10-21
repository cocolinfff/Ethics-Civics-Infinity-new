Add-Type -AssemblyName System.Drawing
$ErrorActionPreference = 'Stop'

$mod = "E:\Documents\Paradox Interactive\Stellaris\mod\Ethics and Civics Infinity"
$N = 40
$tmpDds = Join-Path $mod '_origin_high_above.dds'
$tmpPng = Join-Path $mod '_origin_high_above_preview.png'

$refPath = Join-Path $mod 'gfx\interface\icons\origins\origin_true_yuht.dds'
$ref = [System.IO.File]::ReadAllBytes($refPath)
$hdr = New-Object byte[] 128
[Array]::Copy($ref, 0, $hdr, 0, 128)

$bmp = [System.Drawing.Bitmap]::new($N, $N)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$g.Clear([System.Drawing.Color]::Transparent)

# ---- 菱形画框 ----
$pts = New-Object 'System.Drawing.PointF[]' 4
$pts[0] = [System.Drawing.PointF]::new(20.0, 2.5)
$pts[1] = [System.Drawing.PointF]::new(37.5, 20.0)
$pts[2] = [System.Drawing.PointF]::new(20.0, 37.5)
$pts[3] = [System.Drawing.PointF]::new(2.5, 20.0)
$diamond = New-Object System.Drawing.Drawing2D.GraphicsPath
$diamond.AddPolygon($pts)

$pgb = New-Object System.Drawing.Drawing2D.PathGradientBrush $diamond
$pgb.CenterPoint = [System.Drawing.PointF]::new(20.0, 20.0)
$pgb.CenterColor = [System.Drawing.Color]::FromArgb(255, 0, 92, 76)
$pgb.SurroundColors = [System.Drawing.Color[]]@([System.Drawing.Color]::FromArgb(255, 0, 34, 30))
$g.FillPath($pgb, $diamond)

$penOuter = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(150, 2, 173, 136), [single]1.6)
$g.DrawPath($penOuter, $diamond)
$penInner = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(255, 0, 53, 46), [single]1.2)
$g.DrawPath($penInner, $diamond)

# ---- 图案：两座细长的太空电梯，左高右矮 ----
$glow   = [System.Drawing.Color]::FromArgb(255, 0, 224, 178)
$glowHi = [System.Drawing.Color]::FromArgb(255, 0, 255, 216)
$bMid   = [System.Drawing.SolidBrush]::new($glow)
$bHi    = [System.Drawing.SolidBrush]::new($glowHi)

# 左塔：塔身 2px，从 y=10 到 y=31
$g.FillRectangle($bMid, [System.Drawing.Rectangle]::new(13, 10, 2, 21))
# 左塔顶：平台 + 塔尖
$g.FillRectangle($bHi, [System.Drawing.Rectangle]::new(10, 8, 8, 2))
$g.FillRectangle($bHi, [System.Drawing.Rectangle]::new(13, 6, 2, 2))

# 右塔：塔身 2px，从 y=18 到 y=31（明显更矮）
$g.FillRectangle($bMid, [System.Drawing.Rectangle]::new(23, 18, 2, 13))
$g.FillRectangle($bHi, [System.Drawing.Rectangle]::new(20, 16, 8, 2))
$g.FillRectangle($bHi, [System.Drawing.Rectangle]::new(23, 14, 2, 2))

# 塔身吊舱（横线，体现电梯轿厢）
$g.FillRectangle($bHi, [System.Drawing.Rectangle]::new(12, 14, 4, 1))
$g.FillRectangle($bHi, [System.Drawing.Rectangle]::new(12, 19, 4, 1))
$g.FillRectangle($bHi, [System.Drawing.Rectangle]::new(12, 25, 4, 1))
$g.FillRectangle($bHi, [System.Drawing.Rectangle]::new(22, 22, 4, 1))
$g.FillRectangle($bHi, [System.Drawing.Rectangle]::new(22, 27, 4, 1))

# 公共基座
$g.FillRectangle($bHi, [System.Drawing.Rectangle]::new(9, 31, 20, 2))
$g.FillRectangle($bHi, [System.Drawing.Rectangle]::new(12, 33, 14, 1))

$g.Dispose()

$out = New-Object byte[] (128 + $N * $N * 4)
[Array]::Copy($hdr, 0, $out, 0, 128)
for ($y = 0; $y -lt $N; $y++) {
    for ($x = 0; $x -lt $N; $x++) {
        $c = $bmp.GetPixel($x, $y)
        $o = 128 + ($y * $N + $x) * 4
        $out[$o]     = [byte]$c.B
        $out[$o + 1] = [byte]$c.G
        $out[$o + 2] = [byte]$c.R
        $out[$o + 3] = [byte]$c.A
    }
}
[System.IO.File]::WriteAllBytes($tmpDds, $out)

$s = 10
$prev = [System.Drawing.Bitmap]::new($N * $s, $N * $s)
$pg = [System.Drawing.Graphics]::FromImage($prev)
$pg.Clear([System.Drawing.Color]::FromArgb(255, 30, 32, 38))
$pg.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::NearestNeighbor
$pg.DrawImage($bmp, 0, 0, $N * $s, $N * $s)
$pg.Dispose()
$prev.Save($tmpPng, [System.Drawing.Imaging.ImageFormat]::Png)
$prev.Dispose()
$bmp.Dispose()

"dds  -> $tmpDds ($((Get-Item $tmpDds).Length) bytes)"
"png  -> $tmpPng"
