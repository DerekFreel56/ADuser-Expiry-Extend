# Import The Active Directory Module. 
Import-Module ActiveDirectory

# CSV File Path which contain user Information.
$CsvFilePath = "C:\Users\Admin\Downloads\abc.csv"

# Read User Info from CSV File. 
$userdata = Import-Csv $CsvFilePath

# Function to set account expiration For AD Users
function Set-ADUserExpiryDate {
    param (
        [String]$username,
        [int]$daytoadd
        )

        $user = Get-ADUser -Identity $username

        if ($user) {
            $expiryDate = (Get-Date).AddDays($daytoadd)
            Set-ADAccountExpiration -Identity $username -DateTime $expiryDate
            Write-Host "Account Experiation date set for $username $expiryDate"
        } else { 
            Write-Host "User $username not found in AD."
        }
    }
    
# Loop through each user in the CSV and set the expiration Date
 foreach ($user in $userdata) {
    Set-ADUserExpiryDate -username $user.username -daytoadd 90
}