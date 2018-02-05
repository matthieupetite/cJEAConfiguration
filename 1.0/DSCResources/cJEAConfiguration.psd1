@{

ModuleVersion = '1.0'

GUID = 'F18632B3-A938-4D09-A1C3-0C4CAFD01790'

Author = 'Matthieu PETITE'

Description = 'Module with DSC Resources for handling SNMP configurations'

PowerShellVersion = '5.0'

CLRVersion = '5.0'

PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = @('DesiredStateConfiguration', 'DSC', 'DSCResourceKit', 'DSCResource')

        # A URL to the license for this module.
        LicenseUri = ''

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/matthieupetite/cJEAConfiguration'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        ReleaseNotes = 'Updated manifest for PSGallery publish'

    } # End of PSData hashtable

} # End of PrivateData hashtable

# Functions to export from this module
FunctionsToExport = '*'

# Cmdlets to export from this module
CmdletsToExport = '*'
}

