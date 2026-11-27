# ============================================================================
# Joint sovereignty emblem (modifier icon).
# Layout inspired by the UN emblem: olive branches around a central disc.
# The globe is replaced by a simple spiral galaxy, black field, blue lines.
# Output: gfx/interface/icons/msi_dsai/ms_joint_sovereignty.dds (60x60)
# ============================================================================
Add-Type -AssemblyName System.Drawing
$ErrorActionPreference = 'Stop'

$mod = "E:\Documents\Paradox Interactive\Stellaris\mod\Ethics and Civics Infinity"
$outDir = Join-Path $mod "gfx\interface\icons\msi_dsai"
$prevDir = Join-Path $mod "_icon_analysis"
New-Item -ItemType Directory -Force -Path $outDir | Out-Null
New-Item -ItemType Directory -Force -Path $prevDir | Out-Null

function WriteDds($bmp, $path) {
    $w = $bmp.Width; $h = $bmp.Height
    $ms = New-Object System.IO.MemoryStream
    $bw = New-Object System.IO.BinaryWriter($ms)
    $bw.Write([char[]]@('D', 'D', 'S', ' '))
    $bw.Write([uint32]124); $bw.Write([uint32]0x81007)
    $bw.Write([uint32]$h); $bw.Write([uint32]$w)
    $bw.Write([uint32]($w * 4))
    $bw.Write([uint32]0); $bw.Write([uint32]0)
    for ($i = 0; $i -lt 11; $i++) { $bw.Write([uint32]0) }
    $bw.Write([uint32]32); $bw.Write([uint32]0x41); $bw.Write([uint32]0)
    $bw.Write([uint32]32)
    $bw.Write([uint32]0x00FF0000); $bw.Write([uint32]0x0000FF00)
    $bw.Write([uint32]0x000000FF); $bw.Write([uint32]4294967295)
    $bw.Write([uint32]0x1000)
    $bw.Write([uint32]0); $bw.Write([uint32]0); $bw.Write([uint32]0); $bw.Write([uint32]0)
    for ($y = 0; $y -lt $h; $y++) {
        for ($x = 0; $x -lt $w; $x++) {
            $c = $bmp.GetPixel($x, $y)
            $bw.Write([byte]$c.B); $bw.Write([byte]$c.G); $bw.Write([byte]$c.R); $bw.Write([byte]$c.A)
        }
    }
    $bw.Flush()
    [System.IO.File]::WriteAllBytes($path, $ms.ToArray())
    $bw.Dispose(); $ms.Dispose()
}

function Col($r, $g, $b, $a) { return [System.Drawing.Color]::FromArgb([int]$a, [int]$r, [int]$g, [int]$b) }

$size = 60
$cx = 30.0; $cy = 30.0
$bmp = New-Object System.Drawing.Bitmap -ArgumentList $size, $size
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$g.Clear([System.Drawing.Color]::Transparent)

# black field
$black = New-Object System.Drawing.SolidBrush((Col 8 10 16 255))
$g.FillEllipse($black, 2, 2, 56, 56)
$black.Dispose()

# faint inner glow ring
$ring = New-Object System.Drawing.Pen((Col 40 110 200 90), [single]3.0)
$g.DrawEllipse($ring, 4, 4, 52, 52)
$ring.Dispose()

# olive branches (left arc 95..265, right arc -85..85), with leaves
$leafBrush = New-Object System.Drawing.SolidBrush((Col 90 180 255 235))
$branchL = New-Object System.Drawing.Pen((Col 70 160 245 230), [single]1.2)
$g.DrawArc($branchL, 6, 6, 48, 48, 100, 155)
$branchL.Dispose()
$branchR = New-Object System.Drawing.Pen((Col 70 160 245 230), [single]1.2)
$g.DrawArc($branchR, 6, 6, 48, 48, -75, 155)
$branchR.Dispose()

for ($i = 0; $i -lt 8; $i++) {
    $ang = (105 + $i * 19) * [Math]::PI / 180
    $stem = New-Object System.Drawing.Pen((Col 70 160 245 210), [single]0.9)
    $g.DrawLine($stem, [single]($cx + 21 * [Math]::Cos($ang)), [single]($cy + 21 * [Math]::Sin($ang)), [single]($cx + 26 * [Math]::Cos($ang)), [single]($cy + 26 * [Math]::Sin($ang)))
    $stem.Dispose()
    $lx = $cx + 24 * [Math]::Cos($ang)
    $ly = $cy + 24 * [Math]::Sin($ang)
    $g.FillEllipse($leafBrush, [single]($lx - 1.8), [single]($ly - 1.1), [single]3.6, [single]2.2)
    $ang2 = (-85 + $i * 19) * [Math]::PI / 180
    $stem2 = New-Object System.Drawing.Pen((Col 70 160 245 210), [single]0.9)
    $g.DrawLine($stem2, [single]($cx + 21 * [Math]::Cos($ang2)), [single]($cy + 21 * [Math]::Sin($ang2)), [single]($cx + 26 * [Math]::Cos($ang2)), [single]($cy + 26 * [Math]::Sin($ang2)))
    $stem2.Dispose()
    $rx = $cx + 24 * [Math]::Cos($ang2)
    $ry = $cy + 24 * [Math]::Sin($ang2)
    $g.FillEllipse($leafBrush, [single]($rx - 1.8), [single]($ry - 1.1), [single]3.6, [single]2.2)
}
$leafBrush.Dispose()

# spiral galaxy: core + two arms
$armPen = New-Object System.Drawing.Pen((Col 80 170 255 245), [single]1.1)
for ($arm = 0; $arm -lt 2; $arm++) {
    $base = $arm * [Math]::PI
    $prevX = 0.0; $prevY = 0.0
    for ($s = 0; $s -le 40; $s++) {
        $t = $s / 40.0
        $r = 2.2 + 13.5 * $t
        $a = $base + $t * 3.6
        $px = $cx + $r * [Math]::Cos($a)
        $py = $cy + $r * [Math]::Sin($a)
        if ($s -gt 0) { $g.DrawLine($armPen, [single]$prevX, [single]$prevY, [single]$px, [single]$py) }
        $prevX = $px; $prevY = $py
    }
}
$armPen.Dispose()

# arm dust: small dots along both arms
$dot = New-Object System.Drawing.SolidBrush((Col 140 210 255 200))
for ($arm = 0; $arm -lt 2; $arm++) {
    $base = $arm * [Math]::PI
    for ($s = 4; $s -le 34; $s += 5) {
        $t = $s / 40.0
        $r = 2.2 + 13.5 * $t + 1.6
        $a = $base + $t * 3.6 + 0.18
        $px = $cx + $r * [Math]::Cos($a)
        $py = $cy + $r * [Math]::Sin($a)
        $g.FillEllipse($dot, [single]($px - 0.8), [single]($py - 0.8), 1.6, 1.6)
    }
}
$dot.Dispose()

# bright core
$core = New-Object System.Drawing.SolidBrush((Col 180 230 255 255))
$g.FillEllipse($core, [single]($cx - 2.4), [single]($cy - 2.4), 4.8, 4.8)
$core.Dispose()
$core2 = New-Object System.Drawing.SolidBrush((Col 255 255 255 255))
$g.FillEllipse($core2, [single]($cx - 0.9), [single]($cy - 0.9), 1.8, 1.8)
$core2.Dispose()

$g.Dispose()
WriteDds $bmp (Join-Path $outDir "ms_joint_sovereignty.dds")
$bmp.Save((Join-Path $prevDir "ms_joint_sovereignty_preview.png"), [System.Drawing.Imaging.ImageFormat]::Png)
$bmp.Dispose()
Write-Output "joint sovereignty icon done"
