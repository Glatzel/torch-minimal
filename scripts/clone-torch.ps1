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
Write-Output "::endgroup::"
Set-Location pytorch
Write-Output "::group::checkout"
git checkout tags/$version -b $version-branch
Write-Output "::endgroup::"
Write-Output "::group::submodule"
git submodule sync
git submodule update --init --recursive
Write-Output "::endgroup::"
