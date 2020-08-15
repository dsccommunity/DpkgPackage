function Get-DpkgPackage
{
    [CmdletBinding(DefaultParameterSetName = 'dpkgInstalledPackage')]
    param
    (
        [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, ParameterSetName = 'dpkgInstalledPackage', Position = 0)]
        [Alias('Package')]
        [string[]]
        $Name,

        [Parameter(ValueFromPipelineByPropertyName, ParameterSetName = 'dpkgFile', Position = 0)]
        $Path
    )

    process
    {

        switch ($PSCmdlet.ParameterSetName)
        {
            'dpkgInstalledPackage' {
                $PackageToParse = { Get-DpkgInstalledPackage -Name $Name | Where-Object {$null -ne $_.Version} }
            }

            'dpkgFile'  {
                $PackageToParse = { Get-Item -Path $Path }
            }
        }

        &$PackageToParse | ForEach-Object {
            if ($_ -is [System.IO.FileInfo])
            {
                # dpkg --info ./localpackage.deb for getting info of non-installed package
                $dpkgParams = (Get-DpkgCmdArgument -Info $_.FullName)
            }
            else
            {
                # dpkg --status packageName for having details of the installed package
                $dpkgParams = (Get-DpkgCmdArgument -Status $_.Name)
            }

            Write-Verbose "Fetching details for '$($_.Name)'"
            $GetPropertyHashFromListOutputParams = @{
                AllowedPropertyName     = ([DpkgPackage].GetProperties().Name)
                AddExtraPropertiesAsKey = 'AdditionalFields'
                ErrorVariable           = 'packageError'
            }

            $properties = Invoke-NativeCommand -Executable 'dpkg' -Parameters $dpkgParams |
                Get-PropertyHashFromListOutput @GetPropertyHashFromListOutputParams

            # Making sure we replicate the package property to Name property
            # To correctly make the Base object (Package class)
            $properties['PackageType'] = 'dpkg'
            $properties.add('Name', $properties['Package'])

            if (-not $packageError)
            {
                [DpkgPackage]$properties
            }
        }
    }
}
