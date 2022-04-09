using namespace System.Windows.Forms
using namespace System.Drawing
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$cddrive = Add-Type -MemberDefinition @"
[DllImport("winmm.dll", CharSet=CharSet.Ansi, EntryPoint="mciSendStringA")]
public static extern int mciSendStringA(string lpszCommand, string lpszReturnString, uint cchReturn, IntPtr hwndCallback);
"@ -PassThru -Name mciSendString

$form = New-Object Form
$form.Text = 'CD drive open & close'
$form.size = New-Object Size(350, 200)

$btnClose = New-Object Button
$btnClose.Location = New-Object Point(190, 80)
$btnClose.Text = "Close"
$close = {
    $cddrive::mciSendStringA("set cdaudio door closed", $null, 0, [IntPtr]::Zero)
}
$btnClose.Add_Click($close)

$btnOpen = New-Object Button
$btnOpen.Location = New-Object Point(70, 80)
$btnOpen.Text = "Open"
$open = {
    $cddrive::mciSendStringA("set cdaudio door open", $null, 0, [IntPtr]::Zero)
}
$btnOpen.Add_Click($open)

$form.Controls.Add($btnClose)
$form.Controls.Add($btnOpen)

$form.ShowDialog()