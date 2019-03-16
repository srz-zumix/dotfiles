Set-ExecutionPolicy RemoteSigned

function Do-Install
{
    param($name)
    $options = [string]::Join(" ", $args)
    Invoke-Expression "Install-Package $name $options"
}

Install-PackageProvider Chocolatey -Force
Install-PackageProvider nuget -Force

Do-Install winmerge-jp
Do-Install ilmerge
Do-Install 7zip
Do-Install hub
Do-Install tortoisegit

#Do-Install VisualStudioCode
#Do-Install sourcetree
