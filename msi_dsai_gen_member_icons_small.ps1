Add-Type -AssemblyName System.Drawing
$ErrorActionPreference = 'Stop'

$mod = "E:\Documents\Paradox Interactive\Stellaris\mod\Ethics and Civics Infinity"
$dir = Join-Path $mod "gfx\interface\icons\msi_dsai"
$prev = Join-Path $mod "_icon_analysis"
$small = 32

function Read-Dds([string]$path) {
    $b = [System.IO.File]::ReadAllBytes($path)
    $w = [BitConverter]::ToInt32($b, 16)
    $h = [BitConverter]::ToInt32($b, 12)
    $bmp = New-Object System.Drawing.Bitmap -ArgumentList $w, $h
    $off = 128
    for ($y = 0; $y -lt $h; $y++) {
        for ($x = 0; $x -lt $w; $x++) {
            $i = $off + ($y * $w + $x) * 4
            $c = [System.Drawing.Color]::FromArgb([int]$b[$i + 3], [int]$b[$i + 2], [int]$b[$i + 1], [int]$b[$i])
            $bmp.SetPixel($x, $y, $c)
        }
    }
    return $bmp
}

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

for ($i = 1; $i -le 5; $i++) {
    $src = Join-Path $dir ("ms_member_" + $i + ".dds")
    $img = Read-Dds $src
    $dst = New-Object System.Drawing.Bitmap -ArgumentList $small, $small
    $g = [System.Drawing.Graphics]::FromImage($dst)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.DrawImage($img, 0, 0, $small, $small)
    $g.Dispose()
    $img.Dispose()
    $out = Join-Path $dir ("ms_member_" + $i + "_small.dds")
    WriteDds $dst $out
    $dst.Save((Join-Path $prev ("ms_member_" + $i + "_small_preview.png")), [System.Drawing.Imaging.ImageFormat]::Png)
    $dst.Dispose()
    Write-Output ("small icon " + $i + " done: " + (Get-Item $out).Length + " bytes")
}
