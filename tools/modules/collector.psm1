Function Get-AllAzGraphResources {
  param (
    [string]$subscriptionId,
    [string]$query = 'Resources | project id, resourceGroup, subscriptionId, name, type, location, properties'
  )

  if ([bool]$subscriptionId) {
    $result = Search-AzGraph -Query $query -SkipToken $result.SkipToken -Subscription $subscriptionId -First 1000
  } else {
    $result = Search-AzGraph -Query $query -SkipToken $result.SkipToken -first 1000
  } # -first 1000 returns the first 1000 results and subsequently reduces the amount of queries required to get data.

  # Collection to store all resources
  $allResources = @($result)

  # Loop to paginate through the results using the skip token
  while ($result.SkipToken) {
    # Retrieve the next set of results using the skip token
    if ([bool]$subscriptionId) {
      $result = Search-AzGraph -Query $query -SkipToken $result.SkipToken -Subscription $subscriptionId -First 1000
    } else {
      $result = Search-AzGraph -Query $query -SkipToken $result.SkipToken -First 1000
    }
    # Add the results to the collection
    $allResources += $result
  }

  # Output all resources
  return $allResources
}




