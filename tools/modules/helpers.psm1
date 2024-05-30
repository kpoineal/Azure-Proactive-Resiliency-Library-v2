function Test-Requirements {
  # Install required modules
    Test-ModuleRequirement
    Test-GitRequirement
    }

Function Test-ModuleRequirement {
  # Install required modules
  try
    {
      Write-Progress -Activity "Testing Module Requirements" -Status "Checking if Az.ResourceGraph Module is installed.." -PercentComplete 10
      $AzModules = Get-Module -Name Az.ResourceGraph -ListAvailable -ErrorAction silentlycontinue
      if ($null -eq $AzModules)
        {
          Write-Progress -Activity "Testing Module Requirements" -Status "Installing Az.ResourceGraph Module.." -PercentComplete 20
          Install-Module -Name Az.ResourceGraph -SkipPublisherCheck -InformationAction SilentlyContinue
        }
    }
  catch
    {
      # Report Error
      $errorMessage = $_.Exception.Message
      Write-Error "Error executing function Requirements: $errorMessage"
    }
}

# Function to test if Git is installed
Function Test-GitRequirement {

  try
    {
      Write-Progress -Activity "Testing Module Requirements" -Status "Checking if Git is installed.." -PercentComplete 30

      $GitVersion = git --version

      if ($null -eq $GitVersion)
        {
          Write-Progress -Activity "Testing Git Requirements" -Status "Git is not installed. Exiting Program." -Completed
          Exit
        }
      elseif ($GitVersion -like "git version*")
        {
          Write-Progress -Activity "Testing Git Requirements" -Status "Git is installed." -PercentComplete 100
        }
    }
  catch
    {
      # Report Error
      $errorMessage = $_.Exception.Message
      Write-Error "Error executing function Requirements: $errorMessage"
    }


}


