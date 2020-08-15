if (-not ('Package' -as [type]))
{
    class Package
    {
        $Name
        $PackageType
        $Version
        $Vendor
    }

}
