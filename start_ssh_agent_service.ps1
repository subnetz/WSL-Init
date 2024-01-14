# Make sure you're running as an Administrator
echo ""
echo ""
echo "Before:"
echo ""
echo ""
Get-Service ssh-agent

Set-Service ssh-agent -StartupType Automatic
Start-Service ssh-agent

echo ""
echo ""
echo "After:"
echo ""
echo ""
Get-Service ssh-agent


echo ""
echo ""
echo "This window will close in 5 Seconds"

Start-Sleep 5