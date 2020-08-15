Describe 'Making sure Pester works' {
    it 'should return true' {
        $true | Should -be $true
    }
}

Describe 'Get-DpkgPackage' {
    it 'has copied the dpkgPackage module and is available' {
        { Import-Module -Name DpkgPackage -ErrorAction Stop } | Should -not -Throw
    }

    it 'queries dpkg for the powershell package' {
        { Get-DpkgPackage -Name PowerShell -ErrorAction Stop } | Should -not -Throw
    }

    it 'finds the powershell dpkg package installed' {
        Get-DpkgPackage -Name PowerShell | Should -not -BeNullOrEmpty
    }

    it 'finds the installed dpkg package powershell (only name/version) with version 7.xxx' {
        (Get-DpkgInstalledPackage -Name powershell).Version | Should -BeLike '7.*'
    }
}
