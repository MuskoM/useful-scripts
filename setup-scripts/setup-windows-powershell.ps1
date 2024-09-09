$packages = @(
	"Git.Git",
	"eza-community.eza",
	"sharkdp.bat",
	"ajeetdsouza.zoxide",
	"fzf",
	"Starship.Starship"
)

# Install each package using winget if not already installed

foreach ($package in $packages) {
		try {
			Write-Host "Installing $package..."
			winget install --id $package --exact --silent --accept-source-agreements --accept-package-agreements
			Write-Host "$package installed successfully."
		} catch {
			Write-Host "Failed to install $package. Error: $_"
		}
}

# Install Powershell Modules 
try {
	Write-Host "Installing powershell modules"
	Install-Module -Name Terminal-Icons -Repository PSGallery
	Install-Module -Name PSFzf
	Write-Host "Installed all powershell Modules"
} catch {
	Write-Host "Failed to install powershell modules. Error: $_"
}

# Define the source and destination for the profile file
$sourceProfilePath = "resources\profile.ps1"
$destinationProfilePath = "$HOME\profile.ps1"

# Define the source and destination for the profile file
try {
	Copy-Item -Path $sourceProfilePath - Destination $destinationProfilePath
	Write-Host "Profile file copied successfully to $HOME."
} catch {
	Write-Host "Failed to copy profile file. Error: $_"
}
