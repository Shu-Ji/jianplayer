/**
 * This file is used specifically and only for development. It installs
 * `electron-debug` & `vue-devtools`. There shouldn't be any need to
 *  modify this file, but it can be used to extend your development
 *  environment.
 */

let electron = require('electron')
let request = require('request')
let fs = require('fs')
let execSync = require('child_process').execSync
let path = require('path')


require('electron-debug')({ showDevTools: 'undocked' })

// Set environment for development
process.env.NODE_ENV = 'development'

// Install `electron-debug` with `devtron`
// Since frameless window with dev tools has some unknown bug,
// so we make devtools show floated


function downloadFile(url, filename, callback){
    let stream = fs.createWriteStream(filename);
    request(url).pipe(stream).on('close', callback);
}


// Install `vue-devtools`
electron.app.on('ready', () => {
    // since chrome-store is blocked in china
    // so we cached some tools on qiniu.com
    (function downloadVueDevTools(){

        function install(extension_path){
            electron.BrowserWindow.addDevToolsExtension(extension_path)
        }

        let dirname = path.join(__dirname, '../../build/')
        let filename = path.join(dirname, 'vue-devtools-v3.1.6_0.tgz')
        let extension_path = path.join(dirname, 'vue_dev_tools')

        // already downloaded
        if(fs.existsSync(filename)){
            install(extension_path)
        } else {
            let url = 'http://ibed.u.qiniudn.com/electron/dev-tools-extentions/vue-devtools-v3.1.6_0.tgz'
            downloadFile(url, filename, function(){
                install(extension_path)
            })
        }
    })()
})

// Require `main` process to boot app
require('./index')
