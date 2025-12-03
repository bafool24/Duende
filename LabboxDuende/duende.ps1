Add-Type -AssemblyName PresentationFramework,PresentationCore,WindowsBase,System.Windows.Forms

# Rutas de archivos
$imagePath = "C:\DuendePrueba\duende.png"
$soundPath = "C:\DuendePrueba\duende.wav" 

# Cargar imagen
$bitmap = New-Object System.Windows.Media.Imaging.BitmapImage
$bitmap.BeginInit()
$bitmap.UriSource = $imagePath
$bitmap.CacheOption = "OnLoad"
$bitmap.EndInit()

# Cargar sonido usando MediaPlayer
$player = New-Object System.Windows.Media.MediaPlayer
$player.Open($soundPath)

# Pantallas
$screens = [System.Windows.Forms.Screen]::AllScreens
$windows = @()

foreach ($screen in $screens) {

    $window = New-Object System.Windows.Window
    $window.WindowStyle = 'None'
    $window.ResizeMode = 'NoResize'
    $window.Topmost = $true
    $window.ShowInTaskbar = $false

    $window.Left   = $screen.Bounds.X
    $window.Top    = $screen.Bounds.Y
    $window.Width  = $screen.Bounds.Width
    $window.Height = $screen.Bounds.Height

    $grid = New-Object System.Windows.Controls.Grid

    $img = New-Object System.Windows.Controls.Image
    $img.Source = $bitmap
    $img.Stretch = 'UniformToFill'
    $grid.Children.Add($img)

    $title = New-Object System.Windows.Controls.TextBlock
    $title.Text = " LABBOX ALERTA `nEl duende travieso ha intervenido tu PC."
    $title.Foreground = 'White'
    $title.FontSize = 42
    $title.FontWeight = 'Bold'
    $title.HorizontalAlignment = 'Center'
    $title.VerticalAlignment = 'Top'
    $title.Margin = '0,50,0,0'
    $grid.Children.Add($title)

    $window.Content = $grid
    $windows += $window
}

# Mostrar ventanas
foreach ($w in $windows) { $w.Show() }

# Iniciar sonido
$player.Volume = 1.0
$player.Play()

# Mantener 12 segundos
Start-Sleep -Seconds 12

# Detener sonido
$player.Stop()

# Cerrar ventanas
foreach ($w in $windows) { $w.Close() }

[System.Windows.Threading.Dispatcher]::ExitAllFrames()

