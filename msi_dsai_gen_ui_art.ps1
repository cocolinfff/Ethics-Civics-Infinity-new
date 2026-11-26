Add-Type -AssemblyName System.Drawing
$ErrorActionPreference = 'Stop'

$mod = "E:\Documents\Paradox Interactive\Stellaris\mod\Ethics and Civics Infinity"
$outDir = Join-Path $mod "gfx\interface\msi_dsai"
New-Item -ItemType Directory -Force -Path $outDir | Out-Null

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

# ---- panel background: 400x240 cornered tile ----
$bg = New-Object System.Drawing.Bitmap -ArgumentList 400, 240
$g = [System.Drawing.Graphics]::FromImage($bg)
$g.Clear([System.Drawing.Color]::FromArgb(255, 7, 16, 21))
$fill1 = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255, 9, 22, 28))
$g.FillRectangle($fill1, 0, 0, 400, 120)
$fill2 = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255, 7, 17, 22))
$g.FillRectangle($fill2, 0, 120, 400, 120)
$grid = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(16, 60, 180, 170), [single]1.0)
for ($x = 0; $x -lt 400; $x += 20) { $g.DrawLine($grid, $x, 0, $x, 240) }
for ($y = 0; $y -lt 240; $y += 20) { $g.DrawLine($grid, 0, $y, 400, $y) }
$edge = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(220, 46, 190, 178), [single]2.0)
$g.DrawRectangle($edge, 1, 1, 397, 237)
$g.Dispose()
WriteDds $bg (Join-Path $outDir "bg_assembly.dds")
$bg.Save((Join-Path $mod "_icon_analysis\bg_assembly_preview.png"), [System.Drawing.Imaging.ImageFormat]::Png)
$bg.Dispose()

# ---- member card: 200x80 cornered tile ----
$card = New-Object System.Drawing.Bitmap -ArgumentList 200, 80
$g = [System.Drawing.Graphics]::FromImage($card)
$g.Clear([System.Drawing.Color]::FromArgb(0, 0, 0, 0))
$cb = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(235, 10, 24, 30))
$g.FillRectangle($cb, 1, 1, 197, 77)
$cp = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(200, 40, 150, 145), [single]1.0)
$g.DrawRectangle($cp, 1, 1, 197, 77)
$bar = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255, 60, 220, 205))
$g.FillRectangle($bar, 0, 0, 4, 80)
$g.Dispose()
WriteDds $card (Join-Path $outDir "card_member.dds")
$card.Save((Join-Path $mod "_icon_analysis\card_member_preview.png"), [System.Drawing.Imaging.ImageFormat]::Png)
$card.Dispose()

# ---- action button: 180x34 ----
$btn = New-Object System.Drawing.Bitmap -ArgumentList 180, 34
$g = [System.Drawing.Graphics]::FromImage($btn)
$g.Clear([System.Drawing.Color]::FromArgb(0, 0, 0, 0))
$bb = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(240, 16, 40, 46))
$g.FillRectangle($bb, 0, 0, 179, 33)
$bp = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(210, 46, 190, 178), [single]1.0)
$g.DrawRectangle($bp, 0, 0, 179, 33)
$g.Dispose()
WriteDds $btn (Join-Path $outDir "btn_action.dds")
$btn.Save((Join-Path $mod "_icon_analysis\btn_action_preview.png"), [System.Drawing.Imaging.ImageFormat]::Png)
$btn.Dispose()

Write-Output "art done"
Get-ChildItem $outDir -Filter *.dds | ForEach-Object { Write-Output ("  " + $_.Name + " " + $_.Length) }
