$ADGroup=@()
$ADOU=@()
$ADSubOU=@()

cd C:\EnvironmentDeployment

function Install-ADDS

    {
        Write-Host "Installing Active Directory Domain Services" -ForegroundColor Yellow -BackgroundColor Black
        Install-WindowsFeature -Name AD-Domain-Services `
        -IncludeAllSubFeature `
        -IncludeManagementTools `
        -Verbose

    }

function Promote-DC

    {
        Write-Host "Promoting Server to Domain Controller" -ForegroundColor Yellow -BackgroundColor Black
        Import-Module ADDSDeployment
        Install-ADDSForest `
        -CreateDnsDelegation:$false `
        -DatabasePath "C:\Windows\NTDS" `
        -DomainMode "Win2012R2" `
        -DomainName "example.com" `
        -DomainNetbiosName "EXAMPLE" `
        -ForestMode "Win2012R2" `
        -InstallDns:$true `
        -LogPath "C:\Windows\NTDS" `
        -NoRebootOnCompletion:$false `
        -SysvolPath "C:\Windows\SYSVOL" `
        -Force:$true `
        -Verbose

    }

function Create-TestUsers

    {

        Write-Host "Creating 1100 Test Users" -ForegroundColor Yellow -BackgroundColor Black
        Write-Host "This might take a while - Go and grab a coffee" -ForegroundColor Red -BackgroundColor Yellow
        Write-Host "Except if you're Rob - Rob doesn't do Coffee :-)" -ForegroundColor Red -BackgroundColor Yellow
        $Users = Import-Csv -Delimiter "," -Path "C:\EnvironmentDeployment\test_env_users.csv"            
        
        ForEach ($User in $Users)            
            
            {            
                $Displayname = $User.Firstname + " " + $User.Lastname            
                $UserFirstname = $User.Firstname            
                $UserLastname = $User.Lastname            
                $OU = $User.OU           
                $SAM = $User.SAM            
                $UPN = $User.Maildomain            
                $Description = $User.Description            
                $Password = $User.Password            
                New-ADUser -Name $Displayname -DisplayName $Displayname `
                -SamAccountName $SAM -UserPrincipalName $UPN `
                -GivenName $UserFirstname -Surname $UserLastname `
                -Description $Description `
                -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) `
                -Enabled $true -Path "$OU" -ChangePasswordAtLogon $false –PasswordNeverExpires $true `
                -server test.sme -Verbose            
            }

    }

function Create-TestOUs

    {
        Write-Host "Creating Test Organisational Units" -ForegroundColor Yellow -BackgroundColor Black
        $ADSubOU=@("Users","Groups","Computers")
        $Global:ADSubOU = $ADSubOU
        $OUPath="OU=SME,DC=test,DC=sme"
        New-ADOrganizationalUnit -Name Example -Verbose
        
        foreach ($SubOU in $ADSubOU)
            
            {
                
                New-ADOrganizationalUnit -Name $SubOU -Path $OUPath -ErrorAction SilentlyContinue -Verbose
            
            }


    }


function Create-SecurityGroups
    
    {
        Write-Host "Creating Test Secuirty Groups" -ForegroundColor Yellow -BackgroundColor Black
        $ADGroup=@("DevOps","Engineering","Sales","Finance","QAT","Development","Management","Senior Management")
        $Global:ADGroup = $ADGroup
        $GroupPath="OU=Groups,OU=Example,DC=example,DC=com"
            foreach ($Group in $ADGroup)
                {
    
                    New-ADGroup -Name $Group -Path $GroupPath -GroupScope Global -GroupCategory Security -Verbose
    
                }
    }



function Add-UsersEmailAddress

    {
        $file = Import-Csv "C:\EnvironmentDeployment\test_env_users.csv"

            foreach ($user in $file)

                {

                    $sam = $User.sam
                    $email = $user.emailaddress
                    Write-Output "Setting $sam to have an email address of: $email"
                    set-aduser -identity $sam -emailaddress -$email


                }

    }


function Assign-UsersToGroups

    {
        $Rob = Get-ADUser -Filter {name -like "*Rob*"}
        $James = Get-ADUser -Filter {name -like "*James*"}
        $Jim = Get-ADUser -Filter {name -like "*Jim*"}
        $Zim = Get-ADUser -Filter {name -like "*Zim*"}
        $Javier = Get-ADUser -Filter {name -like "*Javier*"}
        $Dan = Get-ADUser -Filter {name -like "*Dan*"}
        $Caroline = Get-ADUser -Filter {name -like "*Caroline*"}
        $Ana = Get-ADUser -Filter {name -like "*Ana*"}
        $Asha = Get-ADUser -Filter {name -like "*Asha*"}
        $Amanda = Get-ADUser -Filter {name -like "*Amanda*"}
        $Erik = Get-ADUser -Filter {name -like "*Erik*"}
        $Doug = Get-ADUser -Filter {name -like "*Doug*"}
        $Giada = Get-ADUser -Filter {name -like "*Giada*"}
        $kim = Get-ADUser -Filter {name -like "*kim*"}
        $Steve = Get-ADUser -Filter {name -like "*Steve*"}
        $Ron = Get-ADUser -Filter {name -like "*Ron*"}
        $Vanja = Get-ADUser -Filter {name -like "*Vanja*"}
        $Roman = Get-ADUser -Filter {name -like "*Roman*"}
        $Igor = Get-ADUser -Filter {name -like "*Igor*"}
        $Leo = Get-ADUser -Filter {name -like "*Leo*"}
        $Andrew = Get-ADUser -Filter {name -like "*Andrew*"}
        $Yura = Get-ADUser -Filter {name -like "*Yura*"}

            foreach ($Robert in $Rob)

                {
                    Add-ADGroupMember -Identity "DevOps" -Members $Rob -Verbose

                }


            foreach ($Jame in $James)

                {
                    Add-ADGroupMember -Identity "Development" -Members $James -Verbose

                }


            foreach ($Ji in $Jim)

                {
                    Add-ADGroupMember -Identity "Senior Management" -Members $Jim -Verbose

                }


            foreach ($Zi in $Zim)

                {
                    Add-ADGroupMember -Identity "Management" -Members $Zim -Verbose

                }



            foreach ($Javi in $Javier)

                {
                    Add-ADGroupMember -Identity "QAT" -Members $Javier -Verbose

                }

            foreach ($Daniel in $Dan)

                {
                    Add-ADGroupMember -Identity "Engineering" -Members $Dan -Verbose

                }

            foreach ($Carol in $Caroline)

                {
                    Add-ADGroupMember -Identity "Finance" -Members $Caroline -Verbose

                }

            foreach ($Ann in $Ana)

                {
                    Add-ADGroupMember -Identity "QAT" -Members $Ana -Verbose

                }


            foreach ($Ash in $Asha)

                {
                    Add-ADGroupMember -Identity "QAT" -Members $Asha -Verbose

                }


            foreach ($Aman in $Amanda)

                {
                    Add-ADGroupMember -Identity "Management" -Members $Amanda -Verbose

                }

            foreach ($Eri in $Erik)

                {
                    Add-ADGroupMember -Identity "DevOps" -Members $Erik -Verbose

                }

            foreach ($Eri in $Erik)

                {
                    Add-ADGroupMember -Identity "Engineering" -Members $Erik -Verbose

                }

            foreach ($Eri in $Erik)

                {
                    Add-ADGroupMember -Identity "Management" -Members $Erik -Verbose

                }


            foreach ($Douglas in $Doug)

                {
                    Add-ADGroupMember -Identity "Engineering" -Members $Doug -Verbose

                }

            foreach ($Gi in $Giada)

                {
                    Add-ADGroupMember -Identity "Sales" -Members $Giada -Verbose

                }

            foreach ($Ki in $Kim)

                {
                    Add-ADGroupMember -Identity "Sales" -Members $Kim -Verbose

                }

            foreach ($Lee in $Leo)

                {
                    Add-ADGroupMember -Identity "Development" -Members $Leo -Verbose

                }

            foreach ($Steven in $Steve)

                {
                    Add-ADGroupMember -Identity "Sales" -Members $Steve -Verbose

                }

            foreach ($Yu in $Yura)

                {
                    Add-ADGroupMember -Identity "Development" -Members $Yura -Verbose

                }

            foreach ($Ronald in $Ron)

                {
                    Add-ADGroupMember -Identity "Sales" -Members $Ron -Verbose

                }

            foreach ($Van in $Vanja)

                {
                    Add-ADGroupMember -Identity "Development" -Members $Vanja -Verbose

                }

            foreach ($Rom in $Roman)

                {
                    Add-ADGroupMember -Identity "Development" -Members $Roman -Verbose

                }

            foreach ($Iggy in $Igor)

                {
                    Add-ADGroupMember -Identity "Development" -Members $Igor -Verbose

                }

            foreach ($Iggy in $Igor)

                {
                    Add-ADGroupMember -Identity "Development" -Members $Igor -Verbose

                }

            foreach ($Andy in $Andrew)

                {
                    Add-ADGroupMember -Identity "Development" -Members $Andrew -Verbose

                }

    }



$Action = @("Install Active Directory Domain services","Promote Server to domain controller","Inject Test Users, Groups and OUs into domain","Add Test Users into Security Groups","Exit")
$Action = $Action | Out-GridView -PassThru

Switch ($Action)
    {
        "Install Active Directory Domain services"
            
            {
                
                Install-ADDS
            
            }


        "Promote Server to domain controller"

            {
                
                Promote-DC
            
            }

        "Inject Test Users, Groups and OUs into domain"

            {
                
                Create-TestOUs
                Create-SecurityGroups
                Create-TestUsers
                Add-UsersEmailAddress

            
            }

        "Add Test Users into Security Groups"

            {
                Assign-UsersToGroups

            }

        default
            {
                Write-Host "You have not selected an action" -ForegroundColor Yellow
                Exit
            }


        "Exit"

            {
            
                Write-Host "Goodbye" -ForegroundColor Red
                Exit
            
            }


    }



