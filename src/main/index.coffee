import { app, BrowserWindow } from 'electron'
import { getPluginEntry } from "mpv.js"
path = require('path')


###
 * Set `__static` path to static files in production
 * https://simulatedgreg.gitbooks.io/electron-vue/content/en/using-static-assets.html
###


is_dev = process.env.NODE_ENV == 'development'
is_prod = process.env.NODE_ENV == 'production'

if not is_dev
    global.__static = path.join(__dirname, '/static').replace(/\\/g, '\\\\')


main_window = null
index_html = if is_dev then 'http://localhost:9080' else "file://#{__dirname}/index.html"


loadMpvPlugin = ->
    plugin_dir = path.join(path.dirname(eval("require.resolve('mpv.js')")), "build", "Release")
    ###
    if process.platform != "linux"
        process.chdir(plugin_dir)
    ###

    # To support a broader number of systems.
    app.commandLine.appendSwitch("ignore-gpu-blacklist")
    app.commandLine.appendSwitch("register-pepper-plugins", getPluginEntry(plugin_dir))


loadMpvPlugin()


createWindow = ->
    main_window = new BrowserWindow({
        height: 540
        width: 960
        minWidth: 960
        minHeight: 540
        frame: is_dev
        show: false
        webPreferences:
            plugins: true
    })


    main_window.once 'ready-to-show', ->
        main_window.show()


    main_window.loadURL(index_html)


    main_window.on 'closed', ->
        main_window = null


app.on('ready', createWindow)


app.on 'window-all-closed', ->
    if process.platform != 'darwin'
        app.quit()


app.on 'activate', ->
    if main_window == null
        createWindow()


###
 * Auto Updater
 *
 * Uncomment the following code below and install `electron-updater` to
 * support auto updating. Code Signing with a valid certificate is required.
 * https://simulatedgreg.gitbooks.io/electron-vue/content/en/using-electron-builder.html#auto-updating
###

###
import { autoUpdater } from 'electron-updater'


autoUpdater.on 'update-downloaded', ->
    autoUpdater.quitAndInstall()


app.on 'ready', ->
    if is_prod
        autoUpdater.checkForUpdates()
###
