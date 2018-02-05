# cJEAConfiguration Resource #
This is a Desired State Configuration resource that'll help you configure a JEA Configuration on your Windows Servers.

It's build and designed for PowerShell v4 & v5.

To have more information on what is JEA please refer to that website https://docs.microsoft.com/en-US/powershell/jea/overview

## How install it ? ##
In order to install it, just downlooad the zip from Github and extract it in your Powershell Module Path.


## What resources are available ? ##
Right now there only one resource available:

1. cJEAConfiguration - It'll create/update the JEA Configuration on your server. 

## How to use them ? ##
here is an example of what can be done.


    Configuration Test {
     
    	     Import-DscResource -ModuleName cJEAConfiguration
    		
            #Calculate the credential you want to use in the JEA configuration.
	        $securePassword = ConvertTo-SecureString -AsPlainText "MyPassword" -Force
	        $Cred = New-Object System.Management.Automation.PSCredential("mydomain\mysuer", $securePassword)

            Node localhost {
    			     
			    cJEAConfiguration JEAMaintenance {
			        EndpointName = "JEAMaintenance"
			        ConfigurationAccount = $Cred
		        }  
			}
	    }
    }

## Further Development ##

Actually the module only create or update the configuration (mainly change the credential used on the JEA connection). The ability to
to delete the configuration shoud be added with a Ensure like parameter
