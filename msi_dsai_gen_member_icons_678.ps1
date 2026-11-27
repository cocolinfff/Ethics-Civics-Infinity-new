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
    $bw.Write([uint32]($w * 4)); $bw.Write([uint32]0); $bw.Write([uint32]0)
    for ($i = 0; $i -lt 11; $i++) { $bw.Write([uint32]0) }
    $bw.Write([uint32]32); $bw.Write([uint32]0x41); $bw.Write([uint32]0); $bw.Write([uint32]32)
    $bw.Write([uint32]0x00FF0000); $bw.Write([uint32]0x0000FF00); $bw.Write([uint32]0x000000FF); $bw.Write([uint32]4294967295)
    $bw.Write([uint32]0x1000)
    $bw.Write([uint32]0); $bw.Write([uint32]0); $bw.Write([uint32]0); $bw.Write([uint32]0)
    for ($y = 0; $y -lt $h; $y++) { for ($x = 0; $x -lt $w; $x++) { $c = $bmp.GetPixel($x, $y); $bw.Write([byte]$c.B); $bw.Write([byte]$c.G); $bw.Write([byte]$c.R); $bw.Write([byte]$c.A) } }
    $bw.Flush(); [System.IO.File]::WriteAllBytes($path, $ms.ToArray()); $bw.Dispose(); $ms.Dispose()
}
function Col($r, $g, $b, $a) { return [System.Drawing.Color]::FromArgb([int]$a, [int]$r, [int]$g, [int]$b) }

function Draw-Emblem678($id, $size, $path) {
    $bmp = New-Object System.Drawing.Bitmap -ArgumentList $size, $size
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.Clear([System.Drawing.Color]::Transparent)
    $cx = $size / 2.0; $cy = $size / 2.0; $r = $size * 0.46
    if ($id -eq 6) {
        # Great Nation: black field, red star and ring
        $bg = New-Object System.Drawing.SolidBrush((Col 18 12 12 255)); $g.FillEllipse($bg, [single]($cx - $r), [single]($cy - $r), [single](2 * $r), [single](2 * $r)); $bg.Dispose()
        $ring = New-Object System.Drawing.Pen((Col 200 40 40 255), [single]($size * 0.055)); $g.DrawEllipse($ring, [single]($cx - $r), [single]($cy - $r), [single](2 * $r), [single](2 * $r)); $ring.Dispose()
        # Iron Cross: flared arms, red cross with dark rim and centre medallion
        $arm = $size * 0.36
        $wOut = $size * 0.15
        $wIn = $size * 0.065
        $cross = @(
            (New-Object System.Drawing.PointF([single]($cx - $wOut), [single]($cy - $arm))),
            (New-Object System.Drawing.PointF([single]($cx + $wOut), [single]($cy - $arm))),
            (New-Object System.Drawing.PointF([single]($cx + $wIn), [single]($cy - $wIn))),
            (New-Object System.Drawing.PointF([single]($cx + $arm), [single]($cy - $wIn))),
            (New-Object System.Drawing.PointF([single]($cx + $arm), [single]($cy + $wIn))),
            (New-Object System.Drawing.PointF([single]($cx + $wIn), [single]($cy + $wIn))),
            (New-Object System.Drawing.PointF([single]($cx + $wOut), [single]($cy + $arm))),
            (New-Object System.Drawing.PointF([single]($cx - $wOut), [single]($cy + $arm))),
            (New-Object System.Drawing.PointF([single]($cx - $wIn), [single]($cy + $wIn))),
            (New-Object System.Drawing.PointF([single]($cx - $arm), [single]($cy + $wIn))),
            (New-Object System.Drawing.PointF([single]($cx - $arm), [single]($cy - $wIn))),
            (New-Object System.Drawing.PointF([single]($cx - $wIn), [single]($cy - $wIn)))
        )
        $crossFill = New-Object System.Drawing.SolidBrush((Col 196 36 30 255))
        $g.FillPolygon($crossFill, [System.Drawing.PointF[]]$cross)
        $crossFill.Dispose()
        $crossEdge = New-Object System.Drawing.Pen((Col 12 8 8 255), [single]($size * 0.028))
        $crossEdge.LineJoin = [System.Drawing.Drawing2D.LineJoin]::Miter
        $g.DrawPolygon($crossEdge, [System.Drawing.PointF[]]$cross)
        $crossEdge.Dispose()
        $medal = New-Object System.Drawing.SolidBrush((Col 18 10 10 255))
        $g.FillEllipse($medal, [single]($cx - $size*0.075), [single]($cy - $size*0.075), [single]($size*0.15), [single]($size*0.15))
        $medal.Dispose()
        $medalIn = New-Object System.Drawing.SolidBrush((Col 214 60 44 255))
        $g.FillEllipse($medalIn, [single]($cx - $size*0.032), [single]($cy - $size*0.032), [single]($size*0.064), [single]($size*0.064))
        $medalIn.Dispose()
    }
    elseif ($id -eq 7) {
        # United Academy: white field, red open book
        $bg = New-Object System.Drawing.SolidBrush((Col 238 238 242 255)); $g.FillEllipse($bg, [single]($cx - $r), [single]($cy - $r), [single](2 * $r), [single](2 * $r)); $bg.Dispose()
        $ring = New-Object System.Drawing.Pen((Col 190 50 60 255), [single]($size * 0.05)); $g.DrawEllipse($ring, [single]($cx - $r), [single]($cy - $r), [single](2 * $r), [single](2 * $r)); $ring.Dispose()
        $book = New-Object System.Drawing.Pen((Col 190 50 60 255), [single]($size * 0.035))
        $left = @(
            (New-Object System.Drawing.PointF([single]($cx - $size*0.24), [single]($cy - $size*0.13))),
            (New-Object System.Drawing.PointF([single]($cx - $size*0.02), [single]($cy - $size*0.18))),
            (New-Object System.Drawing.PointF([single]($cx - $size*0.02), [single]($cy + $size*0.16))),
            (New-Object System.Drawing.PointF([single]($cx - $size*0.24), [single]($cy + $size*0.21)))
        )
        $g.DrawLines($book, [System.Drawing.PointF[]]$left)
        $right = @(
            (New-Object System.Drawing.PointF([single]($cx + $size*0.02), [single]($cy - $size*0.18))),
            (New-Object System.Drawing.PointF([single]($cx + $size*0.24), [single]($cy - $size*0.13))),
            (New-Object System.Drawing.PointF([single]($cx + $size*0.24), [single]($cy + $size*0.21))),
            (New-Object System.Drawing.PointF([single]($cx + $size*0.02), [single]($cy + $size*0.16)))
        )
        $g.DrawLines($book, [System.Drawing.PointF[]]$right)
        $g.DrawLine($book, [single]($cx), [single]($cy - $size*0.17), [single]($cx), [single]($cy + $size*0.17))
        $book.Dispose()
    }
    else {
        # Sacred Domain: pale field, golden halo and eight-point star
        $bg = New-Object System.Drawing.SolidBrush((Col 246 240 224 255)); $g.FillEllipse($bg, [single]($cx - $r), [single]($cy - $r), [single](2 * $r), [single](2 * $r)); $bg.Dispose()
        $ring = New-Object System.Drawing.Pen((Col 214 180 60 255), [single]($size * 0.05)); $g.DrawEllipse($ring, [single]($cx - $r), [single]($cy - $r), [single](2 * $r), [single](2 * $r)); $ring.Dispose()
        $halo = New-Object System.Drawing.Pen((Col 230 200 70 230), [single]($size * 0.022)); $g.DrawEllipse($halo, [single]($cx - $size*0.26), [single]($cy - $size*0.26), [single]($size*0.52), [single]($size*0.52)); $halo.Dispose()
        $star = New-Object System.Drawing.SolidBrush((Col 214 180 60 255))
        $pts = @()
        for ($i = 0; $i -lt 16; $i++) {
            $ang = -[Math]::PI / 2 + $i * [Math]::PI / 8
            $rr = if ($i % 2 -eq 0) { $size * 0.23 } else { $size * 0.09 }
            $pts += New-Object System.Drawing.PointF([single]($cx + $rr * [Math]::Cos($ang)), [single]($cy + $rr * [Math]::Sin($ang)))
        }
        $g.FillPolygon($star, [System.Drawing.PointF[]]$pts); $star.Dispose()
        $core = New-Object System.Drawing.SolidBrush((Col 255 255 250 255)); $g.FillEllipse($core, [single]($cx - $size*0.045), [single]($cy - $size*0.045), [single]($size*0.09), [single]($size*0.09)); $core.Dispose()
    }
    $g.Dispose()
    WriteDds $bmp $path
    return $bmp
}

foreach ($id in 6..8) {
    $bmp = Draw-Emblem678 $id 60 (Join-Path $outDir ("ms_member_$id.dds"))
    $bmp.Dispose()
    $bmp = Draw-Emblem678 $id 72 (Join-Path $outDir ("ms_member_${id}_large.dds"))
    $bmp.Dispose()
    $bmp = Draw-Emblem678 $id 32 (Join-Path $outDir ("ms_member_${id}_small.dds"))
    $bmp.Save((Join-Path $prevDir ("ms_member_${id}_preview.png")), [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
    Write-Output ("member $id icons done")
}
