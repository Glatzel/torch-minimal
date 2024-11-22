param($version = "")
if($version -eq '')
{
    $version=gh release view -R pytorch/pytorch --json tagName -q .tagName
}
Set-Location $PSScriptRoot
Set-Location ..

Remove-Item pytorch -Force -Recurse -ErrorAction SilentlyContinue
New-Item pytorch -ItemType Directory

Write-Output "::group::clone torch"
git clone https://github.com/pytorch/pytorch.git
Set-Location pytorch
git checkout tags/$version -b $version-branch
git submodule sync
git submodule update --init --recursive
Set-Location ..
Write-Output "::endgroup::"
