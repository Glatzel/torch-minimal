param( $pixi_python_env = "py311",$version = "" )
if($version -eq '')
{
    $version=gh release view -R pytorch/pytorch --json tagName -q .tagName
}
Write-Host $version
Set-Location $PSScriptRoot
Set-Location ..

$env:BUILD_TEST=0
$env:USE_CUDA=0
$env:USE_CUDNN=0
$env:USE_DISTRIBUTED=0
$env:USE_MKLDNN=0
$env:USE_NCCL=0
$env:USE_NINJA=1
$env:USE_QNNPACK=0
$env:USE_QNNPACK=0
$env:USE_TENSORPIPE=0

Set-Location pytorch
$version > version.txt
Remove-Item */CMakeCache.txt -ErrorAction SilentlyContinue
pixi run -e "$pixi_python_env" python setup.py develop

