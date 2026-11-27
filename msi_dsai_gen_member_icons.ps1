# ============================================================================
# Member state holographic emblems.
# Output: ms_member_<i>.dds       60x60
#         ms_member_<i>_large.dds 72x72
#         ms_member_<i>_small.dds 32x32
# Palette stays per country (blue / red / steel / purple-gold / green).
# ============================================================================
Add-Type -AssemblyName System.Drawing
$ErrorActionPreference = 'Stop'

$mod = "E:\Documents\Paradox Interactive\Stellaris\mod\Ethics and Civics Infinity"
$outDir = Join-Path $mod "gfx\interface\icons\msi_dsai"
$prevDir = Join-Path $mod "_icon_analysis"
New-Item -ItemType Directory -Force -Path $outDir | Out-Null
New-Item -ItemType Directory -Force -Path $prevDir | Out-Null

function WriteDds($bmp, $path) {
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

function Col($r, $g, $b, $a) { return [System.Drawing.Color]::FromArgb([int]$a, [int]$r, [int]$g, [int]$b) }

# Draw one line with a soft glow (three passes).
function GlowLine($g, $col, $x1, $y1, $x2, $y2, $w) {
    $r = [int]$col.R; $gr = [int]$col.G; $b = [int]$col.B
    $p = New-Object System.Drawing.Pen((Col $r $gr $b 40), [single]($w * 3.0))
    $g.DrawLine($p, [single]$x1, [single]$y1, [single]$x2, [single]$y2); $p.Dispose()
    $p = New-Object System.Drawing.Pen((Col $r $gr $b 120), [single]($w * 1.7))
    $g.DrawLine($p, [single]$x1, [single]$y1, [single]$x2, [single]$y2); $p.Dispose()
    $p = New-Object System.Drawing.Pen((Col $r $gr $b 255), [single]$w)
    $g.DrawLine($p, [single]$x1, [single]$y1, [single]$x2, [single]$y2); $p.Dispose()
}

function GlowEllipse($g, $col, $cx, $cy, $rad, $w) {
    $r = [int]$col.R; $gr = [int]$col.G; $b = [int]$col.B
    $x = $cx - $rad; $y = $cy - $rad; $d = $rad * 2
    $p = New-Object System.Drawing.Pen((Col $r $gr $b 45), [single]($w * 3.0))
    $g.DrawEllipse($p, [single]$x, [single]$y, [single]$d, [single]$d); $p.Dispose()
    $p = New-Object System.Drawing.Pen((Col $r $gr $b 130), [single]($w * 1.7))
    $g.DrawEllipse($p, [single]$x, [single]$y, [single]$d, [single]$d); $p.Dispose()
    $p = New-Object System.Drawing.Pen((Col $r $gr $b 255), [single]$w)
    $g.DrawEllipse($p, [single]$x, [single]$y, [single]$d, [single]$d); $p.Dispose()
}

function GlowArc($g, $col, $cx, $cy, $rad, $start, $sweep, $w) {
    $r = [int]$col.R; $gr = [int]$col.G; $b = [int]$col.B
    $x = $cx - $rad; $y = $cy - $rad; $d = $rad * 2
    $p = New-Object System.Drawing.Pen((Col $r $gr $b 45), [single]($w * 3.0))
    $g.DrawArc($p, [single]$x, [single]$y, [single]$d, [single]$d, [single]$start, [single]$sweep); $p.Dispose()
    $p = New-Object System.Drawing.Pen((Col $r $gr $b 130), [single]($w * 1.7))
    $g.DrawArc($p, [single]$x, [single]$y, [single]$d, [single]$d, [single]$start, [single]$sweep); $p.Dispose()
    $p = New-Object System.Drawing.Pen((Col $r $gr $b 255), [single]$w)
    $g.DrawArc($p, [single]$x, [single]$y, [single]$d, [single]$d, [single]$start, [single]$sweep); $p.Dispose()
}

function FillPoly($g, $col, $pts, $alpha) {
    $path = New-Object System.Drawing.Drawing2D.GraphicsPath
    $path.AddPolygon($pts)
    $br = New-Object System.Drawing.SolidBrush((Col $col.R $col.G $col.B $alpha))
    $g.FillPath($br, $path)
    $br.Dispose()
    $path.Dispose()
}

function Star($g, $col, $cx, $cy, $outer, $inner, $alpha) {
    $pts = [System.Drawing.PointF[]]::new(10)
    for ($i = 0; $i -lt 10; $i++) {
        $ang = -90 + $i * 36
        $rr = $outer
        if ($i % 2 -eq 1) { $rr = $inner }
        $rad = $ang * [Math]::PI / 180
        $pts[$i] = [System.Drawing.PointF]::new([single]($cx + $rr * [Math]::Cos($rad)), [single]($cy + $rr * [Math]::Sin($rad)))
    }
    FillPoly $g $col $pts $alpha
}

function Draw-Emblem($id, $size) {
    $bmp = New-Object System.Drawing.Bitmap -ArgumentList $size, $size
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.Clear([System.Drawing.Color]::Transparent)

    $scale = $size / 72.0
    $g.ScaleTransform($scale, $scale)

    $c = 36
    if ($id -eq 1) {
        $bgR = 22; $bgG = 42; $bgB = 96
        $fg = Col 150 200 255
        $bright = Col 235 245 255
    } elseif ($id -eq 2) {
        $bgR = 96; $bgG = 18; $bgB = 18
        $fg = Col 255 130 96
        $bright = Col 255 160 120
    } elseif ($id -eq 3) {
        $bgR = 48; $bgG = 54; $bgB = 64
        $fg = Col 205 215 230
        $bright = Col 235 240 250
    } elseif ($id -eq 4) {
        $bgR = 58; $bgG = 24; $bgB = 88
        $fg = Col 240 200 90
        $bright = Col 255 225 130
    } else {
        $bgR = 16; $bgG = 78; $bgB = 58
        $fg = Col 150 240 180
        $bright = Col 180 255 205
    }

    # base disc
    $br = New-Object System.Drawing.SolidBrush((Col $bgR $bgG $bgB 225))
    $g.FillEllipse($br, 3, 3, 66, 66)
    $br.Dispose()

    # scan lines inside the disc
    $clip = New-Object System.Drawing.Drawing2D.GraphicsPath
    $clip.AddEllipse(3, 3, 66, 66)
    $g.SetClip($clip)
    $scanPen = New-Object System.Drawing.Pen((Col 0 0 0 40), [single]0.8)
    for ($y = 6; $y -lt 69; $y += 3) { $g.DrawLine($scanPen, 3, $y, 69, $y) }
    $scanPen.Dispose()
    $g.ResetClip()
    $clip.Dispose()

    # outer holographic rings
    GlowEllipse $g $bright $c $c 33 1.8
    GlowEllipse $g $fg $c $c 29.5 0.8
    GlowArc $g $fg $c $c 31 -60 120 2.2

    # symbol
    if ($id -eq 1) {
        # Metallic white aquila over a bright blue field (from the reference image):
        # fanned wing feathers, rounded head with a dark visor, tapered body,
        # diamond frame beneath holding the tail, blue glow at the base.
        $silver = Col 225 236 246
        $white = Col 255 255 255

        $hbr = New-Object System.Drawing.SolidBrush($white)
        $g.FillEllipse($hbr, 31, 11, 10, 12)
        $hbr.Dispose()
        $ebr = New-Object System.Drawing.SolidBrush((Col 20 40 70 255))
        $g.FillEllipse($ebr, 34, 15, 5, 3)
        $ebr.Dispose()

        $body = New-Object 'System.Drawing.PointF[]' 4
        $body[0] = [System.Drawing.PointF]::new(31, 21)
        $body[1] = [System.Drawing.PointF]::new(41, 21)
        $body[2] = [System.Drawing.PointF]::new(39, 42)
        $body[3] = [System.Drawing.PointF]::new(33, 42)
        FillPoly $g $white $body 250

        for ($i = 0; $i -lt 6; $i++) {
            $ay = 22 + $i * 2.2
            $tip = 15 - $i * 2
            $band = New-Object 'System.Drawing.PointF[]' 4
            $band[0] = [System.Drawing.PointF]::new(34, $ay)
            $band[1] = [System.Drawing.PointF]::new($tip, ($ay - 5))
            $band[2] = [System.Drawing.PointF]::new($tip, ($ay - 3.6))
            $band[3] = [System.Drawing.PointF]::new(34, ($ay + 1.2))
            FillPoly $g $silver $band 240

            $band2 = New-Object 'System.Drawing.PointF[]' 4
            $band2[0] = [System.Drawing.PointF]::new(38, $ay)
            $band2[1] = [System.Drawing.PointF]::new((72 - $tip), ($ay - 5))
            $band2[2] = [System.Drawing.PointF]::new((72 - $tip), ($ay - 3.6))
            $band2[3] = [System.Drawing.PointF]::new(38, ($ay + 1.2))
            FillPoly $g $silver $band2 240
        }

        $framePts = New-Object 'System.Drawing.PointF[]' 4
        $framePts[0] = [System.Drawing.PointF]::new(36, 44)
        $framePts[1] = [System.Drawing.PointF]::new(50, 56)
        $framePts[2] = [System.Drawing.PointF]::new(36, 68)
        $framePts[3] = [System.Drawing.PointF]::new(22, 56)
        $fpath = New-Object System.Drawing.Drawing2D.GraphicsPath
        $fpath.AddPolygon($framePts)
        $fpen = New-Object System.Drawing.Pen((Col 150 215 255 235), [single]1.8)
        $g.DrawPath($fpen, $fpath); $fpen.Dispose()
        $fpen = New-Object System.Drawing.Pen((Col 150 215 255 70), [single]5.0)
        $g.DrawPath($fpen, $fpath); $fpen.Dispose()
        $fpath.Dispose()

        $tail = New-Object 'System.Drawing.PointF[]' 4
        $tail[0] = [System.Drawing.PointF]::new(36, 50)
        $tail[1] = [System.Drawing.PointF]::new(41, 62)
        $tail[2] = [System.Drawing.PointF]::new(36, 59)
        $tail[3] = [System.Drawing.PointF]::new(31, 62)
        FillPoly $g $white $tail 235

        $glow = New-Object System.Drawing.Pen((Col 90 180 255 120), [single]3.0)
        $g.DrawArc($glow, 20, 50, 32, 22, 20, 140)
        $glow.Dispose()
    } elseif ($id -eq 2) {
        # left half gear + right half wheat ring, red star in the centre
        GlowArc $g $fg $c $c 18 90 180 2.2
        for ($i = 0; $i -lt 8; $i++) {
            $ang = (95 + $i * 22.5) * [Math]::PI / 180
            $x1 = $c + 18 * [Math]::Cos($ang)
            $y1 = $c + 18 * [Math]::Sin($ang)
            $x2 = $c + 22.5 * [Math]::Cos($ang)
            $y2 = $c + 22.5 * [Math]::Sin($ang)
            GlowLine $g $fg $x1 $y1 $x2 $y2 1.7
        }
        GlowArc $g $fg $c $c 17.5 -90 180 1.3
        for ($i = 0; $i -lt 6; $i++) {
            $ang = (-78 + $i * 31) * [Math]::PI / 180
            $gx = $c + 20.5 * [Math]::Cos($ang)
            $gy = $c + 20.5 * [Math]::Sin($ang)
            $gbr = New-Object System.Drawing.SolidBrush((Col $bright.R $bright.G $bright.B 230))
            $g.FillEllipse($gbr, [single]($gx - 2.3), [single]($gy - 1.2), [single]4.6, [single]2.4)
            $gbr.Dispose()
            $tx = $c + 15.0 * [Math]::Cos($ang)
            $ty = $c + 15.0 * [Math]::Sin($ang)
            GlowLine $g $fg $gx $gy $tx $ty 0.7
        }
        GlowLine $g $fg 36 18 36 13 1.2
        Star $g $bright $c $c 9 4 245
    } elseif ($id -eq 3) {
        # steel: hexagonal armor + gear hub + circuit lines + rivets
        $hex = New-Object 'System.Drawing.PointF[]' 6
        for ($i = 0; $i -lt 6; $i++) {
            $ang = (-90 + $i * 60) * [Math]::PI / 180
            $hex[$i] = [System.Drawing.PointF]::new([single]($c + 20 * [Math]::Cos($ang)), [single]($c + 20 * [Math]::Sin($ang)))
        }
        $path = New-Object System.Drawing.Drawing2D.GraphicsPath
        $path.AddPolygon($hex)
        $pen = New-Object System.Drawing.Pen((Col $bright.R $bright.G $bright.B 230), [single]1.8)
        $g.DrawPath($pen, $path); $pen.Dispose()
        $pen = New-Object System.Drawing.Pen((Col $fg.R $fg.G $fg.B 70), [single]5.0)
        $g.DrawPath($pen, $path); $pen.Dispose()
        $path.Dispose()
        GlowEllipse $g $fg $c $c 9 2.0
        Star $g $bright $c $c 5.5 2.6 230
        GlowLine $g $fg 27 27 36 36 1.0
        GlowLine $g $fg 45 27 36 36 1.0
        GlowLine $g $fg 27 45 36 36 1.0
        GlowLine $g $fg 45 45 36 36 1.0
        $rv = New-Object System.Drawing.SolidBrush((Col $bright.R $bright.G $bright.B 255))
        $g.FillEllipse($rv, 36, 16, 3, 3)
        $g.FillEllipse($rv, 36, 53, 3, 3)
        $g.FillEllipse($rv, 16, 34, 3, 3)
        $g.FillEllipse($rv, 53, 34, 3, 3)
        $rv.Dispose()
    } elseif ($id -eq 4) {
        # imperial crown + ribbon
        $crown = New-Object 'System.Drawing.PointF[]' 7
        $crown[0] = [System.Drawing.PointF]::new(20, 44)
        $crown[1] = [System.Drawing.PointF]::new(22, 28)
        $crown[2] = [System.Drawing.PointF]::new(29, 37)
        $crown[3] = [System.Drawing.PointF]::new(36, 22)
        $crown[4] = [System.Drawing.PointF]::new(43, 37)
        $crown[5] = [System.Drawing.PointF]::new(50, 28)
        $crown[6] = [System.Drawing.PointF]::new(52, 44)
        FillPoly $g $fg $crown 200
        GlowLine $g $bright 20 44 52 44 1.8
        GlowArc $g $bright $c 50 10 200 140 1.4
        GlowArc $g $fg $c 46 16 180 180 0.9
        $g.FillEllipse((New-Object System.Drawing.SolidBrush((Col $bright.R $bright.G $bright.B 255))), 21, 26, 4, 4)
        $g.FillEllipse((New-Object System.Drawing.SolidBrush((Col $bright.R $bright.G $bright.B 255))), 34, 20, 4, 4)
        $g.FillEllipse((New-Object System.Drawing.SolidBrush((Col $bright.R $bright.G $bright.B 255))), 47, 26, 4, 4)
    } else {
        # trade league: star ring + scales
        for ($i = 0; $i -lt 12; $i++) {
            $ang = $i * 30 * [Math]::PI / 180
            $x = $c + 26 * [Math]::Cos($ang)
            $y = $c + 26 * [Math]::Sin($ang)
            Star $g $bright $x $y 2.6 1.1 210
        }
        GlowLine $g $bright 36 22 36 50 1.8
        GlowLine $g $fg 24 30 48 30 1.5
        GlowLine $g $fg 24 30 24 38 1.0
        GlowLine $g $fg 48 30 48 38 1.0
        GlowArc $g $bright 24 38 7 0 180 1.4
        GlowArc $g $bright 48 38 7 0 180 1.4
        GlowLine $g $fg 30 50 42 50 1.5
        $g.FillEllipse((New-Object System.Drawing.SolidBrush((Col $bright.R $bright.G $bright.B 255))), 34, 20, 4, 4)
    }

    $g.Dispose()
    return $bmp
}

foreach ($i in 1..5) {
    $big = Draw-Emblem $i 72
    WriteDds $big (Join-Path $outDir ("ms_member_" + $i + "_large.dds"))
    $big.Save((Join-Path $prevDir ("ms_member_" + $i + "_large_preview.png")), [System.Drawing.Imaging.ImageFormat]::Png)
    $big.Dispose()

    $mid = Draw-Emblem $i 60
    WriteDds $mid (Join-Path $outDir ("ms_member_" + $i + ".dds"))
    $mid.Save((Join-Path $prevDir ("ms_member_" + $i + "_preview.png")), [System.Drawing.Imaging.ImageFormat]::Png)
    $mid.Dispose()

    $sm = Draw-Emblem $i 32
    WriteDds $sm (Join-Path $outDir ("ms_member_" + $i + "_small.dds"))
    $sm.Save((Join-Path $prevDir ("ms_member_" + $i + "_small_preview.png")), [System.Drawing.Imaging.ImageFormat]::Png)
    $sm.Dispose()

    Write-Output ("emblem " + $i + " done")
}
