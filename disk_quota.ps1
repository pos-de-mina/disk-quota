#Requires -Version 3 
<#
 # Check_MK plugin to monitoring Windows Disk Quota.
 # 
 # FSRM WMI Classes: https://msdn.microsoft.com/en-us/library/hh706724%28v=vs.85%29.aspx
 #                   Minimum supported server - Windows Server 2012
 # 
 # (c) 2016-06-24 gestao.monitorizacao@novobancosi.pt
 #>

'<<<disk_quota:sep(9)>>>'
Get-CimInstance `
    -Namespace Root/Microsoft/Windows/FSRM `
    -ClassName MSFT_FSRMQuota `
    -Filter '(Disabled = False) And (Size >= 5000000000)' `
    -Property Path,Usage,Size,SoftLimit | % {

    "$($_.Path)`t$($_.Usage / 1048576.0)`t$($_.Size / 1048576.0)`t$(if ($_.SoftLimit) {'soft'} else {'hard'})"

}
