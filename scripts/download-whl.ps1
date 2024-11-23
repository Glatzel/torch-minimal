param($torch_version = "",$python_version="3.11")
if($torch_version -eq '')
{
    $torch_version=gh release view -R pytorch/pytorch --json tagName -q .tagName
}
$torch_version="$torch_version" -replace "v",""
Set-Location $PSScriptRoot
Set-Location ..

Remove-Item ./download -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item ./temp -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item ./dist -Recurse -Force -ErrorAction SilentlyContinue

pixi run pip download torch==$torch_version `
    --platform win_amd64 `
    --python-version "$python_version" `
    --only-binary=:all: `
    -d ./download `
    --no-deps

Expand-Archive -Path ./download/*.whl -DestinationPath ./temp

Remove-Item ./temp/torch/lib/dnnl.lib

$whl = Get-ChildItem -Path ./download | Select-Object -First 1
$whl=$whl.Name
New-Item ./dist -ItemType Directory
Compress-Archive -Path ./temp/* -DestinationPath "./dist/$whl" -PassThru
