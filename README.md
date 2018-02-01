# PowerShell-ActiveDirectory-environment
PowerShell script that deploys an AD domain controller with users and groups

In order to run this script, you will need to create an EnvironmentDeployment Folder in the root of the C:\ on the target server and place these two files in that folder.  This folder contains two files, firstly, a .csv file which contains the user accounts that will be injected into the Active Directory database and the script itself.

Let’s get started - The script is a function based script which lets you select which stage of the deployment you would like to undertake.

•	Open the script called deploy.ps1 from the c:\EnvironmentDeploy folder.
•	Press the run button (This is the play button at the top of the screen)
•	You will be presented with a pop-up box asking you which action you would like to perform.  Select the action you require and click the OK button.

•	Sit back and let the script do its magic.  Repeat these steps for every function you would like to perform

N.B – Some functions will not work unless their dependency functions have previously been run.  
