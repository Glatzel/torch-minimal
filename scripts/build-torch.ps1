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
pixi run python setup.py install
pixi run python -c "import torch; print(torch.__version__); print(torch.cuda.is_available())"