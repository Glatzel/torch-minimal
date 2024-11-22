param( $pixi_python_env = "py311", $version = "" )
if ($version -eq '') {
    $version = gh release view -R pytorch/pytorch --json tagName -q .tagName
}
Write-Host $version
Set-Location $PSScriptRoot
Set-Location ..

$env:BUILD_TEST = "OFF"
$env:USE_CUDA = "OFF"
$env:USE_CUDNN = "OFF"
$env:USE_DISTRIBUTED = "OFF"
$env:USE_FBGEMM = "OFF"
$env:USE_GLOO = "OFF"
$env:USE_KINETO = "OFF"
$env:USE_MKLDNN = "OFF"
$env:USE_NCCL = "OFF"
$env:USE_OPENMP = "ON"
$env:USE_TENSORPIPE = "OFF"
$env:USE_XNNPACK = "OFF"

Set-Location pytorch
"$version" -replace "v","" > version.txt
Write-Output "::group::clean"
pixi clean
pixi run -e "$pixi_python_env" python setup.py clean
Write-Output "::endgroup::"
Write-Output "::group::install"
pixi run -e "$pixi_python_env" python setup.py install
Write-Output "::endgroup::"
Write-Output "::group::build wheel"
pixi run -e "$pixi_python_env" python setup.py bdist_wheel
Write-Output "::endgroup::"