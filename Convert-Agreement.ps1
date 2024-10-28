# import original agreement
# gather a list of all unique names in the "Company Name" column
# for each company name in the unique list, identify each row in the original agreement that contains that company name and create a sum of the "Amount" column for that company

# Import the original agreement
$agreement = Import-Csv -Path "$env:USERPROFILE\Downloads\Agreement MRR.csv"

# Gather a list of all unique names in the "Company Name" column
$uniqueNames = $agreement | Select-Object -ExpandProperty "Company Name" | Sort-Object -Unique

# For each company name in the unique list, identify each row in the original agreement that contains that company name and create a sum of the "Amount" column for that company
$companySums = @{}
foreach ($name in $uniqueNames) {
    $companyRows = $agreement | Where-Object { $_."Company Name" -eq $name }
    $sum = ($companyRows | Measure-Object -Property "Amount" -Sum).Sum
    $companySums[$name] = $sum
}

# convert the hashtable to a custom object
$companySums = $companySums.GetEnumerator() | ForEach-Object {
    [PSCustomObject]@{
        "Company Name" = $_.Key
        "Amount Sum" = $_.Value
    }
}

# Output the results
$companySums | Export-Csv -Path $env:USERPROFILE\downloads\CompanySums.csv -NoTypeInformation
