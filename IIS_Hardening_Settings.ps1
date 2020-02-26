###########################################################################################################

## This is a scriptfile that will be used for pushing IIS hardening settings
## any changes should be tested outside of this script and incorporated afterwards

## Version 1.0 - mgonzalez - Added the X-Frames-Option

###########################################################################################################


### Deny iframes via IIS. Part of IIS Hardening. Deny is the default hardening. If that's too restrictive, you can use 'sameorigin' instead
Add-WebConfigurationProperty -PSPath MACHINE/WEBROOT/APPHOST -Name . -Filter system.webServer/httpProtocol/customHeaders -AtElement @{name = "X-Frames-Options" ; value = 'deny' }


### Modifies iframes via IIS if Add-WebConfigurationProperty was already run. Part of IIS Hardening. Deny is the default hardening. If that's too restrictive, you can use 'sameorigin' instead
# Set-WebConfigurationProperty -PSPath MACHINE/WEBROOT/APPHOST -Name . -Filter system.webServer/httpProtocol/customHeaders -AtElement @{name = "X-Frames-Options" ; value = 'deny' }


### Remove this setting to Deny iframes via IIS. Part of IIS Hardening. Deny is the default hardening. If that's too restrictive, you can use 'sameorigin' instead
# Remove-WebConfigurationProperty -PSPath MACHINE/WEBROOT/APPHOST -Name . -Filter system.webServer/httpProtocol/customHeaders -AtElement @{name = "X-Frames-Options" ; value = 'deny' }

